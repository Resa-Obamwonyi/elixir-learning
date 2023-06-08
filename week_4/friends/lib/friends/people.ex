defmodule Friends.People do
  import Ecto.Query, warn: false
  alias Friends.Repo

  alias Friends.People.Person

  # get all friends
  def list_friends do
    Repo.all(Person)
  end

  # get friend by id
  def get_friend!(id), do: Repo.get!(Person, id)

  # create a friend
  def create_friend(attrs \\ %{}) do
    IO.inspect(attrs)
    %Person{}
    |> Person.changeset(attrs)
    |> Repo.insert()
  end

  def change_friend(%Person{} = friend, attrs \\ %{}) do
    Person.changeset(friend, attrs)
  end

  def update_friend(%Person{} = friend, attrs) do
    friend
    |> Person.changeset(attrs)
    |> Repo.update()
  end

  def delete_friend(%Person{} = friend) do
    Repo.delete(friend)
  end

end

#Friends.People.create_friend(%{first_name: "Philipp",last_name: "Waldmann",age: 35,group_id: 99999, address: %{street_name: "Milch",street_number: 10, city: "Vienna", country: "Austria"}})
