## Process

1. **組織図画像のスキャン**
    - ダイアモンド社の本のページをスキャン

2. **アノテーション**  
    アノテーションとは画像データに対してどこに物体があるのかを自分でラベル付けすること。  
    画像認識モデルを組織図用にチューニングするため、自分で学習用データを作る必要がある。

3. **データ作成**
    1. **OCR**  
        - ページの左上、証券コードの場所を切り取ってOCRする（文字を読み取る）。  
        - 読み取った証券コードをファイル名にして保存する。
    
    2. **組織図の場所を切り出す**  
        - **LayoutParser** というライブラリを使用。  
          Deep-learning based: [https://layout-parser.github.io](https://layout-parser.github.io)  
        - 図や表、文章の場所を検出し、画像データから組織図の場所だけを切り出して保存する。  
          （スキャンしたページには住所などの他の情報が含まれているため）
    
    **ここはGPUのために Google Colab に移動---------------------------------**
    
    3. **組織図の部署の場所を検出するモデルの準備**
        - **Mask R-CNN**  
          [https://research.facebook.com/publications/mask-r-cnn/](https://research.facebook.com/publications/mask-r-cnn/)  
        - 3で作成したアノテーションデータを使って再学習。  
        - Metaのresearchチームが開発した画像認識モデルを今回の組織図用にチューニングするイメージ。
    
    5. **実際のデータを使って検出**  
        - 学習済みモデルを使用して、画像内のどこが部署なのかを予測・検出。  
        - 結果を保存する。
    
    **--------------------------------------------------------------------------**
    
    5. **ネットワークデータの作成**  
        - 座標間の距離（normalized）を使用してネットワークデータを作成する。  
        - 使用ライブラリ: `networkX`（Python）。

    6. **最短経路長 (shortest path length) を使って階層構造を表現**  
        - 部署の数もデータ化しているが、コード修正中。

    7. **データ完成**  
        - 最終的なデータ形式:  
          `year, code, shortest path length, num of departments, ...`

4. **分析**  
    - Output, productivity（JLCP data from RIETI）やManagement Scoreと組み合わせて分析する。
