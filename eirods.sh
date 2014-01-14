#!/bin/bash -x

IRODS_DIR=/var/lib/iRODS
BASEURL=ftp://ftp.renci.org/pub/irods/releases/3.0.1
ICAT=eirods-3.0.1-64bit-icat-postgres.deb

if [ ! -e /home/vagrant/.irodsprovisioned ]; then
    apt-get update
    apt-get upgrade -y
    apt-get install -q -y curl build-essential python-pip git python-dev postgresql odbc-postgresql unixodbc-dev libssl0.9.8 super

    wget -q $BASEURL/$ICAT
    dpkg -i $ICAT
    apt-get -f install

    cp -R ~eirods/.irods ~vagrant/
    chown -R vagrant:vagrant ~vagrant/.irods
	echo "rods" | su - vagrant -c 'iinit'

    touch /home/vagrant/.irodsprovisioned
fi
