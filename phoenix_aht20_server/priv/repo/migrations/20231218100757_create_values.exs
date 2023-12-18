defmodule PhoenixAht20Server.Repo.Migrations.CreateValues do
  use Ecto.Migration

  def change do
    create table(:values) do
      add :temp, :float
      add :humi, :float

      timestamps(type: :utc_datetime)
    end
  end
end
