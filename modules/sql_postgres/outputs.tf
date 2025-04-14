
output "instance_name" {
  value = google_sql_database_instance.postgres_instance.name
}

output "connection_name" {
  value = google_sql_database_instance.postgres_instance.connection_name
}

output "private_ip_address" {
  value = google_sql_database_instance.postgres_instance.ip_address[0].ip_address
}
