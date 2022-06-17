require 'rails_helper'

RSpec.describe 'Messages', type: :request do
  describe 'index' do
    let!(:application) do
      FactoryBot.create(:application) do |application|
        FactoryBot.create(:chat, application: application) do |chat|
          FactoryBot.create_list(:message, 10, chat: chat)
        end
      end
    end

    before do
      get "/api/v1/applications/#{application.token}/chats/#{application.chats[0].number}/messages"
    end

    it 'returns all messages' do
      expect(JSON.parse(response.body).size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end

    it 'returns results without primary key' do
      expect(JSON.parse(response.body)[0].keys).to contain_exactly('number', 'body', 'created_at',
                                                                   'updated_at')
    end
  end

  describe 'show' do
    let!(:application) do
      FactoryBot.create(:application) do |application|
        FactoryBot.create(:chat, application: application) do |chat|
          FactoryBot.create(:message, chat: chat)
        end
      end
    end

    context 'exists' do
      before do
        get "/api/v1/applications/#{application.token}/chats/#{application.chats[0].number}/messages/#{application.chats[0].messages[0].number}"
      end

      it 'returns results without primary key' do
        expect(JSON.parse(response.body).keys).to contain_exactly('number', 'body', 'created_at',
                                                                  'updated_at')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'not exists' do
      before do
        get "/api/v1/applications/#{application.token}/chats/#{application.chats[0].number}/messages/123435"
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
