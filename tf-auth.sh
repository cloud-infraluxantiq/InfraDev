#!/bin/bash

echo "🔐 Fetching Terraform credentials from Secret Manager..."
gcloud secrets versions access latest --secret=dev-gcs-service-key | base64 --decode > terraform-sa-key.json

export GOOGLE_APPLICATION_CREDENTIALS="$(pwd)/terraform-sa-key.json"
echo "✅ Credentials set. Proceeding with Terraform..."

terraform init
terraform apply
