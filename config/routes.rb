Rails.application.routes.draw do
  resources :items
  resources :inventories
  get '/choose/inventory', to: 'inventories#choose_inventory', as: 'choose_inventory'
  get '/room/inventory/:id', to: 'inventories#room', as: 'room'

  root 'statics#home'
  get '/404', to: 'statics#not_found', as: 'not_found'
  get '/500', to: 'statics#server_error', as: 'server_error'

  #devise_for :users
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  scope '/manager' do
    resources :users, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  end

  get '/check/items/inventory/:id', to: 'items#check', as: 'check'
  get '/export/inventory/:id', to: 'inventories#export', as: 'export'
  get '/export_divergent/inventory/:id', to: 'inventories#export_divergent', as: 'export_divergent'
  get '/list/items/room/inventory/:id', to: 'items#items_room_list', as: 'items_room_list'
  get '/history/inventory/:id', to: 'inventories#history', as: 'history'
  get '/undo/:id', to: 'items#undo', as: 'undo'
end
