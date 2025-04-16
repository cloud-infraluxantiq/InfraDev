pipeline {
  agent {
    docker {
      // Use the Docker-in-Docker image for container builds
      image 'gcr.io/cloud-builders/docker'
      args '-v /var/run/docker.sock:/var/run/docker.sock'
    }
  }

  environment {
    // Project metadata
    PROJECT_ID  = 'cloud-infra-dev'
    REGION      = 'asia-south1'

    // Fully qualified Artifact Registry image names
    DJANGO_IMAGE  = "gcr.io/${PROJECT_ID}/djangoapi:latest"
    ANGULAR_IMAGE = "gcr.io/${PROJECT_ID}/angularfrontend:latest"

    // Jenkins credential ID for GCP service account key (stored as secret file)
    GOOGLE_APPLICATION_CREDENTIALS = credentials('gcp-service-account-json')
  }

  stages {

    // Pull source code from Git
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    // Build Docker image for Django backend
    stage('Build Django Image') {
      steps {
        dir('backend') {
          sh 'docker build -t $DJANGO_IMAGE .'
        }
      }
    }

    // Build Docker image for Angular frontend
    stage('Build Angular Image') {
      steps {
        dir('frontend') {
          sh 'docker build -t $ANGULAR_IMAGE .'
        }
      }
    }

    // Push both images to Artifact Registry
    stage('Push Images') {
      steps {
        sh 'gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS'
        sh 'gcloud auth configure-docker --quiet'
        sh 'docker push $DJANGO_IMAGE'
        sh 'docker push $ANGULAR_IMAGE'
      }
    }

    // (Optional) Deploy Terraform infrastructure
    // NOTE: You can disable this by renaming or excluding the directory
    stage('Deploy (Optional)') {
      when {
        expression { return fileExists('InfraDev/InfraDev/main.tf') }
      }
      steps {
        dir('InfraDev/InfraDev') {
          sh 'gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS'
          sh 'terraform init -input=false'
          sh 'terraform apply -auto-approve'
        }
      }
    }
  }

  post {
    failure {
      echo '❌ oops...Pipeline failed!'
    }
    success {
      echo '✅ Congrats luxantiq dev team the Build and Deploy was  Successful . Please take a break !'
    }
  }
}
