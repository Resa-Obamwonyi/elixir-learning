defmodule Friends.Collection do
  import Ecto.Query, warn: false
  alias Friends.Repo

  alias Friends.Collection.Group

  # get all groups
  def list_groups(group_filter) do
    IO.inspect(group_filter)
    # search_term = get_in(group_filter, [:search]) || ""
    # # same to:
    # # search_term = Map.get(group_filter, "search", "")
    # rank_term = get_in(group_filter, [:rank]) || ""

    Group
    |> Group.search(group_filter.search)
    |> Group.rank(group_filter.rank)
    |> Group.sort(group_filter.sort)
    |> Group.pagination(group_filter.page)
    |> Repo.all()
  end

  def count_groups(group_filter) do
    Group
    |> Group.search(group_filter.search)
    |> Group.rank(group_filter.rank)
    |> Repo.aggregate(:count)
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

  def search(params) do
    IO.inspect(params, label: "PARAMS \n")
    search_term = get_in(params, ["search"])

    Group
    |> Group.search(search_term)
    |> Repo.all()
  end
end
