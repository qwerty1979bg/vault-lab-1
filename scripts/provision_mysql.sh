#!/usr/bin/env bash

# Check if MySQL is listening on all interfaces

# Set MySQL to listen on all interfaces
if [ $(grep -i "^bind-address" /etc/mysql/my.cnf | wc -l) != 1 ]
then
	echo "more than one 'bind-address' found in the MySQL config file - please fix this"
	exit 1
else
	echo "making MySQL listen to all interfaces"
	sed -i "s/^bind-address.*/bind-address = */g" /etc/mysql/my.cnf
	service mysql restart
fi

# Create a new user (test/pass) and grant it some magic abilities

mysql -u root << EOF
CREATE USER 'test'@'localhost' IDENTIFIED BY 'pass';
GRANT ALL PRIVILEGES ON *.* TO 'test'@'localhost' WITH GRANT OPTION;
CREATE USER 'test'@'%' IDENTIFIED BY 'pass';
GRANT ALL PRIVILEGES ON *.* TO 'test'@'%' WITH GRANT OPTION;
exit
EOF

# Import a sample database
tmp1=$(mktemp -d --tmpdir=/dev/shm/)
pushd .
cd $tmp1
wget -nv https://downloads.mysql.com/docs/world.sql.gz
gunzip world.sql.gz
mysql -u root < world.sql
popd
rm -rf $tmp1
