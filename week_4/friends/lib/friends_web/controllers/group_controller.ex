defmodule FriendsWeb.GroupController do
  use FriendsWeb, :controller

  alias Friends.Collection
  alias Friends.Collection.Group

  def index(conn, _params) do
    groups = Collection.list_groups()
    render(conn, :index, groups: groups)
  end

  def new(conn, _params) do
    changeset = Collection.change_group(%Group{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"group" => group_params}) do
    case Collection.create_group(group_params) do
      {:ok, group} ->
        conn
        |> put_flash(:info, "Group created successfully.")
        |> redirect(to: ~p"/groups/#{group}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end
end
