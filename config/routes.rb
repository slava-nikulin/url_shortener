require "sidekiq/web"

Rails.application.routes.draw do
  root "url_pairs#new"
  resources :url_pairs, only: %i(new create index)
  get "/*short_path",
      to: "redirect#perform",
      constraints: lambda { |req| req.path !~ /(url_pairs)$/ },
      as: "redirect"

  namespace :api do
    namespace :v1 do
      resources :url_pairs, only: %i(create), defaults: { format: :json }
    end
  end
end
