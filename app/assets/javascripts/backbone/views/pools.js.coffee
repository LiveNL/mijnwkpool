class App.Views.Pools extends Backbone.View

  className: 'pools'

  initialize: ->
    @listenTo @collection, 'reset', @render
    @collection.fetch({ reset: true })

  render: ->
    @collection.forEach @renderPool, @
    @

  renderPool: (model) ->
    v = new App.Views.Pool({ model: model})
    @$el.append(v.render().el)