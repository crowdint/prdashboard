require 'spec_helper'

describe GithubService do
  let(:subject) do
    GithubService.new('09348dsoij00')
  end

  describe '#initialize' do
    it 'should set the token' do
      expect(subject.token).to eql '09348dsoij00'
    end

    it 'should create a github_api instance' do
      expect(subject.github).to be_a Github::Client
    end
  end

  describe '#get_pull_requests' do
    let(:repos) do
      [
        OpenStruct.new(name: 'crowdint', issues_count: 1)
      ]
    end

    let(:pulls) do
      [
        url: "https://api.github.com/repos/crowdint/rails3-jquery-autocomplete/pulls/264",
        id: 13748176,
        html_url: "https://github.com/crowdint/rails3-jquery-autocomplete/pull/264",
        number: 264,
        title: "1.0.13 broken for Mongoid, items is not an array",
        user: {
          login: "danielfarrell",
          id: 13850,
          avatar_url: "https://avatars.githubusercontent.com/u/13850?",
          html_url: "https://github.com/danielfarrell",
        created_at: "2014-03-19T17:21:27Z",
 "base"=>
   "repo"=>
    {"id"=>778055,
     "name: rails3-jquery-autocomplete",
     "full_name: crowdint/rails3-jquery-autocomplete",
     "private"=>false,
     "html_url: https://github.com/crowdint/rails3-jquery-autocomplete",
     "description"=>
      "An easy and unobtrusive way to use jQuery's autocomplete with Rails 3",
      ]
    end

    before do
      subject.stub(:repos_for).and_return repos
      Github::Client.any_instance.stub_chain(:pull_requests, :list).and_return pulls

    end
    it 'return pull requests' do
      expect(subject.get_pull_requests('crowdint')).to be_true
    end
  end
end

