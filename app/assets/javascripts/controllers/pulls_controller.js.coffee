PRDashboard.PullsController = Em.ArrayController.extend
  orgs: []
  org: Em.computed.alias('currentOrg')
  isLoading: false

  currentOrg: (->
    @get 'orgs.firstObject.name'
  ).property()

  orgDidChange: (->
    @getPullRequests()
  ).observes('org')

  getPullRequests: ->
    @set('isLoading', true)
    @store.find('pull', organization: @get('org')).then ((pulls) ->
      @set('content', pulls)
      @set('isLoading', false)
    ).bind(@)

