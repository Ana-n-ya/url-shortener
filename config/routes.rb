Rails.application.routes.draw do
  resources :urls, only: [:create, :index]
  get '/:short_code', to: 'urls#redirect'
  root 'urls#create'
end
