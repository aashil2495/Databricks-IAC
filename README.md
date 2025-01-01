# Azure Databricks Setup - Goal and Scripts

## Goal

The goal of this setup is to create an Azure environment for running and managing Databricks workflows, including configuring a Databricks workspace, creating storage resources, and enabling access to external locations through Unity Catalog. This setup facilitates collaborative analytics, data engineering, and machine learning operations.

In this guide, we will:
1. Create an Azure Resource Group.
2. Set up a Databricks Workspace in the Azure Resource Group.
3. Create a Storage Account and a container for storing data.
4. Configure a Databricks Access Connector for secure access to the storage account.
5. Set up Unity Catalog Metastore for data governance.
6. Assign roles and permissions to ensure proper access to resources.

The scripts provided below will automate each of these steps.

---

## Scripts and What They Do

### 1. **Login to Azure Portal**
```bash
az login

### 2. **Create Resource Group named myResourceGroup, you can replace it with your own name.**
```bash
az group create --name myResourceGroup --location southcentralus
