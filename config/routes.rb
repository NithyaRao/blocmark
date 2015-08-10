Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show] 
  resources :topics do
      resources :bookmarks
   end
  get 'welcome/index'
  get 'about' =>'welcome#about'
  post :incoming, to: 'incoming#create'
  root to: 'welcome#index'
end
