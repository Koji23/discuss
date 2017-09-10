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

  def create(conn, %{"topic" => topic}) do
    changeset = Topic.changeset(%Topic{}, topic)

    case Repo.insert(changeset) do
      {:ok, _topic} ->
        conn
          |> put_flash(:info, "Topic Created")
          |> redirect(to: topic_path(conn, :index))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  # note when using external data we use string keyed maps instead of atom keyed maps
  # https://engineering.appcues.com/2016/02/02/too-many-dicts.html

  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get(Topic, topic_id) # Repo.get takes as args the type that we want to pull from the db (in this case the Topic model, and the id of the record)
    changeset = Topic.changeset(topic) # we can skip the 2nd arg to changeset since we gave it a default params arguments

    # the form helpers inside edit.html rely on having a changeset
    render conn, "edit.html", changeset: changeset, topic: topic
  end

  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    old_topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(old_topic, topic)

    # https://hexdocs.pm/ecto/Ecto.Repo.html
    case Repo.update(changeset) do
      {:ok, _topic} ->
          conn
            |> put_flash(:info, "Topic Updated")
            |> redirect(to: topic_path(conn, :index))
      {:error, changeset} ->
          render conn,"edit.html", changeset: changeset, topic: old_topic
    end
  end

  def delete(conn, %{"id" => topic_id}) do
    Repo.get!(Topic, topic_id) |> Repo.delete! # using bang ! here means if you try to get a topic that doesn't exist, return a 4** error status
    # no case statement is needed here to handle errors since the bang function will already handle errors for us
    conn
      |> put_flash(:info, "Topic Deleted")
      |> redirect(to: topic_path(conn, :index))
  end
end
