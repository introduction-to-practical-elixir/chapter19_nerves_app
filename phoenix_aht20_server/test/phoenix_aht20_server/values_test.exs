defmodule PhoenixAht20Server.ValuesTest do
  use PhoenixAht20Server.DataCase

  alias PhoenixAht20Server.Values

  describe "values" do
    alias PhoenixAht20Server.Values.Value

    import PhoenixAht20Server.ValuesFixtures

    @invalid_attrs %{temp: nil, humi: nil}

    test "list_values/0 returns all values" do
      value = value_fixture()
      assert Values.list_values() == [value]
    end

    test "get_value!/1 returns the value with given id" do
      value = value_fixture()
      assert Values.get_value!(value.id) == value
    end

    test "create_value/1 with valid data creates a value" do
      valid_attrs = %{temp: 120.5, humi: 120.5}

      assert {:ok, %Value{} = value} = Values.create_value(valid_attrs)
      assert value.temp == 120.5
      assert value.humi == 120.5
    end

    test "create_value/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Values.create_value(@invalid_attrs)
    end

    test "update_value/2 with valid data updates the value" do
      value = value_fixture()
      update_attrs = %{temp: 456.7, humi: 456.7}

      assert {:ok, %Value{} = value} = Values.update_value(value, update_attrs)
      assert value.temp == 456.7
      assert value.humi == 456.7
    end

    test "update_value/2 with invalid data returns error changeset" do
      value = value_fixture()
      assert {:error, %Ecto.Changeset{}} = Values.update_value(value, @invalid_attrs)
      assert value == Values.get_value!(value.id)
    end

    test "delete_value/1 deletes the value" do
      value = value_fixture()
      assert {:ok, %Value{}} = Values.delete_value(value)
      assert_raise Ecto.NoResultsError, fn -> Values.get_value!(value.id) end
    end

    test "change_value/1 returns a value changeset" do
      value = value_fixture()
      assert %Ecto.Changeset{} = Values.change_value(value)
    end
  end
end
