# chapter19_nerves_app

このリポジトリでは[『Elixir実践入門 ――基本文法、Web開発、機械学習、IoT』](https://gihyo.jp/book/2024/978-4-297-14014-4/)（技術評論社 WEB+DB PRESS plusシリーズ 2024年2月24日発売）の第19章「実践的なIoTアプリケーションの開発」で登場するIoTアプリケーションのサンプルコードを公開しています。

- [hello_nerves](./hello_nerves)：Nervesデバイス側のソースコード
- [phoenix_aht20_server](./phoenix_aht20_server)：Phoenixサーバ側のソースコード

Nervesデバイス側のソースコードには、第17章と第18章の実装内容も含んでいます。
項目ごとの手順は[commit log](https://github.com/introduction-to-practical-elixir/chapter19_nerves_app/commits/main/)をご参照ください。

## 利用しているソフトウェア

本章で利用しているソフトウェアは、執筆時点の最新である次のバージョンで動作確認を行っています。環境や時期により、手順・画面・動作結果などが異なる可能性があります。

- Elixir 1.15.7-otp-26
- Erlang/OTP 26.1.2
- Phoenix 1.7.10
- Ecto 3.11.1
- Phoenix LiveView 0.20.1
- Nerves 1.10.4

`main`ブランチでは、上記のバージョンを利用したものを示しています。
いずれかのバージョンアップで追加作業やコード修正が必要になった場合は、別のブランチを作成して対応する予定です。

## 用意するもの

本章／本リポジトリを試すために必要なハードウェアを示します。

- ホスト用のPC（macOSまたはLinuxがお勧め）
- Raspberry Pi 4（メモリはどのモデルでもかまいません）
- Raspberry Pi 4用のACアダプタ
- microSDカード（容量はなんでもかまいません）
- ネットワーク環境（お勧めの構成は書籍P.344 図17.1に示しています）
- Groveモジュール（組み立ては書籍P.360 写真18.1に示しています）
  - [Grove Base HAT](https://www.seeedstudio.com/Grove-Base-Hat-for-Raspberry-Pi.html)
  - [Grove LED](https://www.seeedstudio.com/Grove-Red-LED.html)
  - [Grove Button](https://www.seeedstudio.com/Grove-Button.html)
  - [Grove AHT20](https://www.seeedstudio.com/Grove-AHT20-I2C-Industrial-grade-temperature-andhumidity-sensor-p-4497.html)

## サポートサイト

本書の公式のサポートサイトは下記となります。書籍内容についての質問や誤り箇所の指摘などはこちらにお寄せください。正誤情報なども掲載します。

https://gihyo.jp/book/2024/978-4-297-14014-4/support

本リポジトリに含まれるソースコードに関する質問や問い合せは[Issue](https://github.com/introduction-to-practical-elixir/chapter19_nerves_app/issues)でお知らせいただいても構いません。

