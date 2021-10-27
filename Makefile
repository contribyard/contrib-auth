build:
	docker build -t contrib-auth .
bash:
	docker run -it -v $$PWD:/var/gem -w /var/gem contrib-auth bash
