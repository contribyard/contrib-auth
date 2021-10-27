build:
	docker build -t contrib-auth .
bash:
	docker run -it -v $$PWD:/var/gem -w /var/gem contrib-auth bash
release:
	docker run --entrypoint ./scripts/release \
	-v $$PWD:/var/gem -w /var/gem contrib-auth $$GITHUB_TOKEN
