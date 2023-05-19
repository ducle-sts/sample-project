pipeline {
    agent {
        kubernetes {
             yaml '''
apiVersion: v1
kind: Pod
spec:
  containers:
    - name: docker
      image: docker
      command:
        - sleep
      args:
        - infinity
      env:
        - name: DOCKER_HOST
          value: tcp://docker-dind.ci-services:2375
 '''
            defaultContainer 'docker'
        }
    }
    stages {
        stage('Build') {
            environment {
                DOCKERHUB_CREDS = credentials('dockerhub')
                REGISTRY = ''
                IMAGE_NAME =  'sample_angular'
                IMAGE_TAG =  "${JOB_BASE_NAME}-0.0.${env.BUILD_ID}"
            }
            steps {
                container('docker') {
                sh "until docker ps; do sleep 3; done && docker build -t $IMAGE_NAME:$IMAGE_TAG ."
                sh "docker images"
                }
            }
        }
    }
}
