update:
	rm -rf charts
	helm repo add clastix https://clastix.github.io/charts
	helm repo update clastix
	helm pull clastix/kamaji-etcd --untar --untardir charts
	sed -i 's/hook-failed/before-hook-creation,hook-failed/' `grep -rl hook-failed charts`
	patch -p4 < patches/fix-svc.diff
	patch -p4 < patches/fullnameOverride.diff
	patch -p4 < patches/remove-plus.patch
