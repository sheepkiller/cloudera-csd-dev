#!/bin/bash
set -e

VERSION=1.0
rm -fr parcels
mkdir -p parcels/CSD_DEV-${VERSION}

(cd src/csd-dev && make clean install)
java -jar ../cm_ext/validator/target/validator.jar -d src/parcels/CSD_DEV-${VERSION}/
java -jar ../cm_ext/validator/target/validator.jar -a src/parcels/CSD_DEV-${VERSION}/meta/alternatives.json
java -jar ../cm_ext/validator/target/validator.jar -p src/parcels/CSD_DEV-${VERSION}/meta/parcel.json
java -jar ../cm_ext/validator/target/validator.jar -r src/parcels/CSD_DEV-${VERSION}/meta/permissions.json

for os in el5 el6 sles11 lucid precise squeeze wheezy
do
    (cd src/parcels && tar zcf ../../parcels/CSD_DEV-${VERSION}/CSD_DEV-${VERSION}-$os.parcel CSD_DEV-${VERSION} --owner=root --group=root)
#    tar tvf parcels/CSD_DEV-${VERSION}/CSD_DEV-${VERSION}-$os.parcel
    java -jar ../cm_ext/validator/target/validator.jar -f  parcels/CSD_DEV-${VERSION}/CSD_DEV-${VERSION}-$os.parcel
done

python ../cm_ext/make_manifest/make_manifest.py  parcels/CSD_DEV-${VERSION}
java -jar ../cm_ext/validator/target/validator.jar -m parcels/CSD_DEV-${VERSION}/manifest.json

(cd parcels && ln -sf CSD_DEV-${VERSION} latest )

rsync -avl parcels root@dingo.cotds.org:/srv/parcels/csd-dev
