defmodule HelloNerves.Drivers.Led do
  @moduledoc """
  LEDを制御するモジュール
  """

  # aliasを設定してライブラリの記述を短縮化
  alias Circuits.GPIO

  # LEDのピン番号を定数として設定
  @led_pin 18

  @doc """
  LEDの点灯
  """
  def turn_on() do
    # GPIOピンを開いて設定する
    {:ok, led} = GPIO.open(@led_pin, :output)

    # LEDを点灯する
    GPIO.write(led, 1)

    # GPIOのリファレンスを解放する
    GPIO.close(led)
  end

  @doc """
  LEDの消灯
  """
  def turn_off() do
    # GPIOピンを開いて設定する
    {:ok, led} = GPIO.open(@led_pin, :output)

    # LEDを消灯する
    GPIO.write(led, 0)

    # GPIOのリファレンスを解放する
    GPIO.close(led)
  end
end
