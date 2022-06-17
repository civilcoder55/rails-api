require 'rails_helper'

RSpec.describe 'Applications', type: :request do
  describe 'update' do
    let!(:application) { FactoryBot.create(:application) }
    context 'with valid parameters' do
      before do
        put "/api/v1/applications/#{application.token}", params: { name: 'updated_app' }
      end

      it 'returns the updated application' do
        response_body = JSON.parse(response.body)
        expect(response_body['token']).to eq(application.token)
        expect(response_body['name']).to eq('updated_app')
        expect(response_body['chats_count']).to be_kind_of(Integer)
        expect(response_body['id']).to eq(nil)
      end

      it 'returns a success status' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid parameters' do
      before do
        put "/api/v1/applications/#{application.token}", params: { name: 'nwe' }
      end

      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
