#!/bin/bash
# https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=azure-cli

# Variables
TENANT_ID="$1"
SUBSCRIPTION_ID="$2"
ASSIGNEE_ID="$3"
RESOURCE_GROUP_NAME="$4"
STORAGE_ACCOUNT_NAME="$5"
CONTAINER_NAME="$6"
KEYVAULT_NAME="$7"
SECRET_NAME="$8"
LOCATION="$9"

# Set the subscription
az account set --subscription "$SUBSCRIPTION_ID"

# Check if Resource Group exists
if ! az group show --name $RESOURCE_GROUP_NAME &> /dev/null; then
  echo "Creating resource group..."
  az group create --name $RESOURCE_GROUP_NAME --location $LOCATION
else
  echo "Resource group already exists."
fi

# Check if Storage Account exists
if ! az storage account show --name $STORAGE_ACCOUNT_NAME --resource-group $RESOURCE_GROUP_NAME &> /dev/null; then
  echo "Creating storage account..."
  az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob
else
  echo "Storage account already exists."
  STORAGE_ACCOUNT_NAME=$(az storage account show --name $STORAGE_ACCOUNT_NAME --resource-group $RESOURCE_GROUP_NAME --query name -o tsv)
fi

# Create Blob Container
if ! az storage container show --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME &> /dev/null; then
  echo "Creating blob container..."
  az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME
else
  echo "Blob container already exists."
fi

# Check if Key Vault exists
if ! az keyvault show --name $KEYVAULT_NAME --resource-group $RESOURCE_GROUP_NAME &> /dev/null; then
  echo "Creating Key Vault..."
  az keyvault create --name $KEYVAULT_NAME --resource-group $RESOURCE_GROUP_NAME --location $LOCATION
else
  echo "Key Vault already exists."
fi

# Assign Key Vault Secrets Officer role to the user account
az role assignment create --role "Key Vault Secrets Officer" --assignee $ASSIGNEE_ID --scope /subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP_NAME/providers/Microsoft.KeyVault/vaults/$KEYVAULT_NAME
echo "role assignment successful"

# Store Storage Account Access Key in Key Vault
ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query "[0].value" -o tsv)
echo "account key retrieval successful"
az keyvault secret set --vault-name $KEYVAULT_NAME --name "$SECRET_NAME" --value "$ACCOUNT_KEY"
echo "account key saved to keyvault"

# Retrieve the secret value from Key Vault
ACCOUNT_KEY=$(az keyvault secret show --name "$SECRET_NAME" --vault-name $KEYVAULT_NAME --query value -o tsv)
echo "account key retrieved from vault"

# Check if the access key was retrieved successfully
if [ -z "$ACCOUNT_KEY" ]; then
  echo "Error: Failed to retrieve the access key from Key Vault."
  exit 1
fi

# Export the access key as an environment variable
export ARM_ACCOUNT_KEY="$ACCOUNT_KEY"
export STORAGE_ACCOUNT_NAME="$STORAGE_ACCOUNT_NAME"
export RESOURCE_GROUP_NAME="$RESOURCE_GROUP_NAME"
export CONTAINER_NAME="$CONTAINER_NAME"
export SUBSCRIPTION_ID="$SUBSCRIPTION_ID"
# Confirmation message
echo "ARM_ACCOUNT_KEY has been set successfully."
