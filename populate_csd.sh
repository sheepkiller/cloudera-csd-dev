#!/bin/sh
set -e

java -jar ../cm_ext/validator/target/validator.jar -s ./csd/CSD_DEV/src/descriptor/service.sdl
(cd csd/CSD_DEV && mvn clean package)
scp csd/CSD_DEV/target/CSD_DEV-1.0.jar root@cloudera00.int.cotds.org:/opt/cloudera/csd
ssh root@cloudera00.int.cotds.org service cloudera-scm-server restart

rsync -avl csd/CSD_DEV/target/CSD_DEV-1.0.jar root@dingo.cotds.org:/srv/parcels/csd-dev/csd
