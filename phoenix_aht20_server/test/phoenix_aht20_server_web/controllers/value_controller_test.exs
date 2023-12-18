defmodule PhoenixAht20ServerWeb.ValueControllerTest do
  use PhoenixAht20ServerWeb.ConnCase

  import PhoenixAht20Server.ValuesFixtures

  alias PhoenixAht20Server.Values.Value

  @create_attrs %{
    temp: 120.5,
    humi: 120.5
  }
  @update_attrs %{
    temp: 456.7,
    humi: 456.7
  }
  @invalid_attrs %{temp: nil, humi: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all values", %{conn: conn} do
      conn = get(conn, ~p"/api/values")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create value" do
    test "renders value when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/values", value: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/values/#{id}")

      assert %{
               "id" => ^id,
               "humi" => 120.5,
               "temp" => 120.5
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/values", value: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update value" do
    setup [:create_value]

    test "renders value when data is valid", %{conn: conn, value: %Value{id: id} = value} do
      conn = put(conn, ~p"/api/values/#{value}", value: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/values/#{id}")

      assert %{
               "id" => ^id,
               "humi" => 456.7,
               "temp" => 456.7
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, value: value} do
      conn = put(conn, ~p"/api/values/#{value}", value: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete value" do
    setup [:create_value]

    test "deletes chosen value", %{conn: conn, value: value} do
      conn = delete(conn, ~p"/api/values/#{value}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/values/#{value}")
      end
    end
  end

  defp create_value(_) do
    value = value_fixture()
    %{value: value}
  end
end
