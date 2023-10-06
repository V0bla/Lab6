sudo -i
sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
#установим пакеты
yum install -y redhat-lsb-core wget rpmdevtools rpm-build createrepo yum-utils gcc inet-tools
#качаем SRPM и opensll
wget https://nginx.org/packages/centos/8/SRPMS/nginx-1.20.2-1.el8.ngx.src.rpm
wget https://github.com/openssl/openssl/archive/refs/heads/OpenSSL_1_1_1-stable.zip
unzip OpenSSL_1_1_1-stable.zip
#ставим nginx и зависимости
rpm -i nginx-1.*
yum-builddep rpmbuild/SPECS/nginx.spec

