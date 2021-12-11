# Deploy Azure resources using Crossplane

## Instructions

### Install Azure Provider
```bash
cd azure
kubectl apply -f provider.yaml
```
Once installed, validate that the Azure APIs are available.
```bash
kubectl api-resources | grep azure.crossplane.io
providerconfigs                                      azure.crossplane.io/v1beta1             false        ProviderConfig
providerconfigusages                                 azure.crossplane.io/v1beta1             false        ProviderConfigUsage
providers                                            azure.crossplane.io/v1alpha3            false        Provider
resourcegroups                                       azure.crossplane.io/v1alpha3            false        ResourceGroup
redis                                                cache.azure.crossplane.io/v1beta1       false        Redis
aksclusters                                          compute.azure.crossplane.io/v1alpha3    false        AKSCluster
cosmosdbaccounts                                     database.azure.crossplane.io/v1alpha3   false        CosmosDBAccount
mysqlserverconfigurations                            database.azure.crossplane.io/v1beta1    false        MySQLServerConfiguration
mysqlserverfirewallrules                             database.azure.crossplane.io/v1alpha3   false        MySQLServerFirewallRule
mysqlservers                                         database.azure.crossplane.io/v1beta1    false        MySQLServer
mysqlservervirtualnetworkrules                       database.azure.crossplane.io/v1alpha3   false        MySQLServerVirtualNetworkRule
postgresqlserverconfigurations                       database.azure.crossplane.io/v1beta1    false        PostgreSQLServerConfiguration
postgresqlserverfirewallrules                        database.azure.crossplane.io/v1alpha3   false        PostgreSQLServerFirewallRule
postgresqlservers                                    database.azure.crossplane.io/v1beta1    false        PostgreSQLServer
postgresqlservervirtualnetworkrules                  database.azure.crossplane.io/v1alpha3   false        PostgreSQLServerVirtualNetworkRule
keyvaultsecrets                       kvsecret       keyvault.azure.crossplane.io/v1alpha1   false        KeyVaultSecret
publicipaddresses                                    network.azure.crossplane.io/v1alpha3    false        PublicIPAddress
subnets                                              network.azure.crossplane.io/v1alpha3    false        Subnet
virtualnetworks                                      network.azure.crossplane.io/v1alpha3    false        VirtualNetwork
accounts                                             storage.azure.crossplane.io/v1alpha3    false        Account
containers                                           storage.azure.crossplane.io/v1alpha3    false        Container
```

### Create Service Principal
Follow the steps [here](https://crossplane.io/docs/v1.5/cloud-providers/azure/azure-provider.html#preparing-your-microsoft-azure-account) to create a service principal with the `Owner` role and grant it permissions to manage resources in Azure.

### Create Azure ProviderConfig
Follow the steps [here](https://crossplane.io/docs/v1.5/cloud-providers/azure/azure-provider.html#setup-azure-providerconfig) to create a secret which stores the base64 encoded version of the JSON file with the service principal credentials. Paste the base64 encoded value into `azure/providerconfig.yaml`.
```bash
cd azure
kubectl apply -f providerconfig.yaml
```

### Create a Managed Resource
Use the following commands to deploy a demo PostgreSQL server on Azure.
```bash
cd azure
kubectl apply -f postgres.yaml
```
Check status of deployment.
```bash
kubectl describe postgresqlserver sqlserverpostgresql41241
```
Validate on Azure portal or using cli that the resource group and PostgreSQL server has been created.
```bash
az login
az group list --query "[?name=='sqlserverpostgresql-rg']"
az postgres server list --query "[?name=='sqlserverpostgresql41241']"
```
