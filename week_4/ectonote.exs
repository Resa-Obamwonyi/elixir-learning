# create a new project with supervision tree
mix new friends --sup

# add ecto and postgres driver to dependencies list
defp deps do
  [
    {:ecto_sql, "~> 3.0"},
    {:postgrex, ">= 0.0.0"} # this is what Ecto uses to speak in terms a PostgreSQL database can understand.
  ]
end

# To install these dependencies, we will run this command:
mix deps.get

# setup the repo config
mix ecto.gen.repo -r Friends.Repo


# To be able to query a database, it first needs to exist. We can create the database with this command:
mix ecto.create

If the database has been created successfully, then you will see this message:

# create a migration with this command:
mix ecto.gen.migration create_people
This command will generate a brand new migration file in priv/repo/migrations, which is empty by default

# add some code to this migration to create a new table called "people", with a few columns in it:

defmodule Friends.Repo.Migrations.CreatePeople do
  use Ecto.Migration

  def change do
    create table(:people) do
      add :first_name, :string
      add :last_name, :string
      add :age, :integer
    end
  end
end
This new code will tell Ecto to create a new table called people, and add three new fields:
first_name, last_name and age to that table.
The types of these fields are string and integer.

# NOTE: The naming convention for tables in Ecto databases is to use a pluralized name.

# To run migration and create the people table in our database, we will run this command:
mix ecto.migrate

we could run mix ecto.rollback to undo the changes in the migration.
We could then fix the changes in the migration and run mix ecto.migrate again.


# Creating the schema
The schema is an Elixir representation of data from our database.
Schemas are commonly associated with a database table, however they can be associated with a database view as well.

defmodule Friends.Person do
  use Ecto.Schema

  schema "people" do
    field :first_name, :string
    field :last_name, :string
    field :age, :integer
  end
end


# Inserting data
We can insert a new record into our people table with this code:
person = %Friends.Person{}
Friends.Repo.insert(person)


# Validating changes
In Ecto, you may wish to validate changes before they go to the database.
For this, Ecto has changesets.

def changeset(person, params \\ %{}) do
  person
  |> Ecto.Changeset.cast(params, [:first_name, :last_name, :age])
  |> Ecto.Changeset.validate_required([:first_name, :last_name])
end

person = %Friends.Person{}
changeset = Friends.Person.changeset(person, %{})
Friends.Repo.insert(changeset)

changeset.valid? #=> true
changeset.errors #=> []

# Note: you can trigger an exception to be thrown by using Friends.Repo.insert!/2.

# Querying a db in ecto
Querying a database requires two steps in Ecto.
First, we must construct the query and then we must execute that query against the database by passing the query to the repository.

# Fetching a single record
Friends.Person |> Ecto.Query.first
That code will generate an Ecto.Query, which will be this: => # Ecto.Query<from p0 in Friends.Person, order_by: [asc: p0.id], limit: 1>
The code between the angle brackets <...> here shows the Ecto query which has been constructed.
# We could construct this query ourselves with almost exactly the same syntax:
require Ecto.Query
Ecto.Query.from p in Friends.Person, order_by: [asc: p.id], limit: 1

# to execute the query above
Friends.Person |> Ecto.Query.first |> Friends.Repo.one

# The one function retrieves just one record from our database and returns a new struct from the Friends.Person module:
# If there is no record which matches a query, one will return nil.

# Fetching all records
# To fetch all records from the schema, Ecto provides the all function:
Friends.Person |> Friends.Repo.all
This will return a Friends.Person struct representation of all the records that currently exist within our people table:

# Fetch a single record based on a specific attribute
# If we want to get a record based on something other than the id attribute, we can use get_by
Friends.Person |> Friends.Repo.get_by(first_name: "Ryan")

# If we want to get multiple records matching a specific attribute, we can use where
Friends.Person |> Ecto.Query.where(last_name: "Smith") |> Friends.Repo.all

# One important thing to note with both query syntaxes is that they require variables to be pinned, using the pin operator (^).
last_name = "Smith" # using a variable
Friends.Person |> Ecto.Query.where(last_name: ^last_name) |> Friends.Repo.all # variable must be pinned ^

# Updating Records
This requires us to first fetch a record from the database.
We then create a changeset from that record and the changes we want to make to that record, and then call the Ecto.Repo.update function.

# fetch
person = Friends.Person |> Ecto.Query.first |> Friends.Repo.one

# create a changeset
changeset = Friends.Person.changeset(person, %{age: 29})

# update record
Friends.Repo.update(changeset) # this will return a tuple with the updated record

# alternatively, use a case to handle different outcomes
case Friends.Repo.update(changeset) do
  {:ok, person} ->
    # do something with person
  {:error, changeset} ->
    # do something with changeset
end

# Deleting Records
Similar to updating, we must first fetch a record from the database and then call Friends.Repo.delete to delete that record
# delete a record, and returns a tuple with the first value being :ok or :error depending on the results
person = Friends.Repo.get(Friends.Person, 1)
Friends.Repo.delete(person)
