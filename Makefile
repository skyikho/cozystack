.PHONY: manifests repos assets


#build: build-deps

build:
	make -C packages/core/installer image
	make manifests

repos:
	rm -rf _out
	make -C packages/apps check-version-map
	make -C packages/extra check-version-map
	make -C packages/system repo
	make -C packages/apps repo
	make -C packages/extra repo
	mkdir -p _out/logos
	cp ./packages/apps/*/logos/*.svg ./packages/extra/*/logos/*.svg _out/logos/


manifests:
	mkdir -p _out/assets
	(cd packages/core/installer/; helm template -n cozy-installer installer .) > _out/assets/cozystack-installer.yaml

assets:
	make -C packages/core/installer/ assets

test:
	make -C packages/core/testing apply
	make -C packages/core/testing test

generate:
	hack/update-codegen.sh

upload_assets: manifests
	hack/upload-assets.sh
