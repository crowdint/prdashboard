#= require spec_helper

describe 'Dashboard Index', ->
  beforeEach ->
    visit '/pull_requests'

  describe 'Filters section', ->
    it "shows a dropdown with the user's organizations", ->
      expect($('.orgs-dropdown option').length).to.equal(2)

    it "shows a 'Private' filter button", ->
      expect($('.private-filter').length).to.be.ok

    it "shows a 'Public' filter button", ->
      expect($('.public-filter').length).to.be.ok

    it "shows an 'All' filter button", ->
      expect($('.all-filter').length).to.be.ok

    it "'Private' filter has 'active' class by default", ->
      expect($('.private-filter').hasClass('active')).to.be.ok

  context 'when I am on crowdint org (1 private repo, 3 public repos)', ->
    context "and I click on the 'Private' filter", ->
      beforeEach ->
        click '.private-filter'

      it "sets the 'active' class on the button", ->
        expect($('.private-filter').hasClass('active')).to.be.ok

      it 'shows the private repos', ->
        expect($('#pulls-table tbody tr').length).to.equal(1)

    context "and I click on the 'Public' filter", ->
      beforeEach ->
        click '.public-filter'

      it "sets the 'active' class on the button", ->
        expect($('.public-filter').hasClass('active')).to.be.ok

      it 'shows the public repos', ->
        expect($('#pulls-table tbody tr').length).to.equal(3)

    context "and I click on the 'All' filter", ->
      beforeEach ->
        click '.all-filter'

      it "sets the 'active' class on the button", ->
        expect($('.all-filter').hasClass('active')).to.be.ok

      it 'shows all the repos', ->
        expect($('#pulls-table tbody tr').length).to.equal(4)

  context 'when I choose MagmaConf org (1 private repo, 1 public)', ->
    beforeEach ->
      $('.orgs-dropdown').val('MagmaConf').change()
      wait 1000

    it 'shows the private repos by default', ->
      expect($('#pulls-table tbody tr').length).to.equal(1)

    context "and I click on the 'Private' filter", ->
      beforeEach ->
        click '.private-filter'

      it 'shows the private repos', ->
        expect($('#pulls-table tbody tr').length).to.equal(1)

    context "and I click on the 'Public' filter", ->
      beforeEach ->
        click '.public-filter'

      it 'shows the public repos', ->
        expect($('#pulls-table tbody tr').length).to.equal(1)

    context "and I click on the 'All' filter", ->
      beforeEach ->
        click '.all-filter'

      it 'shows all the repos', ->
        expect($('#pulls-table tbody tr').length).to.equal(2)

