#!/bin/bash

export PATH=$PATH:/jdk/bin

echo '[-] Starting ElasticSearch'
su - work -c "JAVA_HOME=/jdk /elasticsearch/bin/elasticsearch -d"

echo '[-] Starting MongoDB'
su - work -c "/mongodb/bin/mongod --fork --dbpath /mongodb/data/ --logpath /mongodb/log/server"
echo

echo '[-] Waiting for ElasticSearch to start'
while true
do
	curl -I 127.0.0.1:9200 2>/dev/null && break
	sleep 1
done

echo '[-] Download latest raps-cloud'
bash /root/version.sh latest

exec /etc/init.d/shell.sh /root/
