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

resources :posts do
  collection do
  get '/ranking' => 'posts#ranking', as: 'ranking'
  get '/search' => 'posts#search'
  get '/rank' => 'posts#rank'
  end
  resources :post_comments, only:[:create, :destroy]
  resource :favorites, only: [:create, :destroy]
 end

resources :users do
  member do
    get :favorites
  end
end

get '/users/mypage', to: 'users#show'
namespace :admin do
     resources :users
     resources :categories
     resources :posts do
       resources :post_comments, only:[ :destroy]
     end
  end

end