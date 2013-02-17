RoadTrip::Application.routes.draw do

  devise_for :users, path: ""

  resources :itineraries do
    shallow do
      resources :stops
      resources :contributors
    end
  end

  match "/reorder_stop/:id/:type" => "reorder_stops#update",
    :via => :put,
    :as  => "reorder_stop"

  root to: "home#index"

end
