PRDashboard.Filters = Em.Mixin.create
  all: Em.A()
  orgs: Em.A()
  org: Em.computed.alias('currentOrg')
  repos: Em.A()
  selectedRepos: Em.A()
  filter: 'private'

  currentOrg: (->
    localStorage.getItem('organization') || @get 'orgs.firstObject.name'
  ).property('orgs.@each')

  orgDidChange: (->
    localStorage.setItem('organization', @get('org'))
    ga('send', 'event', 'organizations', 'change')
    @getPullRequests()
  ).observes('org')

  repoDidChange: (->
    @filterBy(@get('selectedRepos'), true)
  ).observes('selectedRepos.@each')

  getPullRequests: ->
    @set('isLoading', true)
    @store.find('pull', organization: @get('org')).then ((pulls) ->
      @set('content', pulls)
      @set('all', pulls)
      @filterBy(@get('filter'))
      @set('isLoading', false)
    ).bind(@)

  filterBy: (filter, byRepo = false) ->
    if byRepo
      filtered = Em.A()

      return @filterBy(@get('filter')) unless filter.length

      filter.forEach ((repo) ->
        filtered.addObjects @get('all').filterBy('repository.full_name', repo)
      ).bind(@)

      @set('content', filtered)
    else
      @set('filter', filter)
      @set('content', @get('all')) if filter is 'all'
      @set('content', @get('all').filterBy('is_private')) if filter is 'private'
      @set('content', @get('all').filterBy('is_private', false)) if filter is 'public'
      @set('repos', @get('content').mapProperty('data.repository').uniq())

