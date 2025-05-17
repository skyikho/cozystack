OUT=../../_out/repos/apps
TMP=../../_out/repos/apps/historical

include ../../scripts/common-envs.mk

repo:
	rm -rf "$(OUT)"
	mkdir -p "$(OUT)"
	$(AWK_CMD) '$$3 != "HEAD" {print "mkdir -p $(TMP)/" $$1 "-" $$2}' versions_map | sh -ex
	$(AWK_CMD) '$$3 != "HEAD" {print "git archive " $$3 " " $$1 " | tar -xf- --strip-components=1 -C $(TMP)/" $$1 "-" $$2 }' versions_map | sh -ex
	helm package -d "$(OUT)" $$(find . $(TMP) -mindepth 2 -maxdepth 2 -name Chart.yaml | $(AWK_CMD) 'sub("/Chart.yaml", "")' | sort -V)
	cd "$(OUT)" && helm repo index . --url http://cozystack.cozy-system.svc/repos/apps
	rm -rf "$(TMP)"

fix-chartnames:
	find . -name Chart.yaml -maxdepth 2 | $(AWK_CMD) -F/ '{print $$2}' | while read i; do $(SED_CMD) "s/^name: .*/name: $$i/" "$$i/Chart.yaml"; done

gen-versions-map: fix-chartnames
	../../hack/gen_versions_map.sh

check-version-map: gen-versions-map
	git diff --exit-code -- versions_map
