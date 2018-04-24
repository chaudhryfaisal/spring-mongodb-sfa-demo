#!/usr/bin/env bash

VER=$1

if [[ -z "$VER" ]]; then
	echo -n "Enter new version (ex: 0.0.2): "
	read VER
fi

TAG="chaudhryfaisal/api-service:$VER"

echo "VER=$VER"
echo "TAG=$TAG"

echo "replacing version"
sed -E -i '' "s/<version>.*<\/version><\!--MAIN-->/<version>${VER}<\/version><\!--MAIN-->/g" pom.xml

echo "Maven build"
mvn clean package -DskipTests=True

#update file for docker file
mv "target/api-service-${VER}.jar" "target/api-service-0.0.1.jar"

echo "Docker build"
docker build -t $TAG .
docker push $TAG