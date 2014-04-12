require 'spec_helper'

describe Api::V1::DiffsController do
  render_views

  describe '#show' do
    context 'when user is signed in' do
      let(:diff) { "le diff" }

      before do
        GithubService.any_instance.stub(:diff).and_return diff
        signin_user
        xhr :get, :show, id: 1
      end

      it 'returns status code 200' do
        expect(response.status).to eql 200
      end

      it 'renders the correct text' do
        expect(response.body).to match(/le diff/)
      end
    end

    context 'when user is not signed in' do
      it 'returns "invalid credentials" as json message' do
        xhr :get, :show, id: 1

        expect(response.body).to match(/Invalid credentials/)
      end
    end
  end
end

