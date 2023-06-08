defmodule FriendsWeb.Inputs.GroupFilter do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field(:search, :string)
    field(:rank, Ecto.Enum, values: [:high, :middle, :low])
    field(:page, :integer, default: 1)
    field(:sort, Ecto.Enum, values: [:id, :group_name, :rank])
  end

  def changeset(nil) do
    changeset(%{})
  end

  def changeset(params) do
    changeset =
      %__MODULE__{}
      |> cast(params, [:search, :rank, :page, :sort])
      |> validate_number(:page, greater_than: 0)

    {changeset, apply_changes(changeset)}
  end
end
