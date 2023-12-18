defmodule HelloNerves.Drivers.Aht20 do
  @moduledoc """
  温湿度センサAHT20を制御するモジュール
  """

  # aliasを設定してライブラリの記述を短縮化
  alias Circuits.I2C

  # AHT20のI2C上のバスとアドレスを定数として設定
  @i2c_bus "i2c-1"
  @i2c_addr 0x38

  # I2C通信にかかる待機時間を定数として設定(ms)
  @i2c_delay 100

  @doc """
  AHT20から温度・湿度を取得
  """
  def read() do
    # I2Cを開く
    {:ok, ref} = I2C.open(@i2c_bus)

    # AHT20を初期化する
    I2C.write(ref, @i2c_addr, <<0xBE, 0x08, 0x00>>)
    # 処理完了まで一定時間待機
    Process.sleep(@i2c_delay)

    # 温度・湿度を読み出すコマンドを送る
    I2C.write(ref, @i2c_addr, <<0xAC, 0x33, 0x00>>)
    # 処理完了まで一定時間待機
    Process.sleep(@i2c_delay)

    # 温度・湿度の値を読み込む
    {result, temp_humi} =
      case I2C.read(ref, @i2c_addr, 7) do
        # 正常に値が取得できたときは温度・湿度の値に換算して返す
        {:ok, val} -> {:ok, val |> convert()}
        # センサからの応答がないときはメッセージを返す
        {:error, :i2c_nak} -> {:error, "Sensor is not connected"}
        # そのほかのエラーのときもメッセージを返す
        _ -> {:error, "An error occurred"}
      end

    # I2Cのリファレンスを解放する
    I2C.close(ref)

    # 結果を返す
    {result, temp_humi}
  end

  # I2Cから得られた測定値を温度と湿度の値に換算する
  defp convert(val) do
    # バイナリの測定値をビット長でパターンマッチ
    # <<0:state, 1:humi1, 2:humi2, 3:humi3/temp1, 4:temp2, 5:temp3, 6:crc>>
    <<_state::8, raw_humi::20, raw_temp::20, _crc::8>> = val

    # 温度のビット列を換算する（データシートの換算式に準じた）
    temp = Float.round(raw_temp / 2 ** 20 * 200.0 - 50.0, 1)

    # 湿度のビット列を換算する（データシートの換算式に準じた）
    humi = Float.round(raw_humi / 2 ** 20 * 100.0, 1)

    # 温度と湿度をタプルにして返す
    {temp, humi}
  end
end
