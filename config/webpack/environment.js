const { environment } = require('@rails/webpacker')
const webpack = require('webpack')

environment.plugins = environment.plugins || [];

environment.plugins.set(
  'jquery',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    'window.jQuery': 'jquery',
    Popper: ['popper.js', 'default'],
  })
)

// this is not working
environment.plugins.set(
  'prod',
  new webpack.DefinePlugin({
    'process.env': {
      NODE_ENV: '"production"'
    }
  })
)

module.exports = environment
