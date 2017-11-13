# URL Shortener DEMO

This is my URL Shortener. There are many like it, but this one is mine.

### Tech
* [VueJS](https://vuejs.org)
* [Ruby 2.4.0](https://www.ruby-lang.org/en/)
* [Rails 5.1.4](http://rubyonrails.org/)

### Installation

This app requires
 * [wget](https://www.gnu.org/software/wget/)
 * [nodejs](https://nodejs.org/en/)
 * [yarn](https://yarnpkg.com/en/)

to run.

Install the dependencies and devDependencies and start the server.

```sh
$ cd url_shortener
$ bundle
$ yarn install
$ bundle exec rails webpacker:compile
```

For production environments...

```sh
$ NODE_ENV=production bundle exec rails webpacker:compile
```
