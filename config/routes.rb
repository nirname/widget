Rails.application.routes.draw do
  root to: redirect('/integration')
  get 'integration', to: 'application#integration'
  # get 'example', to: 'application#example'
  get 'documentation', to: 'application#documentation'

  get 'api', to: 'api#api', as: :api
  resources :widgets, only: [:index, :show], param: :name
  resources :events

  # get 'api', format: :js, to: redirect { |path_params, req| ActionController::Base.helpers.asset_path("#{'/assets/' if Rails.env.development?}api.js") }

  # get '/scripts/widget', to: 'scripts#widget'
  # match '/widget/:name', to: 'widgets#show', via: [:get, :post]
  # get '/', to: 'widgets#show'
  # get '/widgets', to: 'widgets#index'
end
