defmodule PhoenixAht20Server.ValuesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixAht20Server.Values` context.
  """

  @doc """
  Generate a value.
  """
  def value_fixture(attrs \\ %{}) do
    {:ok, value} =
      attrs
      |> Enum.into(%{
        humi: 120.5,
        temp: 120.5
      })
      |> PhoenixAht20Server.Values.create_value()

    value
  end
end
