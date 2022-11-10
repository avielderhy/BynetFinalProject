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
                sshagent(['jenkins_keys']) {
                    sh 'ssh ec2-user@54.81.199.86 "cd /home/ec2-user/BynetFinalProject/; ./deploy.sh test"'
                }
            }
        }
	stage('Deploy') { 
            steps {
                echo "Deploying..."
                sshagent(['prod_ec2']) {
                    sh 'ssh ec2-user@44.203.4.212 "cd /home/ec2-user/BynetFinalProject/; ./deploy.sh prod"'
                }
            }
        }
    }
}