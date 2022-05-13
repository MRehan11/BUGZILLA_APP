Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :projects do
    resources :bugs do
      get 'assign_user'
    end
  end
  resources :projects do
    get 'assigned_users'
  end
  root to: 'welcome#index'
  #root to: 'projects#index'
end