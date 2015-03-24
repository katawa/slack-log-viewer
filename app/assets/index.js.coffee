require "jquery"
require "jquery-ujs"
require "lodash"
require "underscore.string"
require "./js/bootstrap.js"
# require "./js/react_init.js.jsx.coffee"

# stylesheets
require "./css/katawa/application.sass"
require "./css/katawa/clearfix.sass"
require "./css/katawa/main.sass"
require "./css/katawa/nav.sass"
require "./css/katawa/pagination.sass"
require "./css/katawa/room.sass"
require "./css/katawa/search.sass"
require "./css/katawa/sidebar.sass"


init_bootstrap = ->
  $(".nav-tabs a").click (e) ->
    e.preventDefault()
    $(this).tab("show")

$(document).ready ->
  init_bootstrap()

