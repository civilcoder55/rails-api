class StoreChatWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(json_chat_data)
    chat_data = JSON.parse(json_chat_data)
    chat = Chat.new(chat_data)
    chat.save!
  end
end
