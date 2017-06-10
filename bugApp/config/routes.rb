Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :bugs do
    collection do
      get :search, action: 'search', as: 'search'
    end
  end
end
