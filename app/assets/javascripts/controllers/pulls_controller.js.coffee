PRDashboard.PullsController = Em.ArrayController.extend
  orgs: []
  org: Em.computed.alias('currentOrg')

  currentOrg: (->
    @get 'orgs.firstObject.name'
  ).property()

  orgDidChange: (->
    @getPullRequests()
  ).observes('org')

  getPullRequests: ->
    @store.find('pull', organization: @get('org')).then ((pulls) ->
      @set('content', pulls)
    ).bind(@)

