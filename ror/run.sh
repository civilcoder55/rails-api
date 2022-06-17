#!/bin/sh

while ! nc -z mysql 3306 ; do
    echo "Waiting for the MySQL Server"
    sleep 3
done
echo "MySQL Server is ready"

while ! nc -z elasticsearch 9200 ; do
    echo "Waiting for the ElasticSearch Server"
    sleep 3
done
echo "ElasticSearch Server is ready"

echo "Starting Migrating ..."
rails db:migrate
echo "Migrating is finished"



echo "Starting Rails Server ..."
rm -f ./tmp/pids/server.pid
rails server -b 0.0.0.0