pipeline {
    environment {
        registry = "avielderhy/finalproject"
        registryCredential = 'avielderhy'
        dockerImage = ''
    }
    agent any 
    stages {
        stage('Build') { 
            steps {
                echo "Building..."
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'jenkins_keys', url: 'https://github.com/avielderhy/BynetFinalProject']]])
                script {
                    sh 'sudo systemctl start docker'
                    dockerImage = docker.build registry + "latest"
                    docker.withRegistry('https://registry.hub.docker.com', registryCredential) { dockerImage.push() }
                }
            }
        }
	stage('Test') { 
            steps {
                echo "Testing..."
                sshagent(['ec2_test']) {
                    sh 'ssh ec2-user@54.83.91.121 "cd /home/ec2-user/BynetFinalProject/; ./deploy.sh test"'
                }
            }
        }
	stage('Deploy') { 
            steps {
                echo "Deploying..."
                sshagent(['prod_ec2']) {
                    sh 'ssh ec2-user@18.208.110.157 "cd /home/ec2-user/BynetFinalProject/; ./deploy.sh prod"'
                }
            }
        }
    }
}
