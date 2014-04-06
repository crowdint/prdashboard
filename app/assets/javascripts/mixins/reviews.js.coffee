PRDashboard.Reviews = Em.Mixin.create
  currentDiff: ''
  currentPR: null
  newComment: null
  notMergeable: Em.computed.not('currentPR.mergeable')

  prepareDiff: (diff) ->
    @set('currentDiff', diff)
    @setDiffModalCallbacks()
    @showDiffModal()

  loadComments: ->
    @store.find('comment', {
      pull: @get('currentPR.number'),
      repo: @get('currentPR.repository.full_name') 
    }).then ((response) ->
      @get('currentPR.comments').addObjects(response)
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

  removePull: (pull) ->
    @get('content').removeObject(pull)
    @get('all').removeObject(pull)

  updatePR: (pull, action) ->
    ga('send', 'event', 'review', action)
    $.ajax
      type: 'PUT'
      url: "/api/v1/pulls/#{pull.get('number')}"
      data:
        repo: pull.get('repository.full_name')
        kind: action
      success: ((response) ->
        @removePull(pull)
        @closeModal()
      ).bind(@)

  getDiff: (pull) ->
    @set('currentPR', pull)
    ga('send', 'event', 'review', 'show')

    $.ajax
      type: 'GET'
      url: "api/v1/diffs/#{pull.get('number')}"
      dataType: 'text'
      data:
        repo: pull.get('repository.full_name')
      success: ((response) ->
        @loadComments()
        @getMergeability()
        @prepareDiff(response)
      ).bind(@)

  getMergeability: ->
    $.ajax
      type: 'GET'
      url: "api/v1/pulls/#{@get('currentPR.number')}/mergeable"
      data:
        repo: @get('currentPR.repository.full_name')
      success: ((response) ->
        @set('currentPR.mergeable', response.mergeable)
      ).bind(@)

