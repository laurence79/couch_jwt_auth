FROM couchdb:1.6.1

RUN apt-get update && apt-get install -y rebar make 

COPY plugin /tmp/couch_jwt_auth

RUN cd /tmp/couch_jwt_auth \
 && chmod 777 build.sh \
 && ./build.sh \
 && make plugin

RUN mkdir -p /usr/local/lib/couchdb/plugins/couch_jwt_auth \
 && mv /tmp/couch_jwt_auth/dist/* /usr/local/lib/couchdb/plugins/couch_jwt_auth 

RUN apt-get purge -y --auto-remove rebar make \
 && rm -rf /tmp/couch_jwt_auth

COPY docker-entrypoint.jwt.sh /
RUN chmod 777 /docker-entrypoint.jwt.sh

RUN ls /

WORKDIR /var/lib/couchdb
ENTRYPOINT ["tini", "--", "/docker-entrypoint.jwt.sh"]
CMD ["couchdb"]