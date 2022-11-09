#!/usr/bin/bash

HOME_DIR="/home/ec2-user"
WORKSPACE="/var/lib/jenkins/workspace/BynetFinalProject"
TEST_IP="54.81.199.86"
DEPLOY_IP="44.203.4.212"

MACHINE=$1
if [ "$MACHINE" == "test" && $("dig +short myip.opendns.com @resolver1.opendns.com") == $TEST_IP ];
then
	cd /home/ec2-user/BynetFinalProject/
	docker-compose up --no-build -d
	sleep 5
	./test.sh
fi

if [ "$MACHINE" == "prod" && $("dig +short myip.opendns.com @resolver1.opendns.com") == $DEPLOY_IP ];
then
	cd /home/ec2-user/BynetFinalProject/
	docker-compose up --no-build -d
fi

if [ "$MACHINE" == "test" && $("dig +short myip.opendns.com @resolver1.opendns.com") == $DEPLOY_IP ];
then
	ssh -tt -o StrictHostKeyChecking=no ec2-user@${TEST_IP} << 'EOF'
		"cd /home/ec2-user/BynetFinalProject/"
		"docker-compose up --no-build -d"
	EOF
fi

else
	ssh -tt -o StrictHostKeyChecking=no ec2-user@${MACHINE_IP} << 'EOF'
	cd /home/ec2-user/BynetFinalProject/
	docker-compose up --no-build -d
	sleep 5
	./test.sh
EOF



echo "Deployed to $MACHINE machine successfully"
