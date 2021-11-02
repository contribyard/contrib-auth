build:
	docker build -t contrib-auth .
bash:
	docker run -it -v $$PWD:/var/gem -w /var/gem contrib-auth bash
release:
	docker run -it --entrypoint ./scripts/release \
	-v $$PWD:/var/gem -w /var/gem contrib-auth
