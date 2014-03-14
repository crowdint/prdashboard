PRDashboard.PullsController = Em.ArrayController.extend
  sortProperties: ['created_at']
  all: []
  orgs: []
  org: Em.computed.alias('currentOrg')
  isLoading: false
  currentDiff: ''
  currentPR: null
  filter: 'private'

  privateCount: (->
    @get('all').filterBy('is_private').length
  ).property('all.@each')


  publicCount: (->
    @get('all').filterBy('is_private', false).length
  ).property('all.@each')


  allCount: (->
    @get('all.length')
  ).property('all.@each')

  currentOrg: (->
    @get 'orgs.firstObject.name'
  ).property('orgs.@each')

  orgDidChange: (->
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
    @resizeModal()
    $('#diffs-modal').modal('show')

  resizeModal: ->
    $('pre').css('height', $(window).height() - 280)
    $('.modal-body').css('height', $(window).height() - 250)

  closeModal: ->
    $('#diffs-modal').modal('hide')

  filterBy: (filter) ->
    @set('filter', filter)
    @set('content', @get('all')) if filter is 'all'
    @set('content', @get('all').filterBy('is_private')) if filter is 'private'
    @set('content', @get('all').filterBy('is_private', false)) if filter is 'public'

  loadComments: ->
    @store.find('comment', {
      pull: @get('currentPR.number'),
      repo: @get('currentPR.repository.full_name') 
    }).then ((response) ->
      @get('currentPR.comments').addObjects(response)
    ).bind(@)

  actions:
    applyFilter: (filter) ->
      @filterBy(filter)

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
          @loadComments()
          @prepareDiff(response)
        ).bind(@)

    commentPR: (pull, text) ->
      $.ajax
        type: 'POST'
        url: '/api/v1/comments'
        data:
          repo: pull.get('repository.full_name')
          pull: pull.get('number')
          text: text
        success: (->
          @closeModal()
        ).bind(@)


