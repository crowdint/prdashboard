require 'spec_helper'

describe Api::V1::PullsController do
  render_views

  let(:pulls) do
    [
      [
        PullRequest.new(
          id: 1,
          title: 'Test',
          html_url: 'https://github.com/test/test/pulls/1',
          user: {
            id: 1,
            login: 'jbelfort',
            avatar_url: 'https://gravatar.com/12edf135',
            html_url: 'https://github.com/test'
          },
          created_at: Time.zone.now,
          comments: 0,
          number: 1,
          base: {
            repo: {
              id: 1,
              full_name: 'test/test',
              html_url: 'http://github.com/test/test',
              description: 'Some testy description',
              private: true
            }
          }
        )
      ],
      [
        Repository.new(
          id: 1,
          full_name: 'test/test',
          html_url: 'http://github.com/test/test',
          description: 'Some testy description',
          private: true
        )
      ],
      [
        GithubUser.new(
          id: 1,
          login: 'jbelfort',
          avatar_url: 'https://gravatar.com/12edf135',
          html_url: 'https://github.com/test'
        )
      ]
    ]
  end

  describe '#index' do
    context 'when user is signed in' do
      before do
        GithubService.any_instance.stub(:get_pull_requests).and_return pulls
        signin_user
      end

      it 'returns status code 200' do
        xhr :get, :index
        expect(response.status).to eql 200
      end

      it 'returns the pulls json objects in the correct format' do
        xhr :get, :index

        expect(response.body).to have_json_path 'pulls/0/id'
        expect(response.body).to have_json_path 'pulls/0/title'
        expect(response.body).to have_json_path 'pulls/0/url'
        expect(response.body).to have_json_path 'pulls/0/created_at'
        expect(response.body).to have_json_path 'pulls/0/comments_count'
        expect(response.body).to have_json_path 'pulls/0/number'
        expect(response.body).to have_json_path 'pulls/0/is_private'
        expect(response.body).to have_json_path 'pulls/0/repository'
        expect(response.body).to have_json_path 'pulls/0/user'
      end

      it 'returns the repositories json objects in the correct format' do
        xhr :get, :index

        expect(response.body).to have_json_path 'repositories/0/id'
        expect(response.body).to have_json_path 'repositories/0/full_name'
        expect(response.body).to have_json_path 'repositories/0/url'
        expect(response.body).to have_json_path 'repositories/0/description'
        expect(response.body).to have_json_path 'repositories/0/private'
      end

      it 'returns the users json objects in the correct format' do
        xhr :get, :index

        expect(response.body).to have_json_path 'users/0/id'
        expect(response.body).to have_json_path 'users/0/nickname'
        expect(response.body).to have_json_path 'users/0/avatar'
        expect(response.body).to have_json_path 'users/0/url'
      end
    end

    context 'when user is not signed in' do
      it 'returns "invalid credentials" as json message' do
        xhr :get, :index

        expect(response.body).to match /Invalid credentials/
      end
    end
  end

  describe '#update' do
    before do
      GithubService.any_instance.stub(:merge_pull_request)
      Rails.cache.should_receive(:clear)

      signin_user
    end

    it 'should return ok status' do
      patch :update, id: 1
      expect(response.body).to match /ok/
    end
  end
end

