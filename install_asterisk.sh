#!/bin/bash
echo "INSTALL ASTERISK"
echo "###################
#     INSTALANDO DEPENDÊNCIAS
#########################"

sudo apt update
sudo apt upgrade
sudo apt-get install build-essential wget libssl-dev libncurses5-dev libnewt-dev libxml2-dev linux-headers-$(uname -r) libsqlite3-dev uuid-dev git-core subversion libjansson-dev sqlite autoconf automake libtool libncurses5-dev -y

cd /tmp

echo "###################
#     DOWNLOAD DRIVER DAHDI
###########################"
wget downloads.asterisk.org/pub/telephony/dahdi-linux-complete/dahdi-linux-complete-2.10.2+2.10.2.tar.gz

echo "####################
#     DESCOMPACTANDO O ARQUIVO
###########################"
tar zxvf dahdi-linux-complete-2.10.2+2.10.2.tar.gz

cd dahdi-linux-complete-2.10.2+2.10.2

echo "#######################
#     INSTALANDO O DRIVER DAHDI
##############################"
make && make install && make config

cd ..

echo "########################
#     DOWNLOAD DO DRIVER LIBPRI
##############################"

wget http://downloads.asterisk.org/pub/telephony/libpri/libpri-current.tar.gz

echo "#########################
#     DESCOMPACTANDO O ARQUIVO
###############################"
tar zxvf libpri-current.tar.gz

cd libpri-1.6.0

echo "###########################
#     INSTALANDO O DRIVER LIBPRI
#################################"
make && make install

cd ..

echo "##########################
#     DOWNLOAD DO ASTERISK
################################"
wget downloads.asterisk.org/pub/telephony/asterisk/asterisk-13-current.tar.gz

echo "##########################
#     DESCOMPACTANDO O ARQUIVO
################################"
tar zxvf asterisk-13-current.tar.gz

cd asterisk-13.21.0

echo "##########################
#     INICIANDO INSTALAÇÃO
################################"
./contrib/scripts/install_prereq install && ./bootstrap.sh

./configure && make menuselect && make && make install && make config && make samples

echo "##########################
#     INSTALAÇÃO CONCLUIDA COM SUCESSO
################################"

echo "##########################
#     INICIANDO O DRIVER DAHDI
################################"
/etc/init.d/dahdi start

echo "##########################
#     INICIANDO O ASTERISK
################################"
/etc/init.d/asterisk start

echo "##########################
#     ACESSANDO O BIXO
################################"
asterisk -vvvr
