#!/usr/bin/env bash
set -o errexit

bundle install

bundle exec rake assets:clobber
bundle exec rake assets:precompile

bundle exec rake db:migrateDISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rake db:migrate:reset




