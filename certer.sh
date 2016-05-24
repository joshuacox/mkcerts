#!/bin/bash
HOST=$1
openssl genrsa -out $HOST-priv-key.pem 2048
openssl req -subj "/CN=$HOST" -new -key $HOST-priv-key.pem -out $HOST.csr
openssl x509 -req -days 1825 -in $HOST.csr -CA ca.pem -CAkey ca-priv-key.pem -CAcreateserial -out $HOST-cert.pem -extensions v3_req -extfile /usr/lib/ssl/openssl.cnf
openssl rsa -in $HOST-priv-key.pem -out $HOST-priv-key.pem
