PRDashboard.Interactions = Em.Mixin.create
  actions:
    applyFilter: (filter) ->
      ga('send', 'event', 'pulls', 'filter', filter)
      @filterBy(filter)

    sort: ->
      ga('send', 'event', 'pulls', 'sort', 'created_at')
      @set('sortAscending', !@get('sortAscending'))

    showDiff: (pull) ->
      @getDiff(pull)

    lgtmPR: (pull, text) ->
      @commentPR(pull, text)
      ga('send', 'event', 'review', 'lgtm')

    mergePR: (pull) ->
      @updatePR(pull, 'merge')

    closePR: (pull) ->
      @updatePR(pull, 'close')

    newComment: (pull)->
      @commentPR pull, @get('newComment')
      ga('send', 'event', 'review', 'comment')
      @set 'newComment', null

