# https://hexdocs.pm/ecto/Ecto.Migration.html#content

defmodule Discuss.Repo.Migrations.AddTopics do
  use Ecto.Migration

  def change do
    create table(:topics) do
      add :title, :string
    end
  end
end
