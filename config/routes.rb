Officegame::Application.routes.draw do
    root to: "users#index"
    resources :users do
        collection { get "search" }
    end
    resources :boards
    post 'boards/:id/pass', to: 'boards#pass'
end
