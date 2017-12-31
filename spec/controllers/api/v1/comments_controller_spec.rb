require 'spec_helper'

describe Api::V1::CommentsController do
  render_views

  describe '#index' do
    let(:comments) do
      [
        Comment.new(
          id: 1,
          body: 'le comment',
          user: {
            login: 'efigarola',
            avatar_url: 'avatar.png'
          }
        )
      ]
    end

    context 'when user is signed in' do
      before do
        GithubService.any_instance.stub(:pull_comments).and_return comments
        signin_user
        xhr :get, :index
      end

      it 'returns status code 200' do
        expect(response.status).to eql 200
      end

      it 'returns comments in the correct json format' do
        expect(response.body).to have_json_path 'comments/0/id'
        expect(response.body).to have_json_path 'comments/0/body'
        expect(response.body).to have_json_path 'comments/0/username'
        expect(response.body).to have_json_path 'comments/0/avatar'
      end
    end

    context 'when user is not signed in' do
      it 'returns "invalid credentials" as json message' do
        xhr :get, :index

        expect(response.body).to match(/Invalid credentials/)
      end
    end
  end

  describe '#create' do
    before do
      GithubService.any_instance.stub(:create_pull_comment)
      GithubService.any_instance.should_receive(:create_pull_comment)
      signin_user
    end

    it 'should return ok status' do
      xhr :post, :create
      expect(response.body).to match(/ok/)
    end
  end
end
