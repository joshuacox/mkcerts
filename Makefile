all: ca swarm node

ca:
	openssl genrsa -out ca-priv-key.pem 2048
	openssl req -config /usr/lib/ssl/openssl.cnf -new -key ca-priv-key.pem -x509 -days 1825 -out ca.pem
	openssl rsa -in ca-priv-key.pem -noout -text

swarm:
	openssl genrsa -out swarm-priv-key.pem 2048
	openssl req -subj "/CN=swarm" -new -key swarm-priv-key.pem -out swarm.csr
	openssl x509 -req -days 1825 -in swarm.csr -CA ca.pem -CAkey ca-priv-key.pem -CAcreateserial -out swarm-cert.pem -extensions v3_req -extfile /usr/lib/ssl/openssl.cnf
	openssl rsa -in swarm-priv-key.pem -out swarm-priv-key.pem

node:
	openssl genrsa -out node-priv-key.pem 2048
	openssl req -subj "/CN=node" -new -key node-priv-key.pem -out node.csr
	openssl x509 -req -days 1825 -in node.csr -CA ca.pem -CAkey ca-priv-key.pem -CAcreateserial -out node-cert.pem -extensions v3_req -extfile /usr/lib/ssl/openssl.cnf
	openssl rsa -in node-priv-key.pem -out node-priv-key.pem

page:
	echo 'https://docs.docker.com/swarm/configure-tls/'
