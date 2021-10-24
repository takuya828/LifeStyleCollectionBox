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
get '/about' => 'homes#about', as: 'about'

resources :contacts, only: [:new, :create]
post 'contacts/confirm', to: 'contacts#confirm', as: 'confirm'
post 'contacts/back', to: 'contacts#back', as: 'back'
get 'done', to: 'contacts#done', as: 'done'

resources :posts, only: [:new, :show, :create, :index, :destroy] do
  resources :post_comments, only:[:create, :destroy]
  resources :favorites, only: [:create, :destroy]
end
resources :users, only: [:show, :edit, :update]
get '/users/mypage', to: 'users#show'
namespace :admin do
     resources :users
  end

end
