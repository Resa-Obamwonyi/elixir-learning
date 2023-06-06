defmodule Friends.Collection do
  import Ecto.Query, warn: false
  alias Friends.Repo

  alias Friends.Collection.Group

  # get all groups
  def list_groups() do
    Repo.all(Group)
  end

  # get group by id
  def get_group!(id), do: Repo.get!(Group, id)


  # create a group
  def create_group(attrs \\ %{}) do
    %Group{}
    |> Group.changeset(attrs)
    |> Repo.insert()
  end

  def change_group(%Group{} = group, attrs \\ %{}) do
    Group.changeset(group, attrs)
  end

  def update_group(%Group{} = group, attrs) do
    group
    |> Group.changeset(attrs)
    |> Repo.update()
  end

  def delete_group(%Group{} = group) do
    Repo.delete(group)
  end

end
