require 'rails_helper'

RSpec.describe 'Applications', type: :request do
  describe 'create' do
    context 'with valid parameters' do
      before do
        post '/api/v1/applications', params: { name: 'first_app' }
      end

      it 'returns the application' do
        response_body = JSON.parse(response.body)
        expect(response_body.keys).to include('token')
        expect(response_body['name']).to eq('first_app')
        expect(response_body['chats_count']).to eq(0)
        expect(response_body['id']).to eq(nil)
      end

      it 'returns a created status' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      before do
        post '/api/v1/applications', params: { name: 'asd' }
      end

      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
