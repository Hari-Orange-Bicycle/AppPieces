Rails.application.routes.draw do
  resources :projects do
    resources :cards do
      collection do

      end
    end
  end
  get '/:token' => 'projects#public_share', :constraints => { subdomain: /share/ }, as: :project_public_share
  get '/:token/card' => 'cards#public_share', :constraints => { subdomain: /share/ }, as: :card_public_share
  get 'projects/tags/:tag', to: 'projects#index', as: :tag
  get 'projects/:project_id/cards/tags/:tag', to: 'projects#show', as: :card_tag
  # match '/:projects(/:public_share_token)', to: 'projects#show', via: [:get]
  root to: 'projects#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
