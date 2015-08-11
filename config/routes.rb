Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show] 
  resources :topics do
      resources :bookmarks, except: [:index]
   end 
   resources :bookmarks, except: [:index,:show,:edit,:update,:destroy,:create,:new] do
      resources :likes, only: [:create, :destroy]
   end
   
  get 'welcome/index'
  get 'about' =>'welcome#about'
  get 'myblocmarks' => 'topics#index'
  post :incoming, to: 'incoming#create'
  root to: 'welcome#index'
end
