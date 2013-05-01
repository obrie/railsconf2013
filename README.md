# Monitoring Sensu and BatsD

This will get you set up with Sensu (including the Admin), BatsD, and a sample Rails app instrumenting business metrics.

## Organization

### BatsD

* /batsd - This holds the configuration for running BatsD
* /batsd-dashboard - A simple dashboard built on top of the BatsD server @ http://github.com/mikeycgto/batsd-dash
* /vendor/batsd - A clone of the BatsD server @ http://github.com/noahhl/batsd

### Sensu

* /sensu - Contains custom checks, handlers, and the Sensu configuration
* /vendor/sensu-admin - A clone of the Sensu Admin rails app @ http://github.com/sensu/sensu-admin
* /vendor/sensu-community-plugins - A clone of the community checks / handlers @ http://github.com/sensu/sensu-community-plugins

### Test App

* /testapp - This is a basic Rails app that demonstrates instrumentation of your code

## Installation

All of these commands should be run from the root directory of this project.

1\. Install Redis on localhost:6379

```
sudo apt-get install redis-server
```

2\. Install RabbitMQ on localhost:5672 with guest/guest auth

```
sudo apt-get install rabbitmq-server
```

3\. Install gems for BatsD, Sensu, Sensu Admin, your Rails app, and this project

```
gem install bundler
bundle install --gemfile=sensu/Gemfile
bundle install --gemfile=vendor/sensu-admin/Gemfile
bundle install --gemfile=batsd-dashboard/Gemfile
bundle install --gemfile=vendor/batsd/Gemfile
bundle install --gemfile=testapp/Gemfile
bundle install
```

4\. Set up Sensu Admin app:

```
BUNDLE_GEMFILE=vendor/sensu-admin/Gemfile bundle exec rake db:create --rakefile vendor/sensu-admin/Rakefile
BUNDLE_GEMFILE=vendor/sensu-admin/Gemfile bundle exec rake db:migrate --rakefile vendor/sensu-admin/Rakefile
BUNDLE_GEMFILE=vendor/sensu-admin/Gemfile bundle exec rake db:seed --rakefile vendor/sensu-admin/Rakefile
```

5\. Set up Test Rails App:

```
BUNDLE_GEMFILE=testapp/Gemfile bundle exec rake db:create --rakefile testapp/Rakefile
BUNDLE_GEMFILE=testapp/Gemfile bundle exec rake db:migrate --rakefile testapp/Rakefile
```

6\. Fill in auth details for PagerDuty

See sensu/config.d/handlers/pagerduty.json

7\. Fire everything up!

```
bundle exec foreman start
```

You'll need to wait a minute or two before checks start firing off and a few more minutes until data starts showing up in BatsD.

## Usage

Once everything is up and running here are a few notes...

### Sensu Admin

Open the admin website at http://localhost:4568.  Use admin@example.com / secret as the e-mail / password.

### Test App

To simulate ad view business metric: http://localhost:3000/ads/1

To simulate conversion business metric: Click "Create conversion" at http://localhost:3000/ads/1

To simulate counts for different response codes, just generate a 404 by going to an invalid URL or generate a 200 by going to a valid URL like http://localhost:3000/ads/1

### BatsD Dashboard

Open the dashboard at http://localhost:8128.  *Note* that this is a very raw dashboard.