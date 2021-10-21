#!/bin/bash


set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

if ! bundle check ; then
  bundle install
fi

if ping -w 100 -c 1 $POSTGRES_HOST &> /dev/null; then
  (bundle exec rake db:check) || (bundle exec rake db:create && bundle exec rake db:migrate && bundle exec rake db:seed)
  (bundle exec rake db:migrate:status | grep "^\s*down") && bundle exec rake db:migrate || echo "No pending migrations found."
fi

exec "$@"
