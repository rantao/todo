Todo::Application.routes.draw do

resources :lists
resources :tasks

root to: 'lists#index'


end
