Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post "txt", to: 'txt#set'
  delete 'txt', to: 'txt#destroy'
  resources :domains
  root to: 'application#empty'
end
