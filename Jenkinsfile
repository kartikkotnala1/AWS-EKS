pipeline {
    agent any
    parameters {
        choice(
            name: 'ACTION',
            choices: ['apply', 'destroy'],
            description: 'Select whether to create (apply) or delete (destroy) infrastructure'
        )
    }
    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
    }
    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }
        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh 'terraform init -reconfigure'
                }
            }
        }
        stage('Terraform Action') {
            steps {
                dir('terraform') {
                    script {
                        if (params.ACTION == 'apply') {
                            echo "Running Terraform Apply..."
                            sh 'terraform plan -out=tfplan'
                            input message: 'Do you want to apply these changes?', ok: 'Yes, Apply'
                            sh 'terraform apply tfplan'
                        } else if (params.ACTION == 'destroy') {
                            echo "Running Terraform Destroy..."
                            input message: 'WARNING: Are you sure you want to destroy all infrastructure?', ok: 'Yes, Destroy'
                            sh 'terraform destroy -auto-approve'
                        }
                    }
                }
            }
        }
    }
}
