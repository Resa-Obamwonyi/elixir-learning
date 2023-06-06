defmodule FriendsWeb.FriendController do
  use FriendsWeb, :controller

  alias Friends.People
  alias Friends.People.Person

  def index(conn, _params) do
    persons = People.list_friends()
    render(conn, :index, persons: persons)
  end

  def new(conn, _params) do
    changeset = People.change_friend(%Person{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"person" => person_params}) do
    IO.inspect(person_params)

    case People.create_friend(person_params) do
      {:ok, person} ->
        conn
        |> put_flash(:info, "Person created successfully.")
        |> redirect(to: ~p"/friends/#{person}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    person = People.get_friend!(id)
    render(conn, :show, person: person)
  end

  def edit(conn, %{"id" => id}) do
    # get person
    person = People.get_friend!(id)
    # validate
    changeset = People.change_friend(person)
    # render edit page template
    render(conn, :edit, person: person, changeset: changeset)
  end

  def update(conn, %{"id" => id, "person" => person_params}) do
    IO.inspect(person_params)

    # get person
    person = People.get_friend!(id)

    case People.update_friend(person, person_params) do
      {:ok, person} ->
        conn
        |> put_flash(:info, "Person updated successfully")
        |> redirect(to: ~p"/friends/#{person}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    person = People.get_friend!(id)
    {:ok, _person} = People.delete_friend(person)

    conn
    |> put_flash(:info, "Person deleted successfully.")
    |> redirect(to: ~p"/friends")
  end
end
