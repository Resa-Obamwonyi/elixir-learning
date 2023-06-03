defmodule Friends.Person do
  use Ecto.Schema
  import Ecto.Changeset

  schema "people" do
    field(:first_name, :string)
    field(:last_name, :string)
    field(:age, :integer)
    belongs_to(:group, Friends.Group)
  end

  # TO-DO: use embedded schema to add address to group and friend tables


  def changeset(person, params \\ %{}) do
    person
    |> cast(params, [:first_name, :last_name, :age])
    |> validate_required([:first_name, :last_name])
    |> validate_length(:first_name, min: 2)
    |> validate_length(:last_name, min: 3)
    |> validate_inclusion(:age, 16..100)
  end
end
