const { environment } = require('@rails/webpacker')

module.exports = environment
environment.loaders.get('nodeModules').exclude = [/\.config.js$/, /node_modules\/(?!(stimulus))/]

