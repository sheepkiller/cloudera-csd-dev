all: build

build:
	CGO_ENABLED=0 go build -a  -installsuffix netgo csd-dev.go 

install: build
	install -m 755 csd-dev ../parcels/CSD_DEV-1.0/bin/csd-dev

clean:
	rm -fv csd-dev
