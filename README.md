# My Bible Notes

Tag scriptures, create a timeline. Share them if you like.

- [Site](https://mybiblenotes.herokuapp.com/#)

[![Build Status](https://github.com/mjacobus/my-bible-notes/actions/workflows/rails-unit-tests.yml/badge.svg)](https://github.com/mjacobus/my-bible-notes/actions/workflows/rails-unit-tests.yml?query=branch%3Amaster)
[![Rubocop](https://github.com/mjacobus/my-bible-notes/actions/workflows/rubocop.yml/badge.svg)](https://github.com/mjacobus/my-bible-notes/actions/workflows/rubocop.yml?query=branch%3Amaster)
[![Maintainability](https://api.codeclimate.com/v1/badges/e89bb4eb8004195f2420/maintainability)](https://codeclimate.com/github/mjacobus/my-bible-notes/maintainability)
[![Coverage Status](https://coveralls.io/repos/github/mjacobus/my-bible-notes/badge.svg?branch=master)](https://coveralls.io/github/mjacobus/my-bible-notes?branch=master)

### How to run/install the app:

After installing the ruby version displayed in [this file](https://github.com/mjacobus/my-bible-notes/blob/master/.ruby-version).
Also install `nodejs` and `yarn`.

```bash
# first time
gem install bundler
mkdir ~/Projects
cd projects
git clone https://github.com/mjacobus/my-bible-notes.git
cd my-bible-notes
bundle install # after you installed ruby version
cp .env.sample .env

yarn install

# every time you update your project

cd ~/Projects/my-bible-notes
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
pg_restore -U pguser -W --no-owner --no-privileges -h localhost -d my_bible_notes_development -1 tmp/bkp/my_bible_notes-backup-21-01-14
```
