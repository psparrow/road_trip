RoadTrip::Application.routes.draw do

  devise_for :users, path: ""

  resources :itineraries do
    resources :stops
  end

  root to: "home#index"

end
