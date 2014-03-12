PRDashboard.PullsRoute = Em.Route.extend
  model: ->
    @store.find('pull', organization: @controllerFor('pulls').get('org'))

