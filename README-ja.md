# groonga-d
全文検索エンジンであるGroongaのD言語バインディング。

## ビルドの方法
groonga-dをビルドするにはgroongaのライブラリが必要です。

### Windows
Windowsのライブラリは[公式から配布されている](https://github.com/groonga/groonga/releases)ので、そこからダウンロードします。
自動でダウンロードするには以下のコマンドを実行します。

```
rdmd download_lib.d
```

ダウンロードしたらビルドします。

```
dub build --arch=x86_mscoff
dub build --arch=x86_64
```
