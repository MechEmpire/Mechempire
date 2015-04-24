Rails.application.routes.draw do

  root 'home#index'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :meches
  resources :carriers
  resources :weapons
  resources :battles
  resources :matches

  match '/signup',  to: 'users#new', via: 'get'
  match '/signin',  to: 'sessions#new', via: 'get'
  match '/signout',  to: 'sessions#destory', via: 'delete'
  match '/active', to: 'users#active', via: 'get'
  match '/about', to: 'home#about', via: 'get'
  match '/aboutus', to:'home#aboutus',via: 'get'
  match '/join', to: 'home#join', via: 'get'
  match '/achieve', to: 'home#achieve', via: 'get'
  match '/mechlist', to: 'meches#mech_list', via: 'get'
  match '/reactive', to: 'users#re_active',via: 'get'
  match '/gamebg',to: 'home#gamebg', via: 'get'
  match '/newer',to: 'home#newer', via: 'get'
  match '/download',to: 'home#download', via: 'get'

  match '/users/followed/:id', to: 'users#followed', via: 'get', as: :followed
  match '/users/follower/:id', to: 'users#follower', via: 'get', as: :follower

  match '/meches/stop/:id', to: 'users#stop', via: 'post', as: :stop_mech
  match '/meches/start/:id', to: 'users#start', via: 'post', as: :start_mech

  match '/following/:followed_id', to: 'users#following',via: 'post', as: :follow_user
  match '/unfollowing/:unfollowed_id', to: 'users#unfollowing', via: 'post', as: :unfollow_user

  match '/matches/apply/:id', to: 'matches#apply', via: 'post'
  match '/matches/addmech/:id/:mech_id', to: 'matches#addmech', via: 'post'
  match '/matches/result/:id', to: 'matches#result', via: 'get', as: :match_result
  match '/matches/video/:id', to: 'matches#video', via: 'get', as: :match_rvideo
  match '/matches/genracecard/:id', to: 'matches#gen_racecard', via: 'post', as: :gen_match_racecard
  match '/matches/racecard/:id', to: 'matches#racecard', via: 'get', as: :match_racecard

  match '/battles/download/:id', to: 'battles#download', via: 'get', as: :download_video
  match '/battles/star/:id', to: 'battles#star', via: 'post', as: :star_battle
  match '/battle/:defender_id/:attacker_id', to: 'battles#create', via: 'post'

  match '/vedio/:id', to: 'home#vedio', via: 'get'
  match '/wondervedio/:id', to: 'home#wondervedio', via: 'get', as: :wonder_vedio
  match '/highlights', to: 'home#wonderful',via: 'get'
end