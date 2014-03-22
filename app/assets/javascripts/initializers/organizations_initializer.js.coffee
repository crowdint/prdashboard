PRDashboard.initializer
  name: 'organizations_load'

  initialize: (container, application) ->
    store = container.lookup('store:main')

    store.findAll('organization').then (organizations) ->
      container.lookup('controller:pulls').set('orgs', organizations)
      application.advanceReadiness()

