mailcatcher: /usr/bin/mailcatcher -f --smtp-port=5000 --ip=127.0.0.1
redis: redis-server
worker: bundle exec sidekiq -q default -q mailers
