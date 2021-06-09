Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'lists#index'
  resources :lists, only: [:index, :show, :new, :create] do
    resources :bookmarks, only: [:new, :create]
  end
  resources :bookmarks, only: :destroy
  get 'lists/:id/togglefilms', to: 'lists#toggle_films', as: :toggle
  patch 'lists/:list_id/togglefilms/:film_id', to: 'bookmarks#toggle', as: :toggle_update
end
