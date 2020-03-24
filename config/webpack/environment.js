const { environment } = require('@rails/webpacker')
const vue =  require('./loaders/vue')

const webpack = require('webpack')
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery'
  })
)

environment.loaders.append('vue', vue)
module.exports = environment
