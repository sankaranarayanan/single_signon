web:          bundle exec thin start -p $PORT -e $RACK_ENV
worker:       bundle exec rake resque:work QUEUE=*
