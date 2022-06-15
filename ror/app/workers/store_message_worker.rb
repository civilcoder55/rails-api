class StoreMessageWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(json_message_data)
    message_data = JSON.parse(json_message_data)
    message = Message.new(message_data)
    message.save!
  end
end
