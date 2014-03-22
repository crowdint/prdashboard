#= require spec_helper

describe 'PRDashboard.PullsRoute', ->
  pullsController = null

  beforeEach ->
    pullsController = testHelper.lookup 'controller', 'pulls'

  # The fixtures for the AJAX call contains only 1 private pull request.
  it "sets controller 'content' property with private pulls", ->
    visit('/pull_requests').then ->
      expect(pullsController.get('content').length).to.equal(1)

  # I have declared a total of 4 pull requests on the fixtures.
  it "sets controller 'all' property with all the pulls", ->
    visit('/pull_requests').then ->
      expect(pullsController.get('all').length).to.equal(4)

