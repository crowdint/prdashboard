PRDashboard.PullsRoute = Em.Route.extend
  model: ->
    @store.findAll('pull')

