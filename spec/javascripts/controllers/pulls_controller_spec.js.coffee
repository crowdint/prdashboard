#= require spec_helper

describe 'PRDashboard.PullsController', ->
  pullsController = null

  beforeEach ->
    pullsController = testHelper.lookup 'controller', 'pulls'
    Em.run ->
      pullsController.set('org', 'crowdint')

    visit '/pull_requests'

  describe '#publicCount', ->
    it 'returns 3', ->
      expect(pullsController.get('publicCount')).to.equal(3)

  describe '#privateCount', ->
    it 'returns 1', ->
      expect(pullsController.get('privateCount')).to.equal(1)

  describe '#allCount', ->
    it 'returns 4', ->
      expect(pullsController.get('allCount')).to.equal(4)

  describe '#filterBy', ->
    context "when I filter with 'all' param", ->
      it "sets the controller's content property to the total of pulls", ->
        Em.run ->
          pullsController.filterBy('all')
        expect(pullsController.get('content').length).to.equal(pullsController.get('all').length)

    context "when I filter with 'private' param", ->
      it "sets the controller's content property to the total of private pulls", ->
        Em.run ->
          pullsController.filterBy('private')
        expect(pullsController.get('content').length).to.equal(1)

    context "when I filter with 'public' param", ->
      it "sets the controller's content property to the total of public pulls", ->
        Em.run ->
          pullsController.filterBy('public')
        expect(pullsController.get('content').length).to.equal(3)

  describe '#commentPR', ->
    pull = null
    commentText = null

    beforeEach ->
      sinon.spy($, 'ajax')
      pull = pullsController.get('content.firstObject')
      commentText = 'Awesome work!'
      pullsController.commentPR(pull, commentText)

    afterEach ->
      $.ajax.restore()

    it 'calls the $.ajax method', ->
      expect($.ajax.calledOnce).to.equal(true)

    it 'makes the call to the correct URL', ->
      expect($.ajax.getCall(0).args[0].url).to.equal('/api/v1/comments')

    it 'makes a POST call', ->
      expect($.ajax.getCall(0).args[0].type).to.equal('POST')

    it "sends a correct 'repo' param", ->
      expect($.ajax.getCall(0).args[0].data.repo).to.equal(pull.get('repository.full_name'))

    it "sends a correct 'pull' param", ->
      expect($.ajax.getCall(0).args[0].data.pull).to.equal(pull.get('number'))

    it "sends a correct 'text' param", ->
      expect($.ajax.getCall(0).args[0].data.text).to.equal(commentText)

  describe '#updatePR', ->
    pull = null
    action = null

    beforeEach ->
      sinon.spy($, 'ajax')
      pull = pullsController.get('content.firstObject')
      action = 'merge'
      pullsController.updatePR(pull, action)

    afterEach ->
      $.ajax.restore()

    it 'calls the $.ajax method', ->
      expect($.ajax.calledOnce).to.equal(true)

    it 'makes the call to the correct URL', ->
      expect($.ajax.getCall(0).args[0].url).to.equal("/api/v1/pulls/#{pull.get('number')}")

    it 'makes a PUT call', ->
      expect($.ajax.getCall(0).args[0].type).to.equal('PUT')

    it "sends a correct 'repo' param", ->
      expect($.ajax.getCall(0).args[0].data.repo).to.equal(pull.get('repository.full_name'))

    it "sends a correct 'kind' param", ->
      expect($.ajax.getCall(0).args[0].data.kind).to.equal(action)

  describe '#getDiff', ->
    pull = null

    beforeEach ->
      sinon.spy($, 'ajax')
      pull = pullsController.get('content.firstObject')
      Em.run ->
        pullsController.getDiff(pull)

    afterEach ->
      $.ajax.restore()

    it "sets controller's currentPR property", ->
      expect(pullsController.get('currentPR')).to.equal(pull)

    it 'calls the $.ajax method', ->
      expect($.ajax.calledOnce).to.equal(true)

    it 'makes the call to the correct URL', ->
      expect($.ajax.getCall(0).args[0].url).to.equal("api/v1/diffs/#{pull.get('number')}")

    it 'makes a GET call', ->
      expect($.ajax.getCall(0).args[0].type).to.equal('GET')

    it "sends a correct 'repo' param", ->
      expect($.ajax.getCall(0).args[0].data.repo).to.equal(pull.get('repository.full_name'))

  describe '#removePull', ->
    pull = null

    beforeEach ->
      pull = pullsController.get('content.firstObject')

      Em.run ->
        pullsController.removePull(pull)

    it "removes a pull object from controller's content property", ->
      expect(pullsController.get('content').contains(pull)).to.equal(false)

    it "removes a pull object from controller's all property", ->
      expect(pullsController.get('all').contains(pull)).to.equal(false)

