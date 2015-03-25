# Slack Log Viewer

## Dependency Software Install

### Install MongoDB (OSX)

```
$ brew tap homebrew/boneyard
$ cd /usr/local
$ git checkout 4ea480f /usr/local/Library/Formula/mongodb.rb # using mongodb 2.6.8
$ brew install mongodb
```

## Development

```
$ export MONGO_HOST=***
$ export MONGO_DB=***
$ export MONGO_USER=***
$ export MONGO_PASS=***
$ bundle
$ npm install
$ bower install
```
### Start

```
$ bundle exec foreman start -f Procfile.dev
```

or

In another window
```
$ npm run start
```

In another window

```
$ bin/rails s
```

## Heroku Deployment

```
$ heroku config:set MONGO_HOST=***
$ heroku config:set MONGO_DB=***
$ heroku config:set MONGO_USER=***
$ heroku config:set MONGO_PASS=***
$ heroku config:set BASIC_AUTH_USERNAME=***
$ heroku config:set BASIC_AUTH_PASSWORD=***
$ heroku buildpack:set https://github.com/heroku/heroku-buildpack-multi.git
$ git push heroku master
```

## References
- [slack-logger](https://github.com/katawa/slack-logger)

## Requirements

- mongod = 2.6.8 (same as mongolab.com)
