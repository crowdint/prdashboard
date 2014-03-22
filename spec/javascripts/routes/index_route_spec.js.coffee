#= require spec_helper

describe 'Index Route', ->

  it 'redirects to PullsRoute', ->
    mock = sinon.mock(testHelper.lookup('route', 'index'))
    mock.expects('transitionTo').once().withExactArgs('pulls')

    visit '/'

    mock.verify()
    mock.restore()

