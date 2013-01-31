RoadTrip::Application.routes.draw do

  devise_for :users, path: ""

  resources :itineraries do
    shallow do
      resources :stops
      resources :contributors
    end
  end

  root to: "home#index"

end
