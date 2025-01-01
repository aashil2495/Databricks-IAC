# Azure Databricks Setup - Resources Created

This document provides an overview of the Azure resources created for the Databricks setup.

## 1. **Resource Group**
   - **Name**: `myResourceGroup`  
   - **Location**: `southcentralus`
   - **Description**: A resource group is a container that holds related Azure resources. It is the foundation for organizing resources in Azure.

## 2. **Databricks Workspace**
   - **Name**: `myDatabricksWorkspace`  
   - **Resource Group**: `myResourceGroup`  
   - **Location**: `southcentralus`  
   - **SKU**: `premium`  
   - **Description**: The Databricks workspace is used for data engineering, data science, and machine learning. It connects to the Azure services and allows for collaborative analytics workflows.

## 3. **Storage Account**
   - **Name**: `itmmystorageaccountgen2`  
   - **Resource Group**: `myResourceGroup`  
   - **Location**: `southcentralus`  
   - **SKU**: `Standard_LRS`  
   - **Kind**: `StorageV2`  
   - **HNS**: `true` (Hierarchical Namespace enabled)  
   - **Description**: A general-purpose storage account to store data and integrate with Databricks.

## 4. **Storage Container**
   - **Name**: `container`  
   - **Storage Account**: `itmmystorageaccountcli`  
   - **Description**: A container within the storage account that holds data in the Azure Data Lake Gen2 format (abfss protocol).

## 5. **Databricks Unity Catalog Metastore**
   - **Name**: `metastoresouthcentralus`  
   - **Storage Root**: `abfss://container@itmmystorageaccountcli.dfs.core.windows.net/`  
   - **Region**: `southcentralus`  
   - **Description**: Unity Catalog Metastore to manage and govern all Databricks assets in the workspace, like tables and views.

## 6. **Databricks Access Connector**
   - **Name**: `my-access-connector`  
   - **Resource Group**: `myResourceGroup`  
   - **Location**: `southcentralus`  
   - **Identity Type**: `SystemAssigned`  
   - **Description**: The Databricks access connector facilitates secure access to Azure resources (e.g., Azure Storage) using managed identities.

## 7. **Azure Role Assignment**
   - **Assignee**: `ea0bb2f9-762f-496c-a5ce-8d33f4dd1790` (Principal ID of Managed Identity)  
   - **Role**: `Storage Blob Data Contributor`  
   - **Scope**: `/subscriptions/d066615d-e286-4bf1-92e7-7df087f1f4d0/resourceGroups/myResourceGroup/providers/Microsoft.Storage/storageAccounts/itmmystorageaccountcli`  
   - **Description**: Assigned the role to the Databricks managed identity for read and write access to the storage account.

## 8. **Databricks Storage Credential**
   - **Name**: `external-loc`  
   - **Access Connector ID**: `/subscriptions/d066615d-e286-4bf1-92e7-7df087f1f4d0/resourceGroups/myResourceGroup/providers/Microsoft.Databricks/accessConnectors/my-access-connector`  
   - **Description**: Storage credentials that allow Databricks to access the storage account securely.

## 9. **Databricks External Location**
   - **Name**: `my_external_location`  
   - **Storage Credential**: `external-loc`  
   - **URL**: `abfss://container@itmmystorageaccountcli.dfs.core.windows.net/`  
   - **Description**: The external location references the Azure Data Lake Storage Gen2 container, using the previously defined storage credential to securely access data.

---

## How to Use
- **Databricks Workspace**: Use the Databricks workspace for building and deploying data pipelines, notebooks, and machine learning models.
- **Storage Account and Containers**: Store data in the Azure Storage account and access it from Databricks using the external location setup.
- **Unity Catalog**: Use Unity Catalog for managing data governance and access control across the Databricks workspace.
- **Access Connector**: Securely connect Databricks to Azure resources, such as Blob Storage, using managed identities.

---

## Prerequisites
- **Azure CLI**: Ensure that you have the [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) installed and configured on your machine.
- **Databricks CLI**: Install and configure the [Databricks CLI](https://docs.databricks.com/dev-tools/cli/index.html) with a Personal Access Token (PAT).

---

## Cleanup
To delete all the resources created, you can use the following command to delete the resource group, which will remove all the associated resources:
```bash
az group delete --name myResourceGroup --yes --no-wait
