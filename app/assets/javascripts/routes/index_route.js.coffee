PRDashboard.IndexRoute = Em.Route.extend
  redirect: ->
    @transitionTo('pulls')

