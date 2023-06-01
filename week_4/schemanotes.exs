# An Ecto schema maps external data into Elixir structs.
- schemas are just structs, they are defined to show how the data is meant to be represented/stored in databases
- The definition of the schema is possible through two main APIs: schema/2 and embedded_schema/1.
- schema - contains __meta__ field, used to map data from persisted sources e.g database
- embedded_schema has no __meta__ field, and is used to define schemas embedded in other schemas.

defmodule User do
  use Ecto.Schema

  schema "users" do
    field :name, :string
    field :age, :integer, default: 0
    field :password, :string, redact: true
    has_many :posts, Post
  end
end

- By default, a schema will automatically generate a primary key which is named id and of type :integer
-  has_many associates many posts with the user schema. Schemas are regular structs and can be created and manipulated directly using Elixir struct API

# Ecto supports two ID types, called :id and :binary_id, which are often used as the type for primary keys and associations.
# The :id type is used when the primary key is an integer while the :binary_id is used for primary keys in particular binary formats,
# which may be Ecto.UUID for databases like PostgreSQL and MySQL

if your database does not support autoincrementing primary keys and requires something like UUID or a RecordID,
you can configure and use :binary_id as your primary key type as follows

# Define a module to be used as base
defmodule MyApp.Schema do
  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id
    end
  end
end

# Now use MyApp.Schema to define new schemas
defmodule MyApp.Comment do
  use MyApp.Schema

  schema "comments" do
    belongs_to :post, MyApp.Post
  end
end

# Ecto schema has two data types, primitive and custom types
- A custom type is a module that implements one of the Ecto.Type or Ecto.ParameterizedType behaviours.
- e.g Ecto.UUID and Ecto.Enum


# EMBEDDED SCHEMAS
- Embedded schemas store the child alongside the parent entry e.g User Parent schema and child Profile schema


# QUESTIONS
- Proper explanation of difference between embedded schema and schema
- What exactly does it mean for a schema to be embedded? why do i need this?
