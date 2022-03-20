#!/bin/bash
echo "Pulling Image hwjar:v1 from Docker Hub"
docker pull submah/hwjar:v1

#shutdown container if running
docker ps --filter "name=hwjar"  --filter status=running

if [ $? == 0 ];
then
	echo "Containere Found"
	echo "Shutting down container"
        #stopping and removing container
        docker stop hwjar &&  docker rm -f hwjar
else
	echo "unable to stop"
	exit 100;

fi
echo "Please wait"
sleep 30
#Restart with the version of the image downloaded in step above
echo "creating container with new version"
docker run -itd --name=hwjar -p 8080:8080  submah/hwjar:v2 

echo "Please Wait"
sleep 40

#Verify that the container started successfully
docker logs hwjar| grep -i "Tomcat started on port(s)" || echo Failed
if [ $? == 0 ]; then
	echo "container started successfully"

else
	echo "Container dind't start"

fi

#Verify application is running successfully
app_status=`curl -s -o /dev/null -w "%{http_code}" http://localhost:8080`

echo "Checking Application is running status"

if [ $app_status -eq 200 ]; then
	echo "application is running fine"
else
	echo "application not running and having status code:  $app_status "
fi
