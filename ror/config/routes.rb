Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :applications, except: [:destroy], param: :token do
        resources :chats, only: %i[index show create], param: :number do
          get 'messages/search', to: 'messages#search'
          resources :messages, only: %i[index show create], param: :number
        end
      end
    end
  end
end
