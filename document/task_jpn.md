## お願いしたいこと

スキャナー([CZUR ET24 Pro](https://czur.jp/products/et-series) ?)のレンタル→千賀さん

2の組織図画像のスキャンと3のアノテーション→学部生の方

- スキャン
手順
1. 説明書に従ってスキャナーのセットアップ
ライトをつける必要があるかを前もって確認します。
2. スキャン
1枚ずつ本を捲ってスキャンする。(自動捲り検知機能がついている)
左上のコードの場所をずらさない用にスキャンする。（これが一番大事）
見開きでスキャンすると1ページづつ出力してくれるモードがあるはず。
失敗したらスキャンを止めてその画像ファイルを消す。
3. 保存
USBメモリ等を使うか、そのままGoogle Drive or Boxでも可。

画像はあればあるだけいいです。複数ページにまたがっている企業もありますが、気にせずページを一枚ずつ捲るだけで大丈夫です。(後のプロセスで企業ごとに最初のページだけしか使ってないです。）

- アノテーション
手順
    1. スキャンした画像から50枚くらいをランダムに取り出して組織図部分をスクリーンショット。色々な組織図の形式の方が好ましいかも。
    2. coco-annotatorを起動してプロジェクトを作成し、
    画像内の部署の場所に、Boxで[”department”]のラベルをつけていく。
    （ここは実際に触るとわかると思います。）
    参考:
    docker設定の解説：[https://qiita.com/cleyera_f/items/bdd3d33f13527604a663](https://qiita.com/cleyera_f/items/bdd3d33f13527604a663)
    coco-annotatorの解説： [https://dev.classmethod.jp/articles/making-datasets-for-pose-estimation-by-using-coco-annotator/](https://dev.classmethod.jp/articles/making-datasets-for-pose-estimation-by-using-coco-annotator/)
    3. 終わったらcoco formatで出力して保存。
    
    R-CNNデータの形式がcoco フォーマットというちょっと複雑なものなので、coco-annotatorというツールを使ってアノテーションをしていただきたいです。Dockerの環境整備が少しめんどくさいですが、他のプロジェクトでも使う可能性があるのでパソコンで環境設定しておく損はないと思います。coco-annotatorの操作は慣れたら簡単です。
    
    地道な作業で面白くない作業ですいませんが、よろしくお願いします。
    
    わからないことがあれば聞いてください。