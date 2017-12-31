require 'spec_helper'

describe Api::V1::OrganizationsController do
  render_views

  describe '#index' do
    context 'when user is signed in' do
      let(:organizations) do
        [
          Organization.new(
            id: 1,
            login: 'Crowdint',
            avatar_url: 'avatar.png'
          )
        ]
      end

      before do
        GithubService.any_instance.stub(:organizations).and_return organizations
        signin_user
      end

      it 'returns status code 200' do
        xhr :get, :index

        expect(response.status).to eql 200
      end

      it 'returns organizations json object in the correct format' do
        xhr :get, :index

        expect(response.body).to have_json_path 'organizations/0/id'
        expect(response.body).to have_json_path 'organizations/0/name'
        expect(response.body).to have_json_path 'organizations/0/avatar'
      end
    end

    context 'when user is not signed in' do
      it 'returns "invalid credentials" as json message' do
        xhr :get, :index

        expect(response.body).to match(/Invalid credentials/)
      end
    end
  end
end
