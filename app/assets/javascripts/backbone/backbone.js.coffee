#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.App =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}
  Vent: _.clone(Backbone.Events)


  initialize: ->
    new App.Routers.MainRouter()
    Backbone.history.start()