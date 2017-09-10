# By convention controllers are named after their resource in singular form
defmodule Discuss.TopicController do
  use Discuss.Web, :controller

  alias Discuss.Topic # now use Topic instead of Discuss.Topic

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})
    render conn, "new.html", changeset: changeset
  end

  # args: conn, params
  def create(conn, %{"topic" => topic}) do
    changeset = Topic.changeset(%Topic{}, topic)

    case Repo.insert(changeset) do
      {:ok, post} -> IO.inspect(post)
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end
end
