# Kingdom Hall Tools

A few utilities for Kingdom Hall users.

[![Build Status](https://github.com/mjacobus/bible-tools/actions/workflows/rails-unit-tests.yml/badge.svg)](https://github.com/mjacobus/bible-tools/actions/workflows/rails-unit-tests.yml?query=branch%3Amaster)
[![Rubocop](https://github.com/mjacobus/bible-tools/actions/workflows/rubocop.yml/badge.svg)](https://github.com/mjacobus/bible-tools/actions/workflows/rubocop.yml?query=branch%3Amaster)
[![Maintainability](https://api.codeclimate.com/v1/badges/65fad0b0ff0bed478231/maintainability)](https://codeclimate.com/github/mjacobus/bible-tools/maintainability)
[![Coverage Status](https://coveralls.io/repos/github/mjacobus/bible-tools/badge.svg?branch=master)](https://coveralls.io/github/mjacobus/bible-tools?branch=master)

### How to run/install the app:

After installing the ruby version displayed in [this file](https://github.com/mjacobus/bible-tools/blob/master/.ruby-version).
Also install `nodejs` and `yarn`.

```bash
# first time
gem install bundler
mkdir ~/Projects
cd projects
git clone https://github.com/mjacobus/bible-tools.git
cd bible-tools
bundle install # after you installed ruby version
cp .env.sample .env

yarn install

# every time you update your project

cd ~/Projects/bible-tools
docker-compose up     # start docker. Make sure your local postgress is not running
bundle install
./bin/rake db:create  # create database
./bin/rake db:migrate # create tables
./bin/rake db:seed    # create fake data for the database

./bin/rails server    # to stop the server hit <ctrl>+C
```

### Running tests

```bash
RAILS_ENV=test ./bin/rake db:create  # create test database
RAILS_ENV=test ./bin/rake db:migrate # create test tables
./bin/rspec
```

### Fixing files style after changing

```bash
bundle exec rubocop -a
```

### Installing OS dependencies

- If you are on [Ubuntu 18.04 LTS](https://github.com/mjacobus/installers/tree/master/ubuntu/18.04)
- The above step is not installing ruby itself. However you can try to use [asdf for ruby](https://github.com/asdf-vm/asdf-ruby).
- Same for nodejs and yarn. Try [asdf for nodejs](https://github.com/asdf-vm/asdf-nodejs) and after installing run `npm install -g yarn`.

## Heroku

- [TODO: DB Backups](https://data.heroku.com/datastores/TODO-CHANGE#durability)

### Restoring a backup

Download a backup from the above link and then:

```bash
pg_restore -U pguser -W --no-owner --no-privileges -h localhost -d bible_tools_development -1 tmp/bkp/bible_tools-backup-21-01-14
```
