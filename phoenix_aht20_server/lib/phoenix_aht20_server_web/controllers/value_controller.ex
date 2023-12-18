defmodule PhoenixAht20ServerWeb.ValueController do
  use PhoenixAht20ServerWeb, :controller

  alias PhoenixAht20Server.Values
  alias PhoenixAht20Server.Values.Value

  action_fallback PhoenixAht20ServerWeb.FallbackController

  def index(conn, _params) do
    values = Values.list_values()
    render(conn, :index, values: values)
  end

  def create(conn, %{"value" => value_params}) do
    with {:ok, %Value{} = value} <- Values.create_value(value_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/values/#{value}")
      |> render(:show, value: value)
    end
  end

  def show(conn, %{"id" => id}) do
    value = Values.get_value!(id)
    render(conn, :show, value: value)
  end

  def update(conn, %{"id" => id, "value" => value_params}) do
    value = Values.get_value!(id)

    with {:ok, %Value{} = value} <- Values.update_value(value, value_params) do
      render(conn, :show, value: value)
    end
  end

  def delete(conn, %{"id" => id}) do
    value = Values.get_value!(id)

    with {:ok, %Value{}} <- Values.delete_value(value) do
      send_resp(conn, :no_content, "")
    end
  end
end
