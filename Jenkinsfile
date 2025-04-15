
pipeline {
  agent any

  environment {
    PROJECT_ID = 'your-gcp-project-id'
    REGION     = 'us-central1'
    IMAGE_NAME = "${REGION}-docker.pkg.dev/${PROJECT_ID}/backend/django:latest"
    CONNECTION = 'your-sql-connection-name'
  }

  stages {
    stage('Checkout') {
      steps {
        git 'https://your-repo-url.git'
      }
    }

    stage('Build Docker Image') {
      steps {
        sh "docker build -t ${IMAGE_NAME} ."
      }
    }

    stage('Push to Artifact Registry') {
      steps {
        sh "gcloud auth configure-docker ${REGION}-docker.pkg.dev"
        sh "docker push ${IMAGE_NAME}"
      }
    }

    stage('Deploy to Cloud Run') {
      steps {
        sh """
        gcloud run deploy django-api \
          --image=${IMAGE_NAME} \
          --region=${REGION} \
          --platform=managed \
          --allow-unauthenticated \
          --add-cloudsql-instances=${CONNECTION} \
          --set-secrets=DB_PASSWORD=db_password_secret:latest,JWT_SECRET=jwt_secret_key:latest
        """
      }
    }
  }
}
