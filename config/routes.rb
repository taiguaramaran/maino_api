Rails.application.routes.draw do
  if defined?(Rswag)
    mount Rswag::Ui::Engine => '/api-docs'
    mount Rswag::Api::Engine => '/api-docs'
  end

  resources :articles
  root to: "articles#home"

end
