const { environment } = require('@rails/webpacker')

const webpack = require("webpack")

// tell Bootstrap where to look for the modules
environment.plugins.append("Provide", new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    Popper: ['popper.js', 'default']
}))

module.exports = environment
