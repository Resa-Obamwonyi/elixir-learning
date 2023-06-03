defmodule Friends.Person do
  use Ecto.Schema
  import Ecto.Changeset

  schema "people" do
    field(:first_name, :string)
    field(:last_name, :string)
    field(:age, :integer)
    belongs_to(:group, Friends.Group)

    embeds_one :address, Address do
      field :street_name, :string
      field :street_number, :integer
      field :city, :string
      field :country, :string
    end

  end

  def changeset(person, params \\ %{}) do
    person
    |> cast(params, [:first_name, :last_name, :age])
    |> validate_required([:first_name, :last_name])
    |> validate_length(:first_name, min: 2)
    |> validate_length(:last_name, min: 3)
    |> validate_inclusion(:age, 16..100)
  end
end
