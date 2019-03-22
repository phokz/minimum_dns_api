Rails.application.routes.draw do
  post "txt", to: 'txt#set'
  delete 'txt', to: 'txt#destroy'
  resources :domains
  root to: 'application#empty'
end
