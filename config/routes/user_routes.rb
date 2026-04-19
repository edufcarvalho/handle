module UserRoutes
  def self.extended(router)
    router.instance_exec do
      get  "sign_in", to: "sessions#new"
      get  "sign_up", to: "registrations#new"
      post "sign_up", to: "registrations#create"

      resources :sessions, only: [:index, :show, :destroy]
      resource  :password, only: [:edit, :update]

      get  "sign_in", to: "sessions#new", as: :sign_in
      post "sign_in", to: "sessions#create"
      get  "sign_up", to: "users#new", as: :sign_up
      post "sign_up", to: "users#create"

      resources :sessions, only: [:destroy]
      resource :users, only: [:destroy]

      namespace :identity do
        resource :email,              only: [:edit, :update]
        resource :email_verification, only: [:show, :create]
        resource :password_reset,     only: [:new, :edit, :create, :update]
      end

      namespace :settings do
        resource :profile, only: [:show, :update]
        resource :password, only: [:show, :update]
        resource :email, only: [:show, :update]
        resources :sessions, only: [:index]
        inertia :appearance
      end
    end
  end
end
