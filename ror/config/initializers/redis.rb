REDIS_CLIENT = if Rails.env.test?
                 MockRedis.new

               else
                 Redis.new(url: ENV['REDIS_URL'], port: ENV['REDIS_PORT'], db: ENV['REDIS_DB'])

               end
