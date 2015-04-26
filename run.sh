#!/bin/sh
set -e
sh populate_parcel.sh
sh populate_csd.sh
sh upload.sh

