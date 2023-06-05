defmodule Friends.Collection do
  import Ecto.Query, warn: false
  alias Friends.Repo

  alias Friends.Collection.Group

  # get all groups
  def list_groups do
    Repo.all(Group)
  end

  # create a group
  def create_group(attrs \\ %{}) do
    %Group{}
    |> Group.changeset(attrs)
    |> Repo.insert()
  end

  def change_group(%Group{} = group, attrs \\ %{}) do
    Group.changeset(group, attrs)
  end
end
