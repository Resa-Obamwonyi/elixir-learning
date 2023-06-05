defmodule Friends.Collection.Group do
  use Ecto.Schema
  import Ecto.Changeset

  # a group has many friends and a friend belongs to a group
  schema "groups" do
    field :group_name, :string
    field :group_rank, Ecto.Enum, values: [:high, :middle, :low]
    field :is_rich_group, :boolean
    has_many :people, Friends.Person

    embeds_one :address, Address do
      field :street_name, :string
      field :street_number, :integer
      field :city, :string
      field :country, :string
    end
  end

  # create changeset to validate length of group name
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:group_name, :group_rank, :is_rich_group])
    |> validate_required([:group_name, :group_rank, :is_rich_group])
    |> validate_length(:group_name, min: 5)
  end

end
