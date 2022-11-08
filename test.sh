#!/bin/bash

status=`curl --write-out "%{http_code}\n" --silent --output /dev/null "http://127.0.0.1:5000"`
if [ "$status" == "200" ];
	then
		echo "The test PASSED"
	else
		echo "The test Failed"
fi