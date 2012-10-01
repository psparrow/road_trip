RoadTrip::Application.routes.draw do

  devise_for :users, path: ""

  root to: "home#index"

end
