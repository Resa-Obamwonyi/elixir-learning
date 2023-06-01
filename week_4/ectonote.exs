# ABOUT ECTO
Ecto is the official Elixir project providing a database wrapper and integrated query language.
With Ecto we are able to create migrations, define schemas, insert and update records, and query them.

- Ecto is split into 4 components
    - Repo: used to wrap around the datastore and interact with queries
    - Schema: used to map database tables to Structs (like models???), it allows devs determine the shape of their data
    - Query: used to communicate with the repo, to return data or set data in the database
    - Changeset: used to track and validate changes in incoming and outgoing data, Operations on top of schemas are done via changsets so that
                  Ecto can efficiently track changes (kinda like serializers???)

# Summarily
    Ecto.Repo - where the data is, the configuration for this must be in the config.exs file
    Ecto.Schema - what the data is
    Ecto.Query - how to read the data
    Ecto.Changeset - how to change the data: Changesets allow developers to filter, cast, and validate changes
                    before we apply them to the data

- Ecto supports different databases through the use of adapters e.g Ecto.Adapters.Postgres
- Ecto has Migrations which is a mechanism to create, modify, and destroy database tables and indexes


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



# NOTES:
- The naming convention for tables in Ecto databases is to use a pluralized name.
- By defining a schema, Ecto automatically defines a struct with the schema fields:



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



# ECTO CHANGESETS
- Changesets allow filtering, casting, validation and definition of constraints when manipulating structs.
- "Internal data" represents data or logic hardcoded into your Elixir code. "External data" means data that comes from the user via forms,
      APIs, and often need to be normalized, pruned, and validated via Ecto.Changeset

# SOME ECTO CHANGESET VALIDATOR FUNCS
- cast/3, change/2
- validate_length, validate_required
- validate_acceptance/3, validate_change/3 & /4
- validate_confirmation/3, validate_exclusion/4 & validate_inclusion/4
- validate_format/4, validate_number/3
- validate_subset/4

The add_error/4 func used here: add_error(changeset, :name, "is not a superhero") allows us customize and add our own error messages

# ECTO ASSOCIATIONS
# A movie has many characters and a character belongs to a movie
# The has_many/3 macro doesn’t add anything to the database itself. What it does is use the foreign key on the associated schema, characters,
# to make a movie’s associated characters available. This is what will allow us to call movie.characters

- Has Many Association
      defmodule Movie do
        use Ecto.Schema

        schema "movies" do
          field :title, :string
          field :release_date, :date
          has_many :characters, Character
        end
      end


- Belongs To Association
      defmodule Character do
        use Ecto.Schema

        schema "characters" do
          field :name, :string
          field :age, :integer
          belongs_to :movie, Movie
        end
      end


- Has One Association
    defmodule Movie do
      use Ecto.Schema

      schema "movies" do
        field :title, :string
        field :release_date, :date
        has_one :screenplay, Screenplay
      end
    end


- Belongs To Association for Has One
    defmodule Screenplay do
      use Ecto.Schema

      schema "screenplays" do
        field :lead_writer, :string
        belongs_to :movie, Movie
      end
    end


- Many To Many (through a join table)
    defmodule Movie do
      use Ecto.Schema

      schema "movies" do
        field :title, :string
        field :release_date, :date
        many_to_many :actors, Actor, join_through: "movies_actors"
      end
    end

    defmodule Actor do
      use Ecto.Schema

      schema "actors" do
        field :name, :string
        many_to_many :movies, Movie, join_through: "movies_actors"
      end
    end


- Many To Many (through a join schema)
    defmodule User do
      use Ecto.Schema

      schema "users" do
        many_to_many :organizations, Organization, join_through: UserOrganization
      end
    end

    defmodule Organization do
      use Ecto.Schema

      schema "organizations" do
        many_to_many :users, User, join_through: UserOrganization
      end
    end

    defmodule UserOrganization do
      use Ecto.Schema

      @primary_key false
      schema "users_organizations" do
        belongs_to :user, User
        belongs_to :organization, Organization
        timestamps()
      end
    end


- Insert a child record to an existing parent
    # Using internal data
    Repo.get_by!(Movie, title: "The Shawshank Redemption")
    |> Ecto.build_assoc(:characters, name: "Red", age: 60)
    |> Repo.insert()

    # Using external data
    # Params represent data from a form, API, CLI, etc
    params = %{"name" => "Red", "age" => 60}

    Repo.get_by!(Movie, title: "The Shawshank Redemption")
    |> Ecto.build_assoc(:characters)
    |> cast(params, [:name, :age]) # note the use of cast
    |> Repo.insert()


- Inserting parent and child records together
    # Using internal data
    Repo.insert(
      %Movie{
        title: "The Shawshank Redemption",
        release_date: ~D[1994-10-14],
        characters: [
          %Character{name: "Andy Dufresne", age: 50},
          %Character{name: "Red", age: 60}
        ]
      }
    )

    # Using external data
    # Params represent data from a form, API, CLI, etc
    params = %{
      "title" => "Shawshank Redemption",
      "release_date" => "1994-10-14",
      "characters" =>
        [
          %{"name" => "Andy Dufresne", "age" => "50"},
          %{"name" => "Red", "age" => "60"}
        ]
    }

    %Movie{}
    |> cast(params, [:title, :release_date])
    |> cast_assoc(:characters) # note the use of cast_assoc
    |> Repo.insert()
