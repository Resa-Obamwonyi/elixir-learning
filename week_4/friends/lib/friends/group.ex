defmodule Friends.Group do
  use Ecto.Schema
  # a group has many friends and a friend belongs to a group
  schema "groups" do
    field :group_name, :string
    field :group_rank, Ecto.Enum, values: [:high, :middle, :low]
    field :is_rich_group, :boolean
    has_many :people, Person
  end


end
