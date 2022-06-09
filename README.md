# GCP Bastion Terraform Module

[![Opstree Solutions][opstree_avatar]][opstree_homepage]

[Opstree Solutions][opstree_homepage]

[opstree_homepage]: https://opstree.github.io/
[opstree_avatar]: https://img.cloudposse.com/150x150/https://github.com/opstree.png

Bastion hosts provide an external facing point of entry into a network containing private network. This module provides you the functionality to create Bastion in your VPC as per your requirement.

Create GCP service account & JSON key
Go to https://console.cloud.google.com/identity/serviceaccounts and create a service account. And a JSON key for it. Download the key file as ./service-account-credentials.json.

**Note : For more information, you can check example folder.**

## GCP versions

GCP 3.51.0       
## Resources

| Name                                                                                                                               | Type        |
| ---------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [google_service_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account)       | Resource    |
| [google_compute_firewall](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | Resource    |
| [template_file](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data    |
| [google_compute_instance](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file)              | Resource |
| [aws_ecr_lifecycle_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy)              | Resource |
| [aws_region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region)                                | Data Source |

## Inputs

| Name                             | Description                                                                                                                                                          | Type           | Default | Required |
| -------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- | ------- | :------: |
| project_id           | The project ID to host the network in policy                                                                                                                                                        | `string`       |         |   Yes    |
| region                         | The region to use only.                                                                                                                                                        | `string` |         |   Yes    |
| zone                     |  The zone where the Bastion host is located in                                                                                                                                          | `string`       |         |   Yes    |
| bastion_name             | The name to use for the bastion instance.                                                                                                                                                 | `string`       |         |   Yes    |
| machine_type                             | The machine type of the instance.                                                                                                                                       | `string`       |         |   Yes    |
| network_name                             | The name of the network that should be used                                                                                                                                     | `string`  |         |   Yes    |
| subnet_name                 | The name of the subnet that should be used                           | `bool`  |         |   Yes |
| tag                 | "The GCP network tag to apply to the bastion host for firewall rules. Defaults to 'public', the expected public tag of this module                           | `list(string)`  | Public        |   Yes |
| credentials_file_path                 | The credentials JSON file used to authenticate with GCP                           | `string`  |         |   Yes |
| source_image                 | The source image to build the VM using. Specified by path reference or by {{project}}/{{image-family}}                           | `string`  |         |   Yes |

## Output

| Name | Description |
| ---- | ----------- |
| ip | The IP address of the Bastion instance. |
| ssh | GCloud ssh command to connect to the Bastion instance |


## Usage

```hcl
module "gke_bastion" {

  source                = "../"
  region                = "europe-north-1"
  zone                  = "europe-north1-a"
  network_name          = "default"
  subnet_name           = "default"
  bastion_name          = "host"
  project_id            = "opstree-345811"
  credentials_file_path = "./service-account-credentials.json"
}

```


### Contributor

| [![Piyush Shailly][piyush_avatar]][piyush_homepage]<br/>[Piyush Shailly][Piyush_homepage] |
| -------------------------------------------------------------------------------------------- |

[piyush_homepage]: https://media-exp1.licdn.com/dms/image/C4E03AQE_lFtqQl0ttg/profile-displayphoto-shrink_800_800/0/1600691079547?e=1660176000&v=beta&t=gdJUDhHMIF3loe6fjDwOD6QnzZwtBrHxJ_VW5VJxCeY
[piyush_avatar]: https://avatars.githubusercontent.com/u/103646446?s=400&u=40899dc6d6f2870b115a59fc13f370d274e75d16&v=4