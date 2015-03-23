# Slack Log Viewer

## Install

```
$ brew install mongodb
$ git clone git@github.com:katawa/slack-log-viewer.git
$ cd slack-log-viewer
$ bundle install --path=vendor/bundle --binstubs
```

## Usage

```
$ export MONGO_HOST=***
$ export MONGO_DB=***
$ export MONGO_USER=***
$ export MONGO_PASS=***
$ bin/rails s
```

## Heroku

```
$ heroku config:set MONGO_HOST=***
$ heroku config:set MONGO_DB=***
$ heroku config:set MONGO_USER=***
$ heroku config:set MONGO_PASS=***
$ heroku config:set BASIC_AUTH_USERNAME=***
$ heroku config:set BASIC_AUTH_PASSWORD=***
$ git push heroku master
```

## Ref
- [slack-logger](https://github.com/katawa/slack-logger)

## Requires

mongod = 2.6.8 (same as mongolab.com)


