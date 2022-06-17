require 'rails_helper'

RSpec.describe 'Chats', type: :request do
  describe 'create' do
    let!(:application) do
      FactoryBot.create(:application) do |application|
        FactoryBot.create_list(:chat, 2, application: application)
      end
    end

    before do
      post "/api/v1/applications/#{application.token}/chats/#{application.chats[0].number}/messages",
           params: { body: 'some message' }
    end

    it 'returns the message' do
      response_body = JSON.parse(response.body)
      expect(response_body['number']).to eq(1)
      expect(response_body['body']).to eq('some message')
      expect(response_body['id']).to eq(nil)
    end

    it 'returns a created status' do
      expect(response).to have_http_status(:created)
    end

    it 'returns a correct number' do
      response_body = JSON.parse(response.body)
      expect(response_body['number']).to eq(1)

      # second chat for first chat
      post "/api/v1/applications/#{application.token}/chats/#{application.chats[0].number}/messages",
           params: { body: 'some message 2' }
      response_body = JSON.parse(response.body)
      expect(response_body['number']).to eq(2)

      # first message for second chat
      post "/api/v1/applications/#{application.token}/chats/#{application.chats[1].number}/messages",
           params: { body: 'some message 3' }
      response_body = JSON.parse(response.body)
      expect(response_body['number']).to eq(1)
    end

    it 'queues database write' do
      expect(Message.count).to eq(0)
      expect(StoreMessageWorker.jobs.size).to eq(1)
    end
  end
end
