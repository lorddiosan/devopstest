#!/bin/bash
JENKINS_URL="http://localhost:8080"
PLUGINS="git maven-plugin workflow-aggregator docker-workflow kubernetes sonarqube"

echo "Installing Jenkins plugins..."
for plugin in $PLUGINS; do
    echo "Installing $plugin..."
    java -jar jenkins-cli.jar -s $JENKINS_URL install-plugin $plugin -deploy
done

echo "Restarting Jenkins..."
java -jar jenkins-cli.jar -s $JENKINS_URL safe-restart
