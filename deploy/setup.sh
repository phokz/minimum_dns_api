#!/bin/bash

echo -en "#!/bin/sh\n\nsudo apt-get install -y --no-install-recommends \$@" > /usr/bin/agi
chmod 755 /usr/bin/agi

apt-get update

# misc & ruby & mysql
agi vim curl build-essential ruby-dev libmysqlclient-dev mysql-server ruby ruby-bundler git nodejs pwgen
echo -en "\"\\\\e[B\": history-search-forward\n\"\\\\e[A\": history-search-backward\n" \
   >> /etc/inputrc

# misc hardcoded password for vagrant user
echo vagrant:ins3CURe | /usr/sbin/chpasswd
sed -e 's/PasswordAuthentication no/PasswordAuthentication yes/' -i /etc/ssh/sshd_config

# ruby & mysql stuff

mkdir -p /var/www
cd /var/www
git clone https://github.com/phokz/minimum_dns_api.git
cd minimum_dns_api
git checkout r50
sudo chown -R vagrant:vagrant .
su -c "bundle install --deployment" vagrant

h=$(pwgen -s 20)
cat <<EOF > config/database.yml
default: &default
  adapter: mysql2
  encoding: utf8
  pool: <%= ENV.fetch('RAILS_MAX_THREADS') { 5 } %>
  username: dns_api
  password: ${h}.
  host: localhost

development:
  <<: *default
  database: dns_development

test:
  <<: *default
  database: dns_test

production:
  <<: *default
  database: dns_production
EOF

sudo -H mysql -e 'create database dns_production default charset utf8;' 
sudo -H mysql -e "grant all on dns_production.* to dns@localhost identified by '${h}'"


cd /vagrant

