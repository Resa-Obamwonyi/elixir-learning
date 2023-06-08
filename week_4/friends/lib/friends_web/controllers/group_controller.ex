defmodule FriendsWeb.GroupController do
  use FriendsWeb, :controller

  alias Friends.Collection
  alias Friends.Collection.Group

  def index(conn, params) do
    groups = Collection.list_groups(params)
    render(conn, :index, groups: groups)
  end

  def new(conn, _params) do
    changeset = Collection.change_group(%Group{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"group" => group_params}) do
    IO.inspect(group_params)

    case Collection.create_group(group_params) do
      {:ok, group} ->
        conn
        |> put_flash(:info, "Group created successfully.")
        |> redirect(to: ~p"/groups/#{group}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    group = Collection.get_group!(id)
    render(conn, :show, group: group)
  end

  def edit(conn, %{"id" => id}) do
    # get group
    group = Collection.get_group!(id)
    # validate
    changeset = Collection.change_group(group)
    # render edit page template
    render(conn, :edit, group: group, changeset: changeset)
  end

  def update(conn, %{"id" => id, "group" => group_params}) do
    IO.inspect(group_params)

    # get group
    group = Collection.get_group!(id)

    case Collection.update_group(group, group_params) do
      {:ok, group} ->
        conn
        |> put_flash(:info, "Group updated successfully")
        |> redirect(to: ~p"/groups/#{group}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    group = Collection.get_group!(id)
    {:ok, _group} = Collection.delete_group(group)

    conn
    |> put_flash(:info, "Group deleted successfully.")
    |> redirect(to: ~p"/groups")
  end

  # Implement search by name, rank and status
  def search(conn, params) do
    IO.inspect(params, label: "PARAMS \n")
      results = Collection.search(params)
      render(conn, :index, groups: results)
  end
end
