#!/usr/bin/bash

HOME_DIR="/home/ec2-user"
WORKSPACE="/var/lib/jenkins/workspace/BynetFinalProject"
TEST_IP="54.81.199.86"
DEPLOY_IP="44.203.4.212"

MACHINE=$1
if [ "$MACHINE" == "test" ];
then
	MACHINE_IP=$TEST_IP
else
	MACHINE_IP=$DEPLOY_IP
fi

ssh -tt -o StrictHostKeyChecking=no ec2-user@${MACHINE_IP} << 'EOF'
	cd /home/ec2-user/BynetFinalProject/
	docker-compose up --no-build -d
	sleep 5
	if [ "$MACHINE" == "test" ];
	then
		./test.sh
	fi
EOF

echo "Deployed to $MACHINE machine successfully"