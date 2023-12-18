defmodule HelloNerves.Drivers.Button do
  @moduledoc """
  ボタンを制御するモジュール
  """

  # aliasを設定してライブラリの記述を短縮化
  alias Circuits.GPIO

  # ボタンのピン番号を定数として設定
  @button_pin 5

  @doc """
  ボタンの値の取得
  """
  def read() do
    # GPIOピンを開いて設定する
    {:ok, button} = GPIO.open(@button_pin, :input)

    # ボタンの値を読み込む
    value = GPIO.read(button)

    # GPIOのリファレンスを解放する
    GPIO.close(button)

    # 結果を返す
    value
  end
end
