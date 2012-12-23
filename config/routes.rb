Agenda::Application.routes.draw do

  resources :events do
    collection do
      get 'view'
      get 'data'
      post 'db_action'
    end
  end

  root :to => 'events#view'
end
