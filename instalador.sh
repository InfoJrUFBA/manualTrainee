#!/bin/bash
echo "=============================================================="
echo "Instalando o apache2..."
echo "=============================================================="
sudo apt-get install apache2 -y
echo "=============================================================="
echo "Configurando o apache2..."
echo "=============================================================="
sudo chmod -R 777 /var/www/html

sudo sed -i 's/<Directory "\/var\/www\/html">//' /etc/apache2/sites-available/000-default.conf
sudo sed -i 's/AllowOverride All//' /etc/apache2/sites-available/000-default.conf
sudo sed -i 's/<\/Directory>//' /etc/apache2/sites-available/000-default.conf
sudo sed -i 's/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/html\n   <Directory "\/var\/www\/html">\n      AllowOverride All\n   <\/Directory>/' /etc/apache2/sites-available/000-default.conf
# sudo sed -i '12s/$/\n   <Directory "\/var\/www\/html">\n      AllowOverride All\n   <\/Directory>/' /etc/apache2/sites-available/000-default.conf
sudo service apache2 restart
echo "=============================================================="
echo "Instalando o PHP..."
echo "=============================================================="
sudo apt-get install php7.0 php7.0-fpm libapache2-mod-php7.0 php7.0-mysql -y
echo "=============================================================="
echo "Configurando o PHP..."
echo "=============================================================="
sudo sed -i '462s/Off/On/' /etc/php/7.0/apache2/php.ini
echo "=============================================================="
echo "Instalando o MySQL..."
echo "=============================================================="
echo "Sera necessario atribuir uma senha ao usuario root"
sudo apt-get install mysql-client mysql-server -y
echo "=============================================================="
echo "Instalando o PHPMyAdmin..."
echo "=============================================================="
echo "Marque o \"apache2\" e marque \"sim\" quando for solicitado"
echo "use a mesma senha do MySQL"
sudo apt-get install phpmyadmin -y
echo "=============================================================="
echo "Configurando o PHPMyAdmin..."
echo "=============================================================="
sudo sed -i 's/#Include phpMyAdmin//' /etc/apache2/apache2.conf
sudo sed -i 's/Include \/etc\/phpmyadmin\/apache.conf//' /etc/apache2/apache2.conf
echo "#Include phpMyAdmin" >> /etc/apache2/apache2.conf
echo "Include /etc/phpmyadmin/apache.conf" >> /etc/apache2/apache2.conf
sudo service apache2 restart
