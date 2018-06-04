# Installation

## Requirements:

- ruby 2.3+
- yarn
- postgresql

## Getting Started:

- Ubuntu 16.04.4 LTS 

```
$ cd
$ pwd
/home/ubuntu/

$ mkdir run

$ cat /etc/issue
Ubuntu 16.04.4 LTS

$ git clone https://github.com/tamura2004/vue_handsontable.git workplan
$ cd workplan
$ sudo apt-get update
$ sudo apt-get install -y --no-install-recommends ruby ruby-dev
$ ruby -v
bundle install --without test development

$ gem -v
2.5.2.1

$ bundle -v
Bundler version 1.11.2

$ sudo apt-get install -y --no-install-recommends libgdbm-dev ruby build-essential libpq-dev npm nodejs

$ nodejs -v
v4.2.6

$ npm -v
3.5.2

$ bundle install --without test development --path vendor/bundle
$ rails -v
Rails 5.0.2

$ sudo npm cache clean
$ sudo npm install n -g
$ sudo n stable
$ sudo ln -sf /usr/local/bin/node /usr/bin/node
$ node -v
v10.2.1

$ sudo apt-get purge -y nodejs npm

$ curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
$ echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
$ sudo apt-get update
$ sudo apt-get install -y --no-install-recommends yarn
$ yarn --version
1.7.0

$ yarn
$ RAILS_ENV=production rails assets:precompile

$ sudo apt-get install nginx
$ sudo rm /etc/nginx/sites-enabled/default
$ sudo ln -sf  /home/ubuntu/workplan/nginx.conf /etc/nginx/conf.d/nginx.conf
$ sudo nginx -s reload

Allow connection to Azure Database for Postgresql

$ sudo cp /home/ubuntu/workplan/puma.service /etc/systemd/system/puma.service
$ sudo systemctl daemon-reload
$ sudo systemctl enable puma.service
$ sudo systemctl start puma.service
$ sudo systemctl status puma.service

```

### install yarn
[https://yarnpkg.com/lang/en/docs/install/](https://yarnpkg.com/lang/en/docs/install/)

```
choco install yarn
pg_dump projects_members_development --data-only --inserts > 20170809backup.sql
```

