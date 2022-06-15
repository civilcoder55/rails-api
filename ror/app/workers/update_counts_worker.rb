class UpdateCountsWorker
  include Sidekiq::Worker

  def perform
    # Fetch all application chat counts from redis
    cursor = 0
    apps_keys = []
    loop do
      cursor, keys = REDIS_CLIENT.scan(cursor, match: 'chats_count_*')
      apps_keys += keys
      break if cursor == '0'
    end

    # update all apps chat_counts
    apps_keys.each do |key|
      token = key.split('_')[-1]
      Application.where(token: token).update(chats_count: REDIS_CLIENT.get(key))
    end

    # Fetch all chats counts from redis
    cursor = 0
    chats_keys = []
    loop do
      cursor, keys = REDIS_CLIENT.scan(cursor, match: 'messages_count_*')
      chats_keys += keys
      break if cursor == '0'
    end

    # update all chats message_counts
    chats_keys.each do |key|
      key_elements = key.split('_')
      token = key_elements[2]
      number = key_elements[3]
      Chat.includes(:application).where('applications.token' => token, number: number)
          .update(messages_count: REDIS_CLIENT.get(key))
    end
  end
end
