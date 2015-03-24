path = require("path")
gulp = require("gulp")
gutil = require("gulp-util")
webpack = require("webpack")
webpackDevServer = require("webpack-dev-server")
webpackConfig = require("./webpack.config.js")


gulp.task "webpack:build", (callback) ->
  config = Object.create(webpackConfig)
  config.debug = false
  config.plugins = config.plugins.concat(
    new webpack.DefinePlugin({
      "process.env": {
        "NODE_ENV": JSON.stringify("production")
      }
    }),
    new webpack.optimize.DedupePlugin(),
    new webpack.optimize.UglifyJsPlugin()
  )

  webpack config, (err, stats) ->
    if err
      throw new gutil.PluginError("webpack:build", err)
      gutil.log "[webpack:build]", stats.toString({
        colors: true
      })
    callback()


gulp.task "webpack:dev-server", (callback) ->
  config = Object.create(webpackConfig)
  config.devtool = "eval"
  config.debug = true

  gutil.log "[webpack]", "config = #{config.output.path}"
  gutil.log "[webpack]", "config = #{config.output.publicPath}"

  new webpackDevServer(webpack(config), {
    publicPath: "/" + config.output.publicPath,
    stats:
      colors: true

  }).listen 8080, "localhost", (err) ->
    if err
      throw new gutil.PluginError("webpack-dev-server", err)

    # webpack
    gutil.log "[webpack]", "dev server started listening at http://localhost:8080/"

    # keep the server alive or continue?
    # callback()


# the default task for development environments
gulp.task "build", [
  "webpack:build",
]
gulp.task "default", [
  "webpack:dev-server",
]

