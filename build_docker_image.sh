last_hash_dockerfile=$(git log -n 1 --pretty=format:%H -- dockerfile)
output=$(aws ecr describe-images --repository-name $REPOSITORY_NAME --profile ss-shared --image-ids imageTag=$last_hash_dockerfile 2>&1)
if [[ "$output" == *"$last_hash_dockerfile"* ]]; then
    DOCKER_IMAGE_ALREADY_BUILT=true
    echo "BYPASS_BUILD"
else
    DOCKER_IMAGE_ALREADY_BUILT=false
    docker build -t $REPOSITORY_URI:$CODEBUILD_RESOLVED_SOURCE_VERSION -f dockerfile .
    docker build -t $REPOSITORY_URI:$CODEBUILD_RESOLVED_SOURCE_VERSION .
    docker tag $REPOSITORY_URI:$CODEBUILD_RESOLVED_SOURCE_VERSION $REPOSITORY_URI:latest
    docker push $REPOSITORY_URI:$CODEBUILD_RESOLVED_SOURCE_VERSION
    docker push $REPOSITORY_URI:latest
    echo "NEW_IMAGE"
fi

