RoadTrip::Application.routes.draw do

  devise_for :users, path: ""

  resources :itineraries

  root to: "home#index"

end
