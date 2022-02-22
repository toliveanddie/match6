Rails.application.routes.draw do
  root 'welcome#index'

  get '/powerball', to: 'welcome#powerball'
  get '/pick4', to: 'welcome#pick4'
  get '/pick5', to: 'welcome#pick5'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end