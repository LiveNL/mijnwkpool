class App.Models.Pool extends Backbone.Model
  urlRoot: '/pools'

class App.Collections.Pools extends Backbone.Collection
  model: App.Models.Pool
  url: '/pools'