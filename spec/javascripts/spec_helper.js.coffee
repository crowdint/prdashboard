#= require sinon
#= require application
#= require ember_application
#= require ember_mocha_adapter
#= require support/fake_server
#= require_tree ./support/fixtures

Ember.Test.adapter = Ember.Test.MochaAdapter.create()
PRDashboard.setupForTesting()
PRDashboard.injectTestHelpers()

mocha.ui 'bdd'
mocha.globals ['Ember', 'DS', 'PRDashboard', 'MD5']
mocha.timeout 5
chai.config.includeStack = true

ENV = {
  TESTING: true
}

window.testHelper =
  lookup: (object, object_name) ->
    name = object_name || "main"
    PRDashboard.__container__.lookup "#{object}:#{name}"

PRDashboard.Router.reopen
  location: 'none'

Konacha.reset = Em.K

$.fx.off = true

afterEach ->
  PRDashboard.reset()

PRDashboard.advanceReadiness()

