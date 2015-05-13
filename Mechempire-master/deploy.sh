git pull -u origin master
bundle install
rake assets:precompile
sudo service nginx restart
