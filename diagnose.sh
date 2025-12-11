#!/bin/bash
echo "=== Diagnostic du système ==="
echo "1. Java:"
java -version
echo -e "\n2. Maven:"
mvn --version
echo -e "\n3. Git:"
git --version
echo -e "\n4. Docker:"
docker --version
echo -e "\n5. Jenkins:"
sudo systemctl status jenkins --no-pager
echo -e "\n6. Répertoire du projet:"
ls -la ~/devopstest/
echo -e "\n7. Test Maven:"
cd ~/devopstest && mvn clean compile
echo -e "\n8. Test package:"
mvn package -DskipTests
