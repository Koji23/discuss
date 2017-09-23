defmodule Discuss.Plugs.SetUser do
  import Plug.Conn
  import Phoenix.Controller

  alias Discuss.Repo
  alias Discuss.User

  def init(_params) do
  end

  # _params in this case is actually the return value of init (NOT the same params given to controller functions)
  def call(conn, _params) do
    user_id = get_session(conn, :user_id) # get_session comes from Phoenix.Controller

    cond do
      user = user_id && Repo.get(User, user_id) ->
        assign(conn, :user, user) # now this works: conn.assigns.user => user struct. Also assign comes from Plug.Conn
        # note that the funcion to modify the conn's bucket of data is called 'assign' and the bucket itself is called conn.assigns
      true ->
        assign(conn, :user, nil) # note that the cond statement is doing an implicit return and the assign function returns a conn
    end
  end
end
