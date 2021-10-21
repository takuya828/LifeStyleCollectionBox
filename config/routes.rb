Rails.application.routes.draw do
  devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
}
  devise_for :users, controllers: {
  sessions:      'users/sessions',
  passwords:     'users/passwords',
  registrations: 'users/registrations'
}
get '/users/check', to: 'users#check'
patch '/users/:id/quit' => 'users#quit', as: 'quit'
get '/' => 'homes#top', as: 'root'
get '/about' => 'homes#about', as:'about'
resources :users, only: [:show, :edit, :update]
get '/users/mypage', to: 'users#show'
namespace :admin do
     resources :users
  end

end
