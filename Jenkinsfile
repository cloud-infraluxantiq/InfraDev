
pipeline {
  agent {
    docker {
      image 'gcr.io/cloud-builders/docker'
      args '-v /var/run/docker.sock:/var/run/docker.sock'
    }
  }

  environment {
    PROJECT_ID = 'cloud-infra-dev'
    REGION     = 'asia-south1'
    DJANGO_IMAGE = "gcr.io/${PROJECT_ID}/djangoapi:latest"
    ANGULAR_IMAGE = "gcr.io/${PROJECT_ID}/angularfrontend:latest"
    GOOGLE_APPLICATION_CREDENTIALS = credentials('gcp-service-account-json') // Jenkins secret
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Build Django Image') {
      steps {
        dir('backend') {
          sh 'docker build -t $DJANGO_IMAGE .'
        }
      }
    }

    stage('Build Angular Image') {
      steps {
        dir('frontend') {
          sh 'docker build -t $ANGULAR_IMAGE .'
        }
      }
    }

    stage('Push Images') {
      steps {
        sh 'gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS'
        sh 'gcloud auth configure-docker --quiet'
        sh 'docker push $DJANGO_IMAGE'
        sh 'docker push $ANGULAR_IMAGE'
      }
    }

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
      echo 'Pipeline failed!'
    }
    success {
      echo '✅ Build + Deploy Successful!'
    }
  }
}
