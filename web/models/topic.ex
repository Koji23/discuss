defmodule Discuss.Topic do
  use Discuss.Web, :model # `use` also creates a Discuss.Topic struct by default

  # tell phoenix what exists in the db
  schema "topics" do
    field :title, :string
  end

  # two backslashes signify default arguments
  # by convention we call the function that creates a changeset, changeset
  # the struct represents either a record from the db or about to go into the db
  def changeset(struct, params \\ %{}) do
    struct
      |> cast(params, [:title]) # cast creates a changeset
      |> validate_required([:title])
  end
end
