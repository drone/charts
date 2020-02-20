SHELL=/bin/sh

.PHONY: lint
lint:
	@ct lint

.PHONY: publish
publish:
	@mkdir -p temp docs
	@helm repo add stable https://kubernetes-charts.storage.googleapis.com/
	@helm repo add incubator https://kubernetes-charts-incubator.storage.googleapis.com/
	@helm package -u -d temp charts/drone charts/drone-runner-kube charts/drone-kubernetes-secrets
	@helm repo index --debug --url=https://charts.drone.io --merge docs/index.yaml temp
	@mv temp/drone*.tgz docs
	@mv temp/index.yaml docs/index.yaml
	@rm -rf temp
