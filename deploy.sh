#!/usr/bin/bash

HOME_DIR="/home/ec2-user"
WORKSPACE="/var/lib/jenkins/workspace/BynetFinalProject"
TEST_IP="54.81.199.86"
DEPLOY_IP="44.203.4.212"
MY_IP = "$(dig +short myip.opendns.com @resolver1.opendns.com)"

MACHINE=$1
if [ "$MACHINE" == "test" ];
then
	if [ $MY_IP =~ $TEST_IP ];
	then
	cd /home/ec2-user/BynetFinalProject/
	docker-compose up --no-build -d
	sleep 5
	./test.sh
	else
		ssh -tt -o StrictHostKeyChecking=no ec2-user@${TEST_IP} "cd /home/ec2-user/BynetFinalProject/;docker-compose up --no-build -d"
	fi
fi

if [ "$MACHINE" == "prod" ];
then
	if [ $MY_IP == $DEPLOY_IP ];
	then
	cd /home/ec2-user/BynetFinalProject/
	docker-compose up --no-build -d
	else
		ssh -tt -o StrictHostKeyChecking=no ec2-user@${MACHINE_IP} "cd /home/ec2-user/BynetFinalProject/; docker-compose up --no-build -d; sleep 5; ./test.sh"
	fi
fi

echo "Deployed to $MACHINE machine successfully"
