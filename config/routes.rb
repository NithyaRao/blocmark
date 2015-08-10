Rails.application.routes.draw do
  get 'topics/index'

  get 'topics/show'

  get 'topics/new'

  get 'topics/edit'

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
