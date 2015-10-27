#!/bin/bash
set -e

if [ ! "$1" ] || [ ! "$2"  ]; then
  echo "Usage: docker run grouptree/mongorestore <host> <database>."
  exit 1
fi

if [ ! -d /backups/$2 ]; then
  echo "Could not find directory /backups/$2"
  exit 1
fi

cd /tmp
tar zxf /backups/$2/latest.tar.gz .
mongorestore --batchSize=10 --drop --host $1 --db $2 ./$2
rm -rf ./$2
echo "File /backups/$2/latest.tar.gz was restored into $2 database."
