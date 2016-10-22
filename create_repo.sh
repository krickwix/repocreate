#!/bin/bash

REPO_FOLDER="/data/repo/current"
REPO_URL="http://10.60.17.222/current"

CEPH1="rhel-7-server-rhceph-1.3-mon-rpms rhel-7-server-rhceph-1.3-calamari-rpms rhel-7-server-rhceph-1.3-installer-rpms rhel-7-server-rhceph-1.3-tools-rpms rhel-ha-for-rhel-7-server-rpms rhel-ha-for-rhel-7-server-eus-rpms rhel-7-server-rhceph-1.3-osd-rpms"

CEPH2="rhel-7-server-rhceph-2-mon-rpms rhel-7-server-rhceph-2-osd-rpms rhel-7-server-rhceph-2-tools-rpms"

OSP7="rhel-7-server-rpms rhel-7-server-optional-rpms rhel-7-server-extras-rpms \
rhel-7-server-openstack-7.0-rpms rhel-7-server-openstack-7.0-tools-rpms rhel-7-server-openstack-7.0-director-rpms rhel-7-server-openstack-7.0-optools-rpms"

OSP8="rhel-7-server-openstack-8-director-rpms rhel-7-server-openstack-8-rpms rhel-7-server-openstack-8-tools-rpms rhel-7-server-openstack-8-optools-rpms"

OSP9="rhel-7-server-openstack-9-director-rpms rhel-7-server-openstack-9-rpms rhel-7-server-openstack-9-tools-rpms rhel-7-server-openstack-9-optools-rpms"

OSP7_ADD="rhel-7-server-openstack-7.0-director-debug-rpms rhel-7-server-openstack-7.0-director-source-rpms rhel-7-server-openstack-7.0-debug-rpms rhel-7-server-openstack-7.0-tools-debug-rpms rhel-7-server-openstack-7.0-tools-source-rpms rhel-7-server-openstack-7.0-optools-source-rpms rhel-7-server-openstack-7.0-optools-debug-rpms rhel-7-server-openstack-7.0-source-rpms"

REPO_LIST="$OSP7 $OSP8 $OSP9 $CEPH1 $CEPH2"

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
