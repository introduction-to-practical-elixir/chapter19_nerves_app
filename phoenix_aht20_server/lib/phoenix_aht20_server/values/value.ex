defmodule PhoenixAht20Server.Values.Value do
  use Ecto.Schema
  import Ecto.Changeset

  schema "values" do
    field :temp, :float
    field :humi, :float

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(value, attrs) do
    value
    |> cast(attrs, [:temp, :humi])
    |> validate_required([:temp, :humi])
  end
end
