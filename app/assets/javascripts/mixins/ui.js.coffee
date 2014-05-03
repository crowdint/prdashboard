PRDashboard.UI = Em.Mixin.create
  setDiffModalCallbacks: ->
    $('#diffs-modal').on 'shown.bs.modal', ->
      hljs.configure({tabReplace: '  '})
      Em.run.later ->
        hljs.highlightBlock($('pre code')[0])
      , 100

  showDiffModal: ->
    @resizeModal()
    $('#diffs-modal').modal('show')

  resizeModal: ->
    $('pre').css('height', $(window).height() - 280)
    $('.pr-comments').css('height', $(window).height() - 280)
    $('.modal-body').css('height', $(window).height() - 250)

  closeModal: ->
    $('#diffs-modal').modal('hide')

