defmodule Discuss.Router do
  use Discuss.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Discuss.Plugs.SetUser # function plugs are referenced as atoms, module plugs look like this
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Discuss do
    pipe_through :browser # Use the default browser stack

    get "/", TopicController, :index
    get "/topics/new", TopicController, :new
    post "/topics", TopicController, :create
    get "/topics/:id/edit", TopicController, :edit
    put "/topics/:id", TopicController, :update
    delete "/topics/:id", TopicController, :delete
    # alternativley you can use the resources helper which achieves the above ^ routes
    # note: the resources helper assumes that your wildcard matcher will always be ":id"

    # resources "/topics", TopicController
  end

  scope "/auth", Discuss do
    pipe_through :browser

    get "/:provider", AuthController, :request # request here was defined by ueberauth, not us.
    get "/:provider/callback", AuthController, :callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", Discuss do
  #   pipe_through :api
  # end
end


# running `mix phoenix.routes` in the cli will display this info above
