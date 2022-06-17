require 'rails_helper'

RSpec.describe 'Chats', type: :request do
  describe 'index' do
    before do
      application = FactoryBot.create(:application) do |application|
        FactoryBot.create_list(:chat, 10, application: application)
      end
      get "/api/v1/applications/#{application.token}/chats"
    end

    it 'returns all chats' do
      expect(JSON.parse(response.body).size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end

    it 'returns results without primary key' do
      expect(JSON.parse(response.body)[0].keys).to contain_exactly('number', 'messages_count', 'created_at',
                                                                   'updated_at')
    end
  end

  describe 'show' do
    let!(:application) do
      FactoryBot.create(:application) do |application|
        FactoryBot.create(:chat, application: application)
      end
    end
    context 'exists' do
      before do
        get "/api/v1/applications/#{application.token}/chats/#{application.chats[0].number}"
      end

      it 'returns results without primary key' do
        expect(JSON.parse(response.body).keys).to contain_exactly('number', 'messages_count', 'created_at',
                                                                  'updated_at')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'not exists' do
      before do
        get "/api/v1/applications/#{application.token}/chats/135454"
      end

      it 'returns not found message' do
        expect(JSON.parse(response.body)).to contain_exactly(['message', 'resource not found'])
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
