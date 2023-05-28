last_hash_dockerfile=$(git log -n 1 --pretty=format:%H -- dockerfile)
output=$(aws ecr describe-images --repository-name $REPOSITORY_NAME --profile ss-shared --image-ids imageTag=$last_hash_dockerfile 2>&1)
if [[ "$output" == *"$last_hash_dockerfile"* ]]; then
    export DOCKER_IMAGE_ALREADY_BUILT=true
    echo "Image exists"
else
    export DOCKER_IMAGE_ALREADY_BUILT=false
    echo "Image doesn't exist"
fi