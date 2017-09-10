# By convention controllers are named after their resource in singular form
defmodule Discuss.TopicController do
  use Discuss.Web, :controller

  alias Discuss.Topic # now use Topic instead of Discuss.Topic

  def index(conn, _params) do
    topics = Repo.all(Topic)
    # traditionally index.html is meant to show a list of all the resources under /topics
    render conn, "index.html", topics: topics
  end

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})
    render conn, "new.html", changeset: changeset
  end

  # args: conn, params
  def create(conn, %{"topic" => topic}) do
    changeset = Topic.changeset(%Topic{}, topic)

    case Repo.insert(changeset) do
      {:ok, post} ->
        conn
          |> put_flash(:info, "Topic Created")
          |> redirect(to: topic_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end
end
