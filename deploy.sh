#!/usr/bin/bash

HOME_DIR="/home/ec2-user"
WORKSPACE="/var/lib/jenkins/workspace/BynetFinalProject"
TEST_IP="54.81.199.86"
DEPLOY_IP="44.203.4.212"
MY_IP="$(dig +short myip.opendns.com @resolver1.opendns.com)"

MACHINE=$1

if [ "$#" -ne 1 ]; then
    echo "You entered more than 1 argument"
	exit 1
fi

if [ "$MACHINE" == "test" ];
then
	if [ $MY_IP == $TEST_IP ];
	then
	cd /home/ec2-user/BynetFinalProject/
	docker-compose up --no-build -d
	sleep 5
	./test.sh
	fi
fi

if [ "$MACHINE" == "prod" ];
then
	if [ $MY_IP == $DEPLOY_IP ];
	then
	cd /home/ec2-user/BynetFinalProject/
	docker-compose up --no-build -d
	fi
fi

echo "Deployed to $MACHINE machine successfully"