variable "do_cluster_name" {
  description = "Kubernetes cluster name on DigitalOcean"
}

variable "do_cluster_region" {
  # list is available at https://slugs.do-api.dev/ on "Regions"
  # default is - New York 1
  description = "The slug identifier for the region where the Kubernetes cluster will be created"
  default     = "nyc1"
}

variable "do_cluster_version" {
  # list is available at https://slugs.do-api.dev/ on "Kubernetes Versions"
  description = "The slug identifier for the version of Kubernetes used for the cluster"
  default     = "1.25.4-do.0"
}

variable "do_cluster_node_size" {
  # list is available at https://slugs.do-api.dev/ on "Droplet Sizes"
  description = "The slug identifier for the type of Droplet to be used as workers in the node pool"
  default     = "s-2vcpu-4gb"
}

resource "digitalocean_kubernetes_cluster" "do_cluster" {
  name    = var.do_cluster_name
  region  = var.do_cluster_region
  version = var.do_cluster_version

  node_pool {
    name       = "${var.do_cluster_name}-default-pool"
    size       = var.do_cluster_node_size
    auto_scale = true
    min_nodes  = 1
    max_nodes  = 2
    tags       = [
      "${var.do_cluster_name}-worker"
    ]
  }
}

output "do_cluster_id" {
  value = digitalocean_kubernetes_cluster.do_cluster.id
}

output "do_cluster_client_certificate" {
  value = base64decode(digitalocean_kubernetes_cluster.do_cluster.kube_config.0.client_certificate)
}

output "do_cluster_client_key" {
  value = base64decode(digitalocean_kubernetes_cluster.do_cluster.kube_config.0.client_key)
}

output "do_cluster_ca_certificate" {
  value = base64decode(digitalocean_kubernetes_cluster.do_cluster.kube_config.0.cluster_ca_certificate)
}

output "do_cluster_host" {
  value = digitalocean_kubernetes_cluster.do_cluster.kube_config.0.host
}

output "do_cluster_token" {
  value = digitalocean_kubernetes_cluster.do_cluster.kube_config.0.token
}
