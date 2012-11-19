RoadTrip::Application.routes.draw do

  devise_for :users, path: ""

  resources :itineraries do
    shallow do
      resources :stops
      resources :invitations
    end
  end

  match "/join/:guid" => "invitations#join_via_guid"
  match "/invitations/accept" => "invitations#accept"
  root to: "home#index"
end
