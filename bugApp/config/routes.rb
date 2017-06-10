require 'api_version'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope module: :v1, constraints: ApiVersion.new(version: 1) do
    resources :bugs do
      collection do
        get :search, action: 'search', as: 'search'
      end
    end
  end
end
