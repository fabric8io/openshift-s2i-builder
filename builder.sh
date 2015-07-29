echo "Jenkins job URL: " $JENKINS_JOB_URL

echo "Triggering build..."

JOB_STATUS_URL=${JENKINS_JOB_URL}/lastBuild/api/json
GREP_RETURN_CODE=0

# Start the build
curl --output /dev/null --silent $JENKINS_JOB_URL/build?delay=0sec

# Poll every 5 seconds until the build is finished
while [ $GREP_RETURN_CODE -eq 0 ]
do
    sleep 5
    # Grep will return 0 while the build is running:
    curl --output /dev/null --silent $JOB_STATUS_URL | grep result\":null > /dev/null
    GREP_RETURN_CODE=$?
done

# Check if the build result was SUCCESS, exit script with error if not
IS_SUCCESS=$(curl $JOB_STATUS_URL | grep result\":\"SUCCESS)

if [[ $IS_SUCCESS -eq 0 ]]; then
	echo "Build failed"
	exit -1
else 
	echo "Build success"
	exit 0
fi