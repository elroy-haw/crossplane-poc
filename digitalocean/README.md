# Minimum setup for running Crossplane on DigitalOcean Kubernetes cluster

## Instructions

### Deploy
Once you have ensured you have the [required versions](#requirements) installed, use the following commands to deploy.
```bash
cd infra
echo "do_token = \"<paste your do api token here>\"" > terraform.tfvars
terraform init
terraform apply -auto-approve
```
Copy the `cluster_id` output value.

### Connect
Install `doctl` e.g. for macOS: 
```bash
brew install doctl
``` 
For other OSes, refer to the [DigitalOcean docs](https://docs.digitalocean.com/reference/doctl/how-to/install/).

Use the following command to update your `~/.kube/config` file.
```bash
doctl kubernetes cluster kubeconfig save <paste the cluster_id output value here>
```

### Verify
Run the following command to verify that the crossplane pods are up and running.
```bash
kubectl get pods -n crossplane-system
NAME                                      READY   STATUS    RESTARTS   AGE
crossplane-7cfcfb84c9-tfzml               1/1     Running   0          9m5s
crossplane-rbac-manager-cdcc7f487-bd22d   1/1     Running   0          9m5s
```

### Teardown
Run the following command to teardown the resources deployed.
```bash
terraform destroy
```
You might run into the following issue while running the command:
```bash
Error: DELETE https://api.digitalocean.com/v2/vpcs/06ec02c6-a2b3-4df1-a2z1-kfeq79bcac1c: 403 (request "bbfccz96-a1f0-43s0-qe24-ft802p5ne43o") Can not delete VPC with members
```
This is likely due to a race condition between deletion of cluster and vpc. Simply re-run the command to clean the vpc up.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.11 |
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | >= 2.16.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.4.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | 2.16.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.4.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [digitalocean_kubernetes_cluster.cluster](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/kubernetes_cluster) | resource |
| [digitalocean_vpc.vpc](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/vpc) | resource |
| [helm_release.crossplane](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [digitalocean_kubernetes_versions.versions](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/kubernetes_versions) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_do_token"></a> [do\_token](#input\_do\_token) | DigitalOcean API token | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | DO Kubernetes cluster ID |

Generated by [`terraform-docs`](https://github.com/terraform-docs/terraform-docs).