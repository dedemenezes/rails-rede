const path    = require("path")
const webpack = require('webpack')

module.exports = {
  mode: "production",
  entry: {
    application: "./app/javascript/application.js",
  },
  output: {
    filename: "[name].js",
    path: path.resolve(__dirname, "app/assets/builds"),
  },
  module: {},
  plugins: [
    new webpack.optimize.LimitChunkCountPlugin({
      maxChunks: 1
    }),
  ]
}
