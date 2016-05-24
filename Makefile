all: ca swarm node0  node1

ca:
	openssl genrsa -out ca-priv-key.pem 2048
	openssl req -config /usr/lib/ssl/openssl.cnf -new -key ca-priv-key.pem -x509 -days 1825 -out ca.pem
	openssl rsa -in ca-priv-key.pem -noout -text

swarm:
	./certer.sh swarm

node0:
	./certer.sh node0

node1:
	./certer.sh node1

page:
	echo 'https://docs.docker.com/swarm/configure-tls/'
