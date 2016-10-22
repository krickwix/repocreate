#!/bin/bash

REPO_FOLDER="/data/repo/ambari/centos7"
REPO_URL="http://10.60.17.100/fandrieu/mirrors/ambari/centos7"

AMBARI="Updates-ambari-2.4.1.0"

REPO_LIST="$AMBARI"

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
