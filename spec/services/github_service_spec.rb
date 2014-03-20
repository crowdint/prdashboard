require 'spec_helper'

describe GithubService do
  let(:subject) do
    GithubService.new('leusertoken123')
  end

  describe '#initialize' do
    it 'should set the token' do
      expect(subject.token).to eql 'leusertoken123'
    end

    it 'should create a github_api instance' do
      expect(subject.github).to be_a Github::Client
    end
  end

  describe '#get_pull_requests' do
    let(:repos) do
      [
        OpenStruct.new(name: 'rails3-jquery-autocomplete', issues_count: 1)
      ]
    end

    let(:pulls) do
      [
        {
          id: 13748176,
          html_url: "https://github.com/crowdint/rails3-jquery-autocomplete/pull/264",
          number: 264,
          title: "1.0.13 broken for Mongoid, items is not an array",
          created_at: "2014-03-19T17:21:27Z",
          user: {
            login: "danielfarrell",
            id: 13850,
            avatar_url: "https://avatars.githubusercontent.com/u/13850?",
            html_url: "https://github.com/danielfarrell"
          },
          base: {
            repo: {
              id: 778055,
              name: "rails3-jquery-autocomplete",
              full_name: "crowdint/rails3-jquery-autocomplete",
              private: false,
              html_url: "https://github.com/crowdint/rails3-jquery-autocomplete",
              description: "An easy and unobtrusive way to use jQuery's autocomplete with Rails 3"
            }
          }
        }
      ]
    end

    before do
      subject.stub(:repos_for).and_return repos
      Github::Client.any_instance.stub_chain(:pull_requests, :list).and_return pulls
    end

    it 'returns pulls objects as the first positon of array' do
      expect(subject.get_pull_requests('crowdint')[0].first).to be_a PullRequest
    end

    it 'returns repositories objecs as the second position of array' do
      expect(subject.get_pull_requests('crowdint')[1].first).to be_a Repository
    end

    it 'returns github users objects as the last position of array' do
      expect(subject.get_pull_requests('crowdint')[2].first).to be_a GithubUser
    end
  end

  describe '#get_organizations' do
    let(:body) do
      [
        {
          id: 12345,
          login: 'crowdint',
          avatar_url: 'gravatar.com/avatar.png'
        },
        {
          id: 98765,
          login: 'magmaconf',
          avatar_url: 'gravatar.com/avatar.png'
        }
      ]
    end

    let(:env) do
      {
        status: 200,
        body: body,
        response_headers: {
          'Content-Type' => 'text/plain'
        }
      }
    end

    let(:res) { Faraday::Response.new env }
    let(:orgs) { Github::ResponseWrapper.new res, nil }

    before do
      Github::Client.any_instance.stub_chain(:orgs, :list).and_return orgs
    end

    it 'returns an array with 2 objects' do
      expect(subject.get_organizations.size).to eql 2
    end

    it 'returns Organization objects' do
      expect(subject.get_organizations.first).to be_a Organization
    end
  end

end

