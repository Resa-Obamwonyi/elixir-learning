defmodule Friends.Repo.Migrations.CreatePeople do
  use Ecto.Migration

  def change do
    create table(:people) do
      add :first_name, :string
      add :last_name, :string
      add :age, :integer
      add :group_id, references(:groups)
    end
  end
end

# used embedded schema to add address to group and friend tables
