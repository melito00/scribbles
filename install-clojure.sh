#!/bin/sh

WORKDIR=$HOME/tmp

VERSION=1.10.1.641
#VERSION=1.10.1.561
BASE_URL=https://download.clojure.org/install
FILENAME=linux-install-${VERSION}.sh
CMDPATH=pt_linux_amd64/pt
BINPATH=${HOME}/bin

if [ ! -d $WORKDIR ]; then
  mkdir $WORKDIR
fi

if ! type wget >/dev/null 2>&1; then
  echo "This script require wget command"
  exit 1
fi

cd $WORKDIR

wget -O ${FILENAME} ${BASE_URL}/${FILENAME}
chmod 755 ${WORKDIR}/${FILENAME}
${WORKDIR}/${FILENAME} --prefix $HOME/.clojure
/bin/rm ${WORKDIR}/${FILENAME}
