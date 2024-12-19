output "lb-ip" {
  value = module.lb_http.external_ip
}

output "lb-ipv6" {
  value = module.lb_http.external_ipv6_address
}
