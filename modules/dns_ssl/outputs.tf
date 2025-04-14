
output "load_balancer_ip" {
  value = google_compute_global_address.lb_ip.address
}

output "ssl_status" {
  value = google_compute_managed_ssl_certificate.ssl_cert.managed.status
}
