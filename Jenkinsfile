#!/usr/bin/env groovy
pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "us-east-1"
    }
    stages {
        stage("Create an EKS Cluster") {
            steps {
                script {
                    dir('terraform') {
                        sh "terraform init"
                        sh "terraform apply -auto-approve"
                    }
                }
            }
        }
        stage("Deploy to EKS") {
            steps {
                script {
                    dir('kubernetes') {
                        sh "aws eks update-kubeconfig --name myapp-eks-cluster"
                        sh "kubectl apply -f nginx-deployment.yaml"
                        sh "kubectl apply -f nginx-service.yaml"
                    }
                }
            }
        }
        stage("Deploy Prometheus") {
            steps {
                script {
                    dir('kubernetes') {
                        sh "helm install prometheus oci://registry-1.docker.io/bitnamicharts/kube-prometheus"
                    }
                }
            }
        }
        stage("Info") {
            steps {
                script {
                    dir('kubernetes') {
                        sh "kubectl config view --minify --raw"
                    }
                }
            }
        }
    }
}