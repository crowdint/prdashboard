Em.ChosenSelect = Em.UnboundSelect.extend
  chosenSelection: Em.A()
  chosenInput: null
  chosenClass: ''

  didInsertElement: ->
    @set('chosenInput', $(".#{@get('chosenClass')}"))
    @get('chosenInput').chosen
      search_contains: true

    @get('chosenInput').chosen().change ((evt, elem) ->
      if elem.selected
        @get('chosenSelection').addObject(elem.selected)
      else if elem.deselected
        @get('chosenSelection').removeObject(elem.deselected)
    ).bind(@)

  contentDidChange: (->
    Em.run.next @, ->
      @get('chosenInput').trigger('chosen:updated')
      @get('chosenInput').val('').trigger('chosen:updated');
  ).observes('content')

