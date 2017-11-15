#!/usr/bin/env bash

rails db:migrate 2>/dev/null || rails db:create
rails db:migrate

yarn install
rails webpacker:compile
webpack

puma -C config/puma.rb
