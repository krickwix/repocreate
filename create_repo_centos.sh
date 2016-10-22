#!/bin/bash

REPO_FOLDER="/data/repo/centos"
REPO_URL="http://10.60.17.222/current"

CENTOS_REPO=""

mkdir -p $REPO_FOLDER
for REPO in $CENTOS_REPO
do
  echo "Sync of $REPO"
  reposync -l -n --repoid=$REPO --download_path=$REPO_FOLDER
  cd $REPO_FOLDER/$REPO
  createrepo .

  cat >$REPO_FOLDER/$REPO.repo<< EOF
[$REPO] 
name=$REPO
baseurl=$REPO_URL/$REPO/
enabled=1 
gpgcheck=0 
EOF
done
