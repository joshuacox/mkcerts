all: ca swarm node0  node1

ca:
	openssl genrsa -out ca-priv-key.pem 2048
	openssl req -config /usr/lib/ssl/openssl.cnf -new -key ca-priv-key.pem -x509 -days 1825 -out ca.pem
	openssl rsa -in ca-priv-key.pem -noout -text

swarm:
	$(eval TMP := $(shell mktemp -d --suffix=DOCKERTMP))
	mkdir $(TMP)/swarm
	cp certers.sh $(TMP)/swarm/
	cp ca-priv-key.pem $(TMP)/swarm/
	cp ca.pem $(TMP)/swarm/
	cd $(TMP)/swarm ;  	./certer.sh swarm
	cd $(TMP)/ ;  tar zcf /tmp/swarm.tgz swarm
	rm -Rf $(TMP)


node0:
	$(eval TMP := $(shell mktemp -d --suffix=DOCKERTMP))
	mkdir $(TMP)/node0
	cp certers.sh $(TMP)/node0
	cp ca-priv-key.pem $(TMP)/node0/
	cp ca.pem $(TMP)/node0/
	cd $(TMP)/node0 ;  	./certer.sh node0
	cd $(TMP)/ ;  tar zcf /tmp/node0.tgz node0
	rm -Rf $(TMP)

node1:
	$(eval TMP := $(shell mktemp -d --suffix=DOCKERTMP))
	mkdir $(TMP)/node1
	cp certers.sh $(TMP)/node1
	cp ca-priv-key.pem $(TMP)/node1/
	cp ca.pem $(TMP)/node1/
	cd $(TMP)/node1 ;  	./certer.sh node1
	cd $(TMP)/ ;  tar zcf /tmp/node1.tgz node1
	rm -Rf $(TMP)

page:
	echo 'https://docs.docker.com/swarm/configure-tls/'
