echo "Base URI: " $BASE_URI
echo "Jenkins job: " $JOB_NAME
JOB_STATUS_URL=${BASE_URI}/job/${JOB_NAME}/lastBuild/api/json

echo "Triggering build..."
curl --output /dev/null --silent ${BASE_URI}/job/${JOB_NAME}/buildWithParameters?delay=0sec
#./jenkins --baseuri=${BASE_URI} --job=${JOB_NAME} start

echo "Tail logs..."
./jenkins --baseuri=${BASE_URI} --job=${JOB_NAME} tail

# Check if the build result was SUCCESS, exit script with error if not
IS_SUCCESS=$(curl --silent $JOB_STATUS_URL | grep result\":\"SUCCESS)

if [[ $IS_SUCCESS -eq 0 ]]; then
	echo "Build failed"
	exit -1
else 
	echo "Build success"
	exit 0
fi