PRDashboard.PullsController = Em.ArrayController.extend
  all: Em.computed.alias('allPulls')
  orgs: []
  org: Em.computed.alias('currentOrg')
  isLoading: false

  currentOrg: (->
    @get 'orgs.firstObject.name'
  ).property('orgs.@each')

  allPulls: (->
    @get 'content'
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

  actions:
    applyFilter: (filter) ->
      @set('content', @get('all')) if filter is 'all'
      @set('content', @get('all').filterBy('repository.private')) if filter is 'private'
      @set('content', @get('all').filterBy('repository.private', false)) if filter is 'public'


