############################################################
# Outputs: Load Balancer Routing Module (Luxantiq)
# Used to link to DNS + SSL module
############################################################

output "lb_ip_address" {
  value       = google_compute_global_address.lb_ip.address
  description = "The external IP address allocated for the HTTPS Load Balancer"
}
