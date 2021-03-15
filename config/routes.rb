Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :word_files,only: [:index,:new] do
    collection do
      get :docx
      post :docx_post, format: 'docx'
    end
  end
  root "word_files#index"
end
