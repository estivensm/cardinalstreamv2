Rails.application.routes.draw do
 

  get 'viewer_sessions/new'

  get 'login', to: 'viewer_sessions#new'
  post 'login', to: 'viewers_sessions#create'
  delete 'logout/:event_id', to: 'viewer_sessions#destroy', as: "logout"
  
  resources :viewers
  post 'create_viewer', to: "viewers#create_viewer", as: "create_viewer"
  get 'events/cardinalppt/:id' ,to: "events#cardinalppt", as: "cardinalppt"
  resources :events , :only => [:index, :show, :create, :update, :edit, :destroy]
  get 'new/:state' , to: "events#new" , as: "new_event"
  get 'home', to: 'home#index', as: "home"
  resources :accounts
  devise_for :users, controllers: { registrations: "registrations" }

  #match '/', to: 'accounts#index', constraints: { subdomain: 'www' }, via: [:get, :post, :put, :patch, :delete]
  #match '/', to: 'accounts#show', constraints: { subdomain: /.+/ }, via: [:get, :post, :put, :patch, :delete]
  match '/', to: 'accounts#live', constraints: { subdomain: /.+/ }, via: [:get]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get 'portal', to:"accounts#portal", as: "portal"
  get 'portal_show/:id', to:"accounts#portal_show", as: "portal_show"
  get 'show_video/:id', to:"accounts#portal_show_video", as: "portal_show_video"
  get  'admin' , to: "events#index"
  get  'ppts/views/:id' , to: "events#ppts_views" , as: "ppts_views"
  post   'sinc_ppts', to: "events#sinc_ppts", as: "sinc_ppts"
  get 'admin', to: 'events#admin', as: "admin_events"
  root 'events#index'
  get 'redir', to: 'home#redir', as: 'redir'
  post 'create_question', to: 'questions#create_question', as: 'create_question'
  get 'iframe/:iframe', to:"accounts#iframe", as: "iframe"
end


