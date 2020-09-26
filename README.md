# Pokélingual

Pokélingual is a English/Japanese Pokedex to designed to help learn Japanese.  
ポケリンガルは英語の勉強を支援するために開発した日英ポケモン図鑑です。

## Installation instructions / インストール方法 (Ubuntu 18.04, 20.04)

Install rbenv

    curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash
    source ~/.bashrc

Install dependencies for Ruby install

    sudo apt install build-essential libssl-dev libreadline-dev zlib1g-dev

Install Ruby 2.7.1

    rbenv install 2.7.1
    rbenv global 2.7.1

Install Node.js

    sudo apt install nodejs

Install yarn

    npm install -g yarn

Install SQLite client library

    sudo apt install libsqlite3-dev

Install Elasticsearch

    curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
    echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
    sudo apt update
    sudo apt install elasticsearch

Clone repo

    git clone git@github.com:summersky1/pokelingual.git

Install dependencies

    bundle install
    yarn install

Setup database

    bundle exec rails db:migrate
    bundle exec rails db:seed
