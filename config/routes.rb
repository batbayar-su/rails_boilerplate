Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'sessions',
    omniauth_callbacks: 'sessions'
  }

  root to: 'users#index'

  get     'users'               => 'users#index',        :as => 'users'
  get     'users/:id'           => 'users#show',         :as => 'users_show'
  get     'users/:id/edit'      => 'users#edit',         :as => 'users_edit'
  patch   'users/:id/edit'      => 'users#update',       :as => 'users_update'
  delete  'users/:id'           => 'users#destroy',      :as => 'users_destroy'
  get     'users/google_oauth2'

  get     'roles'               => 'roles#index',        :as => 'roles'
  get     'roles/new'           => 'roles#new',          :as => 'roles_new'
  get     'roles/:id'           => 'roles#show',         :as => 'roles_show'
  post    'roles'               => 'roles#create',       :as => 'roles_create'
  get     'roles/:id/edit'      => 'roles#edit',         :as => 'roles_edit'
  patch   'roles/:id/edit'      => 'roles#update',       :as => 'roles_update'
  delete  'roles/:id'           => 'roles#destroy',      :as => 'roles_destroy'

  get     'maintenance'         => 'cores#maintenance',  :as => 'maintenance'
  post    'maintenance'         => 'cores#maintenance',  :as => 'maintenance_post'
  post    'postaddress'         => 'cores#post_address', :as => 'post_address'

  match '*path', to: 'application#routing_error', via: :all
end
