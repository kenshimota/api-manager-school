Rails.application.routes.draw do
  scope :api, :defaults => { :format => "json" } do
    resources :students
    devise_for :users, { controllers: { sessions: "users/sessions" } }
  end
end
