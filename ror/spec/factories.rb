FactoryBot.define do
  factory :application do
    name { Faker::App.name + ' ' + Faker::App.name } # to ensure long name
  end

  factory :chat do
    sequence :number do |n|
      n
    end

    application
  end

  factory :message do
    sequence :number do |n|
      n
    end
    body { Faker::Lorem.sentence }
    chat
  end
end
