Rails.application.routes.draw do
  resources :students, only: [] do
    member do
      get :schedule
      post :enroll, to: "enrollments#create"
      delete :drop, to: "enrollments#destroy"
    end
  end
end
