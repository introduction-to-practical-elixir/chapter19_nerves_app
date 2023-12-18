defmodule HelloNerves.ButtonServer do
  @moduledoc """
  ボタンモジュールとの連携によるデータの測定とPOST
  """

  # GenServerを使用する
  use GenServer

  # aliasを設定してライブラリの記述を短縮化
  alias Circuits.GPIO
  alias HelloNerves.Drivers.Led
  alias HelloNerves.WebIF

  # ボタンのピン番号を定数として設定
  @button_pin 5

  @doc """
  GenServerプロセスとして開始するための関数
  """
  def start_link(_) do
    GenServer.start_link(__MODULE__, [])
  end

  @doc """
  開始時に実行する関数
  """
  def init(_) do
    # GPIOピンを開いて設定する
    {:ok, button} = GPIO.open(@button_pin, :input)
    # ボタンが押されたらhandle_info/2関数を実行するようにする
    GPIO.set_interrupts(button, :rising)

    {:ok, %{button: button}}
  end

  @doc """
  ボタンの押下で実行されるコールバック関数
  """
  def handle_info({:circuits_gpio, @button_pin, _timestamp, value}, state) do
    # ボタンの押下で本関数が実行されたことをデバッグ用に出力
    IO.puts("Button is now #{value}")

    # LEDの点灯
    Led.turn_on()
    # 温度と湿度を測定してREST APIにPOSTする
    WebIF.post()
    # LEDの消灯
    Led.turn_off()

    {:noreply, state}
  end
end
