var path = require("path");
var webpack = require("webpack");
var sass_loader_option =
  "style!css!sass?indentedSyntax=sass" +
  "&includePaths[]=" + path.resolve(__dirname, "./app/assets/css/") +
  "&includePaths[]=" + path.resolve(__dirname, "./node_modules/compass-mixins/lib/")
;
module.exports = {
  cache: true,
  useMemoryFs: true,
  progress: true,
  devTool: "sourcemap",
  entry: {
    app: "./app/assets/index.js.coffee"
  },
  output: {
    path: path.join(__dirname, "public/assets/"),
    publicPath: "/assets/",
    filename: "index.js",
  },
  module: {
    loaders: [
      { test: /\.(png|jpe?g|gif)$/, loader: "file?name=[name]-[hash].[ext]" },
      { test: /\.css$/, loader: "style!css" },
      { test: /\.sass$/, loader: sass_loader_option },
      { test: /\.js\.coffee$/, loader: "coffee" },
      { test: /\.jade$/, loader: "react-jade-loader" },
      // fonts
      { test: /\.woff(\?v=\d+\.\d+\.\d+)?$/, loader: "url?limit=90000&mimetype=application/font-woff" },
      { test: /\.woff2(\?v=\d+\.\d+\.\d+)?$/, loader: "url?limit=90000&mimetype=application/font-woff" },
      { test: /\.ttf(\?v=\d+\.\d+\.\d+)?$/, loader: "url?limit=90000&mimetype=application/octet-stream" },
      { test: /\.eot(\?v=\d+\.\d+\.\d+)?$/, loader: "file" },
      { test: /\.svg(\?v=\d+\.\d+\.\d+)?$/, loader: "url?limit=90000&mimetype=image/svg+xml" },
      // required for react jsx
      { test: /\.jsx\.coffee$/, loader: "jsx?insertPragma=React.DOM!coffee" },
    ]
  },
  resolve: {
    root: [path.join(__dirname, "bower_components")],
    extensions: ["", ".js"]
  },
  plugins: [
    new webpack.ResolverPlugin(
      new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin("bower.json", ["main"])
    ),
    new webpack.ProvidePlugin({
      // Automtically detect jQuery and $ as free var in modules
      // and inject the jquery library
      // This is required by many jquery plugins
      jQuery: "jquery",
      $: "jquery"
    })
  ]
};
