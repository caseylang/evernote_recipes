EvernoteRecipes::Application.routes.draw do
  root to: "recipes#index"
  match '/auth/evernote', as:'signin'
  match '/auth/evernote/callback', controller: :sessions, to: :create
  match '/auth/evernote/failure', controller: :sessions, to: :failure

  namespace :sessions do
    delete :destroy
  end

  namespace :recipes do
    get :index
    get '/:id' => :show, :constraints => {id: /\d+/}
  end
end
