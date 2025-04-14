
variable "project_id" { type = string }
variable "region" { type = string }
variable "zone" { type = string }
variable "machine_type" {
  type    = string
  default = "e2-medium"
}
variable "startup_script" {
  type        = string
  description = "Custom startup script to install Jenkins"
  default     = <<EOT
#!/bin/bash
apt-get update
apt-get install -y openjdk-11-jdk
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add -
sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
apt-get update
apt-get install -y jenkins
systemctl start jenkins
systemctl enable jenkins
EOT
}
