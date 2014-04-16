class App.Views.Pool extends Backbone.View

  className: 'pool'

  template: HandlebarsTemplates['backbone/templates/pool']

  initialize: ->
    @listenTo @model, 'sync', @render
    @model.fetch()

  render: ->
    @$el.html(@template(@model.toJSON()))
    @