defmodule HelloNerves.WebIF do
  @moduledoc """
  PhoenixサーバのREST APIとのインタフェース
  """

  # PhoenixサーバのREST APIのURLを設定
  @api_url "http://192.168.11.100:4000/api/values"

  # aliasを設定してライブラリの記述を短縮化
  alias HelloNerves.Drivers.Aht20

  def post() do
    # AHT20から温度と湿度の値を取得
    {:ok, {temp, humi}} = Aht20.read()

    # 取得した値をデバッグ用に出力
    IO.puts("temp: #{temp} / humi: #{humi}")

    # Reqライブラリを用いてJSON形式でPOST
    Req.post!(@api_url, json: %{value: %{temp: temp, humi: humi}})
  end
end
