#!/bin/bash
yum install -y yum
cd ~
git clone git://github.com/markgrover/bigtop.git
(cd bigtop; git checkout minimal_puppet)
mkdir -p /etc/puppet/config
cat > /etc/puppet/config/site.csv << __EOT__
hadoop_head_node,mgrover-bigtop-centos-1.ent.cloudera.com
hadoop_storage_dirs,/mnt
bigtop_yumrepo_uri,http://bigtop01.cloudera.org:8080/view/Repos/job/Bigtop-trunk-Repository/label=centos6/lastSuccessfulBuild/artifact/repo/
__EOT__
puppet apply --debug --modulepath=bigtop/bigtop-deploy/puppet/modules bigtop/bigtop-deploy/puppet/manifests/site.pp
