# README

Minimal DNS TXT Api server.

```
bundle install
cp .env.example .env
cp config/database.yml.example

# edit .env to taste
```
# configure credentials

```
EDITOR="mate --wait" bin/rails credentials:edit
```
Add for example following credentials:

login: admin
password: test

# setup database

```
rails db: create
rails db:migrate
```

# run server and open domains page

```
rails s -d
xdg-open http://localhost:3000/domains
```

Add domain(s) you wish to resolve.




# test adding records

```
curl -X POST -u "admin:test" -F "domain=txt.record.domain.tld" -F "txtvalue=2e1d26752c212627ea95b14ce49062c3" http://localhost:3000/txt
```


# test the record via DNS

```
host -t soa domain.tld localhost
host -t txt  txt.record.domain.tld localhost
```

# test removing records


curl -X DELETE -u "admin:test" -F "domain=txt.record.domain.tld" -F  http://localhost:3000/txt

# configuring pdns-server

## install

```
  apt install pdns-backend-mysql pdns-server
```

# configure

```
rm rm /etc/powerdns/pdns.d/pdns.simplebind.conf
cat <<EOF >/etc/powerdns/pdns.d/pdns.local.gmysql.conf
# MySQL Configuration

launch=gmysql

gmysql-host=localhost
gmysql-port=
gmysql-dbname=dns_development
gmysql-user=user
gmysql-password=pass
gmysql-dnssec=no
```


