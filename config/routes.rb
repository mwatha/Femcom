Comesa::Application.routes.draw do

  get "user/services_edit"
  post "user/services_edit"

  get "user/services_list"
  post "user/services_list"

  get "user/services_create"
  post "user/services_create"

  get "user/upload"
  post "user/upload"

  get "user/ajax_upload"
  post "user/ajax_upload"

  get "user/current_focus_and_activities_list"

  get "user/current_focus_and_activities"
  post "user/current_focus_and_activities"

  get "user/change_home_page_photos"
  post "user/change_home_page_photos"

  get "user/edit_home_page_content"
  post "user/edit_home_page_content"

  get "user/create_home_page_content"
  post "user/create_home_page_content"

  get "user/home_page"
  post "user/home_page"

  get "femcom/event"

  get "user/edit_password"
  post "user/edit_password"

  get "user/event_edit"

  get "user/edit_files"

  get "user/news_edit"
  post "user/edit_news"

  get "user/edit_news"
  get "user/delete_post"
  post "user/delete_post"

  get "femcom/album"

  get "user/upload_new_pictures"
  post "user/upload_new_pictures"

  get "femcom/gallery"

  get "femcom/contact_us"

  get "femcom/about_us"

  get "femcom/services"

  get "femcom/documents"
  get "femcom/download"

  get "femcom/get_pictures"

  get "femcom/directors"

  get "news/post"

  get "femcom/news"

  get "femcom/national_chapters"

  get "femcom/events"

  get "user/upload_pictures"
  post "user/upload_pictures"

  get "user/create_events"
  post "user/create_events"

  get "media/videos"

  get "user/create_video_link"
  post "user/create_video_link"

  get "user/upload_pdf"
  post "user/upload_pdf"

  get "user/create_news"
  post "user/create_news"

  get "user/blank"

  get "user/admin"

  get "user/login"
  get "user/logout"
  get "user/number_of_events"
  post "user/login"

  get "home/index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
  root :to => "home#index"
end
