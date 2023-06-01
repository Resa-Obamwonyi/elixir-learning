defmodule Friends.Repo.Migrations.CreateGroups do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :group_name, :string
      add :group_rank, :string
      add :is_rich_group, :boolean, null: false, default: true
    end
  end
end
