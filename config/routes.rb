EvernoteRecipes::Application.routes.draw do
  root to: "recipes#index"

  namespace :sessions do
    # The route to create should be a post but Evernote sends as a normal get request
    get :create
    get :new
    delete :destroy
  end

  namespace :recipes do
    get :index
    get '/:id' => :show, :constraints => {id: /\d+/}
  end
end
