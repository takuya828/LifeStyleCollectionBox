Rails.application.routes.draw do
  devise_for :users
get '/' => 'homes#top', as: 'root'
get '/about' => 'homes#about', as:'about'

end
