require 'rails_helper'

RSpec.describe 'Chats', type: :request do
  describe 'create' do
    let!(:first_application) { FactoryBot.create(:application) }
    let!(:second_application) { FactoryBot.create(:application) }

    before do
      post "/api/v1/applications/#{first_application.token}/chats"
    end

    it 'returns the chats' do
      response_body = JSON.parse(response.body)
      expect(response_body['number']).to eq(1)
      expect(response_body['messages_count']).to eq(0)
      expect(response_body['id']).to eq(nil)
    end

    it 'returns a created status' do
      expect(response).to have_http_status(:created)
    end

    it 'returns a correct number' do
      response_body = JSON.parse(response.body)
      expect(response_body['number']).to eq(1)

      # second chat for first app
      post "/api/v1/applications/#{first_application.token}/chats"
      response_body = JSON.parse(response.body)
      expect(response_body['number']).to eq(2)

      # first chat for second app
      post "/api/v1/applications/#{second_application.token}/chats"
      response_body = JSON.parse(response.body)
      expect(response_body['number']).to eq(1)
    end

    it 'queues database write' do
      expect(Chat.count).to eq(0)
      expect(StoreChatWorker.jobs.size).to eq(1)
    end
  end
end
