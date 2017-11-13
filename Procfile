bundle: bundle
yarn: yarn install
webpacker: NODE_ENV=production bundle exec rails webpacker:compile
web: bin/rails server -p $PORT -b 0.0.0.0
worker: bundle exec sidekiq -t 25
