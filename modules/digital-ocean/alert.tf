variable "do_alert_email" {
  description = "Email address to be used for sending resource utilization alerts"
}

resource "digitalocean_monitor_alert" "cpu_alert" {
  alerts {
    email = [
      var.do_alert_email
    ]
  }
  window      = "10m"
  type        = "v1/insights/droplet/cpu"
  compare     = "GreaterThan"
  value       = 90
  enabled     = true
  tags        = digitalocean_kubernetes_cluster.do_cluster.node_pool[0].tags
  description = "CPU is running high on K8 workers"
}

resource "digitalocean_monitor_alert" "memory_alert" {
  alerts {
    email = [
      var.do_alert_email
    ]
  }
  window      = "10m"
  type        = "v1/insights/droplet/memory_utilization_percent"
  compare     = "GreaterThan"
  value       = 90
  enabled     = true
  tags        = digitalocean_kubernetes_cluster.do_cluster.node_pool[0].tags
  description = "Memory Utilization is running high on K8 workers"
}
