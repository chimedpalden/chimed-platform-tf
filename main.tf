terraform {
  cloud {
    organization = "jalantechnologies"
    workspaces {
      name = "platform-do-cluster-tf"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

provider "kubernetes" {
  host                   = module.digital_ocean.do_cluster_host
  token                  = module.digital_ocean.do_cluster_token
  client_certificate     = module.digital_ocean.do_cluster_client_certificate
  client_key             = module.digital_ocean.do_cluster_client_key
  cluster_ca_certificate = module.digital_ocean.do_cluster_ca_certificate
}

provider "helm" {
  kubernetes {
    host                   = module.digital_ocean.do_cluster_host
    token                  = module.digital_ocean.do_cluster_token
    client_certificate     = module.digital_ocean.do_cluster_client_certificate
    client_key             = module.digital_ocean.do_cluster_client_key
    cluster_ca_certificate = module.digital_ocean.do_cluster_ca_certificate
  }
}

provider "kubectl" {
  host                   = module.digital_ocean.do_cluster_host
  token                  = module.digital_ocean.do_cluster_token
  client_certificate     = module.digital_ocean.do_cluster_client_certificate
  client_key             = module.digital_ocean.do_cluster_client_key
  cluster_ca_certificate = module.digital_ocean.do_cluster_ca_certificate
  load_config_file       = false
}

module "digital_ocean" {
  source          = "./modules/digital-ocean"
  do_cluster_name = var.do_cluster_name
  do_alert_email  = var.do_alert_email
}

module "kubernetes" {
  depends_on           = [module.digital_ocean]
  source               = "./modules/kubernetes"
  cluster_issuer_email = var.cluster_issuer_email
  cluster_issuer_name  = "letsencrypt-prod"
}
