# 実行環境の構築

## deno

まず、以下のプログラムを実行して `deno` をインストールしてください。

- Windows

```powershell
iwr https://deno.land/x/install/install.ps1 -useb | iex
```

- Mac, Linux
```Shell
curl -fsSL https://deno.land/x/install/install.sh | sh
```

`Chocolatey` などを使用してインストールすることも可能です。[こちら](https://deno.land/)の `Installation` 項を参照してください。

## denon

次に、`Terminal` を再起動するなどして `deno` コマンドを有効にしてください。
そのうえで、以下のコマンドを実行し `denon` をインストールしてください。

- 全環境共通

```shell
deno install -qAf --unstable https://deno.land/x/denon/denon.ts
```

# 実行コマンド

以下のコマンドを、本リポジトリのローカルディレクトリがカレントディレクトリにある状態で実行してください。

```shell
deno install -qAf --unstable https://deno.land/x/denon/denon.ts
```