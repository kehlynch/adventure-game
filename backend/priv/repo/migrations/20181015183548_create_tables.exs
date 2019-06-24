defmodule Ag.Repo.Migrations.CreateTables do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email_address, :string

      timestamps()
    end

    create table(:stores) do
      add :user_id, references(:users)
      add :data, :map, default: %{}

      timestamps()
    end
  end
end
