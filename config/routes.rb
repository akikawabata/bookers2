Rails.application.routes.draw do
devise_for :users
root to: "homes#top"
 get 'homes/new'
 get 'homes/top' #homesにすることでコントローラに遷移してくれる　homeにしてしまうとhomeコントローラーを探してしまうのでhomesにするとrailsがhomesと理解してくれる
 get 'home/about' => 'homes#about'
 # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 resources :books
 resources :users, only: [:show, :edit, :update, :index]
end