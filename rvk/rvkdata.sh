#!/bin/bash
set -e

if [[ "$1" =~ ^20[12][0-9]_[0-9]*$ ]]; then
  VERSION=$1
  DUMPFILE=rvko_marcxml_$VERSION.xml
  NAME=rvko_$VERSION

  # download and extract only if newer
  wget -N https://rvk.uni-regensburg.de/downloads/$DUMPFILE.gz
  [[ $DUMPFILE.gz -nt $NAME.xml ]] && \
      gzip -vdk $DUMPFILE.gz && mv $DUMPFILE $NAME.xml
  
  if [[ "$2" = "jskos" ]]; then
    make $NAME.ndjson
  elif [[ "$2" = "mcstats" ]]; then
    make $NAME.mcstats
  fi 
else
  echo 'Expecting dump version such as "2018_4" as argument'
  echo
  echo 'Second argument can be any of:'
  echo '  jskos      convert to JSKOS'
  echo '  mcstats    create MARC (sub)field statistics'
  exit 1
fi
