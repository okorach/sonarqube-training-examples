#!/bin/bash

if [ "$1" = "-?" ] || [ "$1" = "-h" ]; then
	echo "Usage: $0 [-h|-?] [<scanner-properties>]"
	echo ""
	echo "Example: $0 -Dsonar.host.url=http://localhost:9673"
	exit 0
fi

if [ "$SQ_URL" != "" ]; then
	sqHostOpt="-Dsonar.host.url=$SQ_URL"
fi
if [ "$TOKEN" != "" ]; then
	sqLoginOpt="-Dsonar.login=$TOKEN"
fi

mvn clean org.jacoco:jacoco-maven-plugin:prepare-agent install \
   -Dmaven.test.failure.ignore=true \
   sonar:sonar $sqHostOpt $sqLoginOpt \
   -Dsonar.exclusions=pom.xml \
   -Dsonar.projectKey="training:size-metrics" -Dsonar.projectName="Training: Size Metrics" $*

exit $?
