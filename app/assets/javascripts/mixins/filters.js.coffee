PRDashboard.Filters = Em.Mixin.create
  all: []
  orgs: []
  org: Em.computed.alias('currentOrg')
  filter: 'private'

  currentOrg: (->
    localStorage.getItem('organization') || @get 'orgs.firstObject.name'
  ).property('orgs.@each')

  orgDidChange: (->
    localStorage.setItem('organization', @get('org'))
    ga('send', 'event', 'organizations', 'change')
    @getPullRequests()
  ).observes('org')

  getPullRequests: ->
    @set('isLoading', true)
    @store.find('pull', organization: @get('org')).then ((pulls) ->
      @set('content', pulls)
      @set('all', pulls)
      @filterBy(@get('filter'))
      @set('isLoading', false)
    ).bind(@)

  filterBy: (filter) ->
    @set('filter', filter)
    @set('content', @get('all')) if filter is 'all'
    @set('content', @get('all').filterBy('is_private')) if filter is 'private'
    @set('content', @get('all').filterBy('is_private', false)) if filter is 'public'

