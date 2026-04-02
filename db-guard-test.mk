MAKEFILE := $(firstword $(MAKEFILE_LIST))
BRANCH := nightly
DBTYPE := boltdb
DBPATH := ~/.cache/vuls/vuls.db

# Trimmed build: rocky + alpine + oracle (~60 MB total, fast CI).
# Production db-nightly.mk uses all 10 extracted sources.
.PHONY: db-build
db-build:
	vuls db init --dbtype ${DBTYPE} --dbpath ${DBPATH}
	$(MAKE) -f ${MAKEFILE} db-add REPO=vuls-data-extracted-rocky-errata BRANCH=${BRANCH} DBTYPE=${DBTYPE} DBPATH=${DBPATH}
	$(MAKE) -f ${MAKEFILE} db-add REPO=vuls-data-extracted-alpine-secdb BRANCH=${BRANCH} DBTYPE=${DBTYPE} DBPATH=${DBPATH}
	$(MAKE) -f ${MAKEFILE} db-add REPO=vuls-data-extracted-oracle-linux BRANCH=${BRANCH} DBTYPE=${DBTYPE} DBPATH=${DBPATH}

.PHONY: db-add
db-add:
	vuls-data-update dotgit pull --dir . --checkout ${BRANCH} --restore ghcr.io/vulsio/vuls-data-db:${REPO}

	cat ghcr.io/vulsio/vuls-data-db/${REPO}/datasource.json | jq --arg hash $$(git -C ghcr.io/vulsio/vuls-data-db/${REPO} rev-parse HEAD) --arg date $$(git -C ghcr.io/vulsio/vuls-data-db/${REPO} show -s --format=%at | xargs -I{} date -d @{} --utc +%Y-%m-%dT%TZ) '.extracted.commit |= $$hash | .extracted.date |= $$date' > tmp
	mv tmp ghcr.io/vulsio/vuls-data-db/${REPO}/datasource.json
	vuls db add --dbtype ${DBTYPE} --dbpath ${DBPATH} ghcr.io/vulsio/vuls-data-db/${REPO}
	rm -rf ghcr.io
