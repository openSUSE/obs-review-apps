#!/bin/bash

cd /obs/src/api
echo "Preparing application..."
rm -rf tmp/pids/server.pid
rm -rf log/development.sphinx.pid

bundle config build.ffi --enable-system-libffi
bundle config build.nokogiri --use-system-libraries
bundle config build.sassc --disable-march-tune-native
bundle config build.nio4r --with-cflags='-Wno-return-type'
bundle config set --local path 'vendor/bundle'
bundle install --jobs=4 --retry=3 --local

RAILS_ENV=development bundle exec rake dev:bootstrap
RAILS_ENV=development bundle exec rake assets:precompile
RAILS_ENV=development bundle exec rake sphinx:start
RAILS_ENV=development bundle exec rake dev:development_testdata:create
RAILS_ENV=development bundle exec rake ts:stop

echo "Starting application..."
foreman start -p 3000
