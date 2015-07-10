# == Route Map
#
#                   Prefix Verb   URI Pattern                       Controller#Action
#                     root GET    /                                 pages#home
#                     home GET    /home(.:format)                   pages#home
#                   inside GET    /inside(.:format)                 pages#inside
#         new_user_session GET    /users/sign_in(.:format)          devise/sessions#new
#             user_session POST   /users/sign_in(.:format)          devise/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)         devise/sessions#destroy
#            user_password POST   /users/password(.:format)         devise/passwords#create
#        new_user_password GET    /users/password/new(.:format)     devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format)    devise/passwords#edit
#                          PATCH  /users/password(.:format)         devise/passwords#update
#                          PUT    /users/password(.:format)         devise/passwords#update
# cancel_user_registration GET    /users/cancel(.:format)           devise/registrations#cancel
#        user_registration POST   /users(.:format)                  devise/registrations#create
#    new_user_registration GET    /users/sign_up(.:format)          devise/registrations#new
#   edit_user_registration GET    /users/edit(.:format)             devise/registrations#edit
#                          PATCH  /users(.:format)                  devise/registrations#update
#                          PUT    /users(.:format)                  devise/registrations#update
#                          DELETE /users(.:format)                  devise/registrations#destroy
#        user_confirmation POST   /users/confirmation(.:format)     devise/confirmations#create
#    new_user_confirmation GET    /users/confirmation/new(.:format) devise/confirmations#new
#                          GET    /users/confirmation(.:format)     devise/confirmations#show
#               admin_root GET    /admin(.:format)                  admin/base#index
#              admin_users GET    /admin/users(.:format)            admin/users#index
#                          POST   /admin/users(.:format)            admin/users#create
#           new_admin_user GET    /admin/users/new(.:format)        admin/users#new
#          edit_admin_user GET    /admin/users/:id/edit(.:format)   admin/users#edit
#               admin_user GET    /admin/users/:id(.:format)        admin/users#show
#                          PATCH  /admin/users/:id(.:format)        admin/users#update
#                          PUT    /admin/users/:id(.:format)        admin/users#update
#                          DELETE /admin/users/:id(.:format)        admin/users#destroy
#

Ttdx3::Application.routes.draw do
  get 'tags/:tag', to: 'things#index', as: :tag
  resources :things
  

  
  root "pages#home"
  get "home", to: "pages#home", as: "home"
  get "inside", to: "pages#inside", as: "inside"
  
  get "current_user_things", to: "things#current_user_index", as: "current_user_things"
  
  
  devise_for :users

  namespace :admin do
    root "base#index"
    resources :users
    
  end

end
