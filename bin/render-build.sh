#!/usr/bin/env bash
set -o errexit

export RAILS_ENV=production

bundle install


bundle exec rake assets:clobber
bundle exec rake assets:precompile


bundle exec rake db:migrate