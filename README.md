[![Build Status](https://travis-ci.org/crowdint/prdashboard.svg?branch=master)](https://travis-ci.org/crowdint/prdashboard)
[![Coverage Status](https://coveralls.io/repos/crowdint/prdashboard/badge.png?branch=master)](https://coveralls.io/r/crowdint/prdashboard?branch=master)

# PR Dashboard

PR Dashboard is a pull requests reviewing tool build on top of a Rails
as backend service, and Ember.js as frontend framework.

## Requirements

- Ruby 2.1.0
- Rails 4.0.3

## Github Keys

There are only two needed enviroment variables for this application. But
first, you will have to create a new Github application, to do so, just
go [here](https://github.com/settings/applications/new).

For development enviroment you should set the `Homepage URL` as
**http://localhost:$PORT**

After that, you will get access to your tokens.

You need to set the following enviroment variables, you could create a
.env file on the application's root. That file should look like this:

    GITHUB_KEY=your-key
    GITHUB_SECRET=your-secret
    SECRET_TOKEN=3c129645bbb2ca4b21ff1998bba2339adf86c06ea247a9086bc353ad7220c56c5af587b1a6946b

The SECRET_TOKEN value is just an example.

## Setup

After cloning the repo, all you need to do is:

    $ bundle install
    $ cp config/database.yml.postgresql config/database.yml
    $ bundle exec rake db:create
    $ bundle exec rake db:migrate
    $ bundle exec foreman start

And you are done!

## Contributing

Pull requests are welcome, just fork the repo, make your changes (don't
forget to add tests) and send the Pull Request. That easy!

