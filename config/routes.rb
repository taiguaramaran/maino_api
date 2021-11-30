Rails.application.routes.draw do
  if defined?(Rswag)
    mount Rswag::Ui::Engine => '/api-docs'
    mount Rswag::Api::Engine => '/api-docs'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :articles
  root to: "articles#home"
end
