class App.Routers.MainRouter extends Backbone.Router
  routes:
    '': 'index'

  initialize: ->
    @PoolsView = new App.Views.Pools(collection: new App.Collections.Pools)

  index: ->
    $(document.body).prepend(@PoolsView.render().el)