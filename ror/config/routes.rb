Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :applications, except: [:destroy], param: :token
    end
  end
end
