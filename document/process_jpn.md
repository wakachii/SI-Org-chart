## Process

1. 組織図画像のスキャン
    1. ダイアモンド社の本のページをスキャン
2. アノテーション
アノテーションとは画像データに対してどこに物体があるのかを自分でラベル付けすること。
    
    画像認識モデルを組織図用にチューニングしなくては行けないため、自分である程度の学習用データを作る必要がある。
    
3. データ作成
    1. OCR
    ページの左上、証券コードの場所を切り取ってOCRする(文字を読み取る)
    読み取った証券コードをファイル名にして保存する。
    2. 組織図の場所を切り出す
    **LayoutParser**というドキュメントから図や表、文章の場所を検出できるライブラリ(Deep-learning based：[https://layout-parser.github.io](https://layout-parser.github.io/))を使って画像データから組織図の場所だけを切り出して保存する。(スキャンしたページには住所とかの他の情報が入っているから…)
    
    ここはGPUのためにGoogle Colabに移動—————————————————————-
    3. 組織図の部署の場所を検出するモデルの準備
    Mask R-CNN([https://research.facebook.com/publications/mask-r-cnn/](https://research.facebook.com/publications/mask-r-cnn/))という画像認識モデルを使って、3でアノテーションしたデータを再学習させる。
    (Metaの素晴らしいモデルを組織図用にチューニングするイメージ)
    4. 実際のデータを使って検出
    cのモデルにbのデータを使って画像内のどこが部署なのかを検出(予測)させて保存。
    —————————————————————-
    5. ネットワークデータの作成
    座標間の距離(normalized)を使ってネットワークデータ作成する。
    (networkXというpythonのライブラリを使用)
    6. 最短経路長(shortest path length)を使って階層構造を表現
    (部署の数もデータ化しているがコード修正中です。)
    7. データ完成
    最終的なイメージは変数がyear, code, shortest path length, num of departments, …みたいなデータ
4. 分析
    1. Output, productivity (JLCP data from RIETI)やManagement Scoreと合わせて分析する。