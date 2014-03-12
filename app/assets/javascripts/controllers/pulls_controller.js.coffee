PRDashboard.PullsController = Em.ArrayController.extend
  orgs: []
  org: Em.computed.alias('currentOrg')

  currentOrg: (->
    @get 'orgs.firstObject.name'
  ).property()

  orgDidChange: (->

  ).observes('org')

