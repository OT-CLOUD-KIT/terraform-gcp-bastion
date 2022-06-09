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
