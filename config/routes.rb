Rails.application.routes.draw do
  resources :enrollments, only: [ :create, :destroy ]
  get "students/:id/schedule", to: "students#schedule", as: :student_schedule
end
