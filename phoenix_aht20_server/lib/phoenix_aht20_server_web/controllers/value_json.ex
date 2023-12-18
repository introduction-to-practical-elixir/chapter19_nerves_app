defmodule PhoenixAht20ServerWeb.ValueJSON do
  alias PhoenixAht20Server.Values.Value

  @doc """
  Renders a list of values.
  """
  def index(%{values: values}) do
    %{data: for(value <- values, do: data(value))}
  end

  @doc """
  Renders a single value.
  """
  def show(%{value: value}) do
    %{data: data(value)}
  end

  defp data(%Value{} = value) do
    %{
      id: value.id,
      temp: value.temp,
      humi: value.humi
    }
  end
end
