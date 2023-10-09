sudo -i
sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
#установим пакеты
yum install -y redhat-lsb-core wget rpmdevtools rpm-build createrepo yum-utils gcc
#качаем SRPM и opensll
cd /root
wget https://nginx.org/packages/centos/8/SRPMS/nginx-1.20.2-1.el8.ngx.src.rpm
wget https://github.com/openssl/openssl/archive/refs/heads/OpenSSL_1_1_1-stable.zip 
unzip OpenSSL_1_1_1-stable.zip
#ставим nginx и зависимости
rpm -i nginx-1.*
yum-builddep /root/rpmbuild/SPECS/nginx.spec -y
# правим nginx.spec
sed -i '/--with-debug/i \    --with-openssl=/root/openssl-OpenSSL_1_1_1-stable \\' /root/rpmbuild/SPECS/nginx.spec
#собираем пакет
rpmbuild -bb /root/rpmbuild/SPECS/nginx.spec
#устанавливаем пакет и запускаем сервис
yum localinstall -y /root/rpmbuild/RPMS/x86_64/nginx-1*.rpm
systemctl start nginx

###настраиваем репо
mkdir /usr/share/nginx/html/repo

cp rpmbuild/RPMS/x86_64/nginx-1*.rpm /usr/share/nginx/html/repo/
wget https://downloads.percona.com/downloads/percona-distribution-mysql-ps/percona-distribution-mysql-ps-8.0.28/binary/redhat/8/x86_64/percona-orchestrator-3.2.6-2.el8.x86_64.rpm -O /usr/share/nginx/html/repo/percona-orchestrator-3.2.6-2.el8.x86_64.rpm
createrepo /usr/share/nginx/html/repo/

#настраиваем nginx
sed -i '/index.htm;/a \\tautoindex on;' /etc/nginx/conf.d/default.conf
nginx -s reload

#добавляем репозиторий
cat >> /etc/yum.repos.d/lab6.repo << EOF
[lab6]
name=lab6-linux
baseurl=http://localhost/repo
gpgcheck=0
enabled=1
EOF

#ставим пакет для проверки и выводим список пакетов в репозитории
yum install -y percona-orchestrator.x86_64
yum list installed | grep orc