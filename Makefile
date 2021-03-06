all: ca-priv-key.pem ca.pem swarm node0  node1

ca-priv-key.pem:
	openssl genrsa -out ca-priv-key.pem 2048

ca.pem:
	openssl req -config /usr/lib/ssl/openssl.cnf -new -key ca-priv-key.pem -x509 -days 1825 -out ca.pem

catest:
	openssl rsa -in ca-priv-key.pem -noout -text

swarm:
	$(eval TMP := $(shell mktemp -d --suffix=DOCKERTMP))
	mkdir $(TMP)/swarm
	cp certer.sh $(TMP)/swarm/
	cp ca-priv-key.pem $(TMP)/swarm/
	cp ca.pem $(TMP)/swarm/
	cd $(TMP)/swarm ; ./certer.sh swarm; rm certer.sh; \
	rm ca-priv-key.pem;rm ca.srl; rm swarm.csr; \
	mv swarm-cert.pem cert.pem; mv swarm-priv-key.pem key.pem
	cd $(TMP)/ ;  tar zcf /tmp/swarm.tgz swarm
	rm -Rf $(TMP)


node0:
	$(eval TMP := $(shell mktemp -d --suffix=DOCKERTMP))
	mkdir $(TMP)/node0
	cp certer.sh $(TMP)/node0
	cp ca-priv-key.pem $(TMP)/node0/
	cp ca.pem $(TMP)/node0/
	cd $(TMP)/node0 ; ./certer.sh node0; rm certer.sh; \
	rm ca-priv-key.pem;rm ca.srl; rm node0.csr; \
	mv node0-cert.pem cert.pem; mv node0-priv-key.pem key.pem
	cd $(TMP)/ ;  tar zcf /tmp/node0.tgz node0
	rm -Rf $(TMP)

node1:
	$(eval TMP := $(shell mktemp -d --suffix=DOCKERTMP))
	mkdir $(TMP)/node1
	cp certer.sh $(TMP)/node1
	cp ca-priv-key.pem $(TMP)/node1/
	cp ca.pem $(TMP)/node1/
	cd $(TMP)/node1 ; ./certer.sh node1; rm certer.sh; \
	rm ca-priv-key.pem;rm ca.srl; rm node1.csr; \
	mv node1-cert.pem cert.pem; mv node1-priv-key.pem key.pem
	cd $(TMP)/ ;  tar zcf /tmp/node1.tgz node1
	rm -Rf $(TMP)

page:
	echo 'https://docs.docker.com/swarm/configure-tls/'
