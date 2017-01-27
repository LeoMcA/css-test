PostGenerator::Engine.routes.draw do
  resources :generated_queued_posts, path: ''
  post '/upload' => 'generated_queued_posts#upload'
end
