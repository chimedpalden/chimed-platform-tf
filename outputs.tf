output "do_cluster_id" {
  value = module.digital_ocean.do_cluster_id
}

output "ingress_nginx_service_external_ip" {
  value = module.kubernetes.ingress_nginx_service_external_ip
}
