yum install -y epel-release
yum install -y docker wget git ansible
yum install -y zip unzip
yum install -y pyton-cryptography pyOpenSSL.x86_64
yum install -y "@Development Tools" python2-pip openssl-devel python-devel python
sudo pip install pip --upgrade
pip install passlib
pip install -Iv ansible==2.3.1.0
yum install -y centos-release-scl-rh
yum install -y subscription-manager
yum install -y httpd-tools
DOMAIN=${DOMAIN:=ggorigin.com}
IPADDR=${IPADDR:=192.168.165.130}
echo ${IPADDR} ${DOMAIN}>> /etc/hosts
echo 'INSECURE_REGISTRY="--insecure-registry 172.30.0.0/16"' >> /etc/sysconfig/docker
wget https://github.com/openshift/openshift-ansible/archive/release-1.4.zip
unzip release-1.4.zip
mv openshift-ansible-release-1.4/ openshift-ansible/
git clone https://github.com/deltaospoc/openshiftassets.git
# Just Press "Enter" for creating Key   
ssh-keygen -t rsa
# Require root password for Copy Key to Domain
ssh-copy-id root@${DOMAIN}
ansible-playbook -i openshiftassets/inventory.erb openshift-ansible/playbooks/byo/config.yml
yum install -y source-to-image
