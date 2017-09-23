defmodule Discuss.Repo.Migrations.AddUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :provider, :string
      add :token, :string

      timestamps()
    end
  end
end

# create this file by doing
# mix ecto.gen.migration add_users
# run this migration by doing
# mix ecto.migrate
