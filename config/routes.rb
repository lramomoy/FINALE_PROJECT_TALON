Rails.application.routes.draw do
  devise_for :administrators, controllers: {
    sessions: 'administrators/sessions',
    passwords: 'administrators/passwords'

  }

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  get '/admin/reports/bookings', to: 'admin/reports#new_booking_report'
  namespace :admin do
      resources :administrators
      resources :customers
      resources :galleries
      resources :services
      resources :bookings
      resources :feedbacks, only: [:index, :show, :destroy]
      root to: "administrators#index"
    end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/home', to: 'dashboards#index', as: :home
  get '/services', to: 'dashboards#services', as: :services
  get '/gallery', to: 'dashboards#gallery', as: :gallery
  
  get '/booking', to: 'bookings#new', as: :new_booking
  get '/booking/available-slots', to: 'bookings#get_available_slots', as: :get_available_slots_for_booking
  post '/booking', to: 'bookings#create', as: :create_booking
  get '/booking/:id/status', to: 'bookings#status', as: :booking_status

  get '/feedbacks/new', to: 'feedbacks#new', as: :new_feedback
  post '/feedbacks', to: 'feedbacks#create', as: :create_feedback

  root 'dashboards#index'
end
