#!/bin/bash


if [ "$1" = 'couchdb' ]; then

	# Create jwt config
	CONFIG_FILE="/usr/local/etc/couchdb/local.d/docker.jwt.ini"

	printf "[httpd]\n" > $CONFIG_FILE
	printf "authentication_handlers = {couch_httpd_oauth, oauth_authentication_handler}, {couch_jwt_auth, jwt_authentication_handler}, {couch_httpd_auth, cookie_authentication_handler}, {couch_httpd_auth, default_authentication_handler}\n" >> $CONFIG_FILE

	printf "\n[jwt_auth]\n" >> $CONFIG_FILE

	if [ "$COUCHDB_JWT_HS_SECRET" ] || [ "$COUCHDB_JWT_USERNAME_CLAIM" ] || [ "$COUCHDB_JWT_ROLES_CLAIM" ]; then
		
		if [ "$COUCHDB_JWT_HS_SECRET" ]; then
			printf "hs_secret = %s\n" "$COUCHDB_JWT_HS_SECRET" >> $CONFIG_FILE
		fi
		if [ "$COUCHDB_JWT_USERNAME_CLAIM" ]; then
			printf "username_claim = %s\n" "$COUCHDB_JWT_USERNAME_CLAIM" >> $CONFIG_FILE
		fi
		if [ "$COUCHDB_JWT_ROLES_CLAIM" ]; then
			printf "roles_claim = %s\n" "$COUCHDB_JWT_ROLES_CLAIM" >> $CONFIG_FILE
		fi

		chown couchdb:couchdb $CONFIG_FILE
	fi

	cat $CONFIG_FILE
fi

exec /docker-entrypoint.sh "$@"