pipeline {
    agent {
        node {
            label 'AGENT-1'
        }
    }
    // parameters {

    // }
    options {
        ansiColor('xterm')
        disableConcurrentBuilds()
    }
    stages {
        stage('VPC') {
            steps {
                sh """
                    cd 01-vpc
                    terraform init -reconfigure
                    terraform apply -auto-approve
                """
            }
        }
        stage('SG') {
            steps {
                sh """
                    cd 02-sg
                    terraform init -reconfigure
                    terraform apply -auto-approve
                """
            }
        }
        stage('OpenVPN') {
            steps {
                sh """
                    cd 03-openvpn
                    terraform init -reconfigure
                    terraform apply -auto-approve
                """
            }
        }
        stage('DB & APP ALB') {
            parallel {
                stage('Databases') {
                    steps {
                        sh """
                            cd 04-databases
                            terraform init -reconfigure
                            terraform apply -auto-approve
                        """
                    }
                }
                stage('APP ALB') {
                    steps {
                        sh """
                            cd 05-app-alb
                            terraform init -reconfigure
                            terraform apply -auto-approve
                        """
                    }
                }
            }
        }
    }
}