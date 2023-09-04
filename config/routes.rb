Rails.application.routes.draw do
  scope :api, :defaults => { :format => "json" } do
    resources :students
    resources :subjects
    resources :sections
    devise_for :users, { controllers: { sessions: "users/sessions" } }
  end
end
