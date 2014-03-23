#= require spec_helper

describe 'PRDashboard.PullsRoute', ->
  pullsController = null

  beforeEach ->
    pullsController = testHelper.lookup 'controller', 'pulls'
    Em.run ->
      pullsController.set('org', 'crowdint')

    visit '/pull_requests'

  # The fixtures for the AJAX call contains only 1 private pull request.
  it "sets controller 'content' property with private pulls", ->
    expect(pullsController.get('content').toArray().length).to.equal(1)

  # I have declared a total of 4 pull requests on the fixtures.
  it "sets controller 'all' property with all the pulls", ->
    expect(pullsController.get('all').toArray().length).to.equal(4)

