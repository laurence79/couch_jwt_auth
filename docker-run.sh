#!/bin/bash

COUCH_DATA_DIR=$(echo ~)/couch-data

echo Using data directory $COUCH_DATA_DIR

docker run -p 5984:5984 \
 -e COUCHDB_USER=admin \
 -e COUCHDB_PASSWORD=29746353 \
 -e COUCHDB_JWT_HS_SECRET=c3VwZXJzZWNyZXRz \
 -e COUCHDB_JWT_USERNAME_CLAIM=name \
 -v $COUCH_DATA_DIR:/usr/local/var/lib/couchdb \
 couch_jwt_auth:1.6.1
