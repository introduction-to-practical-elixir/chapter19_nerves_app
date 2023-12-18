defmodule PhoenixAht20ServerWeb.Live.Dashboard do
  use PhoenixAht20ServerWeb, :live_view

  def render(assigns) do
    ~L"""
    <h1>AHT20 Dashboard</h1>
    <div id="dashboard">
      <div>温度：<%= @temp %>℃</div>
      <div>湿度：<%= @humi %>%</div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(1000, self(), :tick)
    end

    {:ok, assign_stats(socket)}
  end

  def handle_info(:tick, socket) do
    {:noreply, assign_stats(socket)}
  end

  defp assign_stats(socket) do
    {temp, humi} =
      case PhoenixAht20Server.Values.get_latest_value() do
        nil -> {0, 0}
        value -> {value.temp, value.humi}
      end

    assign(socket, temp: temp, humi: humi)
  end
end
