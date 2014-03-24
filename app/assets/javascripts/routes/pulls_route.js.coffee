PRDashboard.PullsRoute = Em.Route.extend
  model: ->
    @store.find('pull', organization: @controllerFor('pulls').get('org'))

  setupController: (controller, model) ->
    controller.set('content', model.filterBy('is_private'))
    controller.set('all', model)
    controller.set('repos', controller.get('content').mapProperty('data.repository').uniq())

