PRDashboard.PullsController = Em.ArrayController.extend
  sortProperties: ['created_at']
  all: Em.computed.alias('allPulls')
  orgs: []
  org: Em.computed.alias('currentOrg')
  isLoading: false
  currentDiff: ''
  currentPR: null

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

  prepareDiff: (diff) ->
    @set('currentDiff', diff)
    @setDiffModalCallbacks()
    @showDiffModal()

  setDiffModalCallbacks: ->
    $('#diffs-modal').on 'shown.bs.modal', ->
      hljs.configure({tabReplace: '  '})
      $('pre code').each (i, e) ->
        hljs.highlightBlock(e)

  showDiffModal: ->
    $('#diffs-modal').modal('show')

  actions:
    applyFilter: (filter) ->
      @set('content', @get('all')) if filter is 'all'
      @set('content', @get('all').filterBy('repository.private')) if filter is 'private'
      @set('content', @get('all').filterBy('repository.private', false)) if filter is 'public'

    sort: ->
      @set('sortAscending', !@get('sortAscending'))

    showDiff: (pull) ->
      @set('currentPR', pull)

      $.ajax
        type: 'GET'
        url: "api/v1/diffs/#{pull.get('number')}"
        dataType: 'text'
        data:
          repo: pull.get('repository.full_name')
        success: ((response) ->
          @prepareDiff(response)
        ).bind(@)


