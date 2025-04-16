#!/bin/bash

echo "🔐 Fetching Terraform credentials from Secret Manager..."
gcloud secrets versions access latest --secret=dev-gcs-service-key | base64 --decode > terraform-sa-key.json

#This securely fetches the Base64-encoded service account key from Secret Manager.
#Decodes and saves it as terraform-sa-key.json in the current directory.
# Ensure this key is .gitignored

export GOOGLE_APPLICATION_CREDENTIALS="$(pwd)/terraform-sa-key.json"
echo "✅ Credentials set. Proceeding with Terraform..."
#Sets the environment variable Terraform (and GCP SDK) uses to authenticate API calls.

terraform init
terraform apply -auto-approve

#Clean up the key file after use
rm -f terraform-sa-key.json
