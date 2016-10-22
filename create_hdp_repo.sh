#!/bin/bash

REPO_FOLDER="/data/repo/hdp/centos7"
REPO_URL="http://10.60.17.100/fandrieu/mirrors/hdp/centos7"

HDP="HDP-2.5.0.0 HDP-UTILS-1.1.0.21"

REPO_LIST="$HDP"

mkdir -p $REPO_FOLDER
for REPO in $REPO_LIST
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
