Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/ping", to:"application#ping"

  namespace :v1 do

    resources :reservation, only: [:create] do
    end
  end

end
