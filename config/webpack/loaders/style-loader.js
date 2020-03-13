module.exports = {
  test: /\.(sass)$/,
  use: [{
    loader: 'css-loader'
  },{
    loader: 'style-loader'
  }, {
    loader: 'sass-loader'
  }
  ]
}
