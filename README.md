# Organization Charts Project

## Data Sources
### Organization charts
- Dataset: *Organization Chart/System Diagram Handbook* (Diamond, Inc.)
- Period: 2006, 2008, 2011  

### Firm-level performance
- Dataset: JLCP  
- Provider: [RIETI](https://www.rieti.go.jp/jp/database/JLCP2021/index.html)
- Source: 1960-2020
  
### Management survey
1. **Intangible assets interview survey in Japan**  
   - Period: 2008, 2012  
   - Source: [RIETI](https://www.rieti.go.jp/jp/projects/research_activity/intangible-assets/)

2. **Japan Management of Survey (JP MOPS)**  
   - Period: 2016, 2018, 2020  
   - Source: [ESRI (内閣府 経済社会総合研究所)](https://www.e-stat.go.jp/stat-search/files?page=1&toukei=00100412&tstat=000001103115&result_page=1)

## Process for quantifying the hierarchical structure of firms from organization chart images

1. Scanning Organizational Chart Images
- Scanning Pages from Diamond Publishing Books

2. Data Creation
- OCR
  - Extract the upper left corner of the page where the stock code is located and perform OCR (optical character recognition) to read the text.
  - Save the extracted stock code as the file name.
  - Extract the location of the organizational chart.

- Crop the org chart
  - By using the LayoutParser library: LayoutParser (Deep-learning based layout detection model)
  - Detects the positions of figures, tables, and text within an image and extracts only the organizational chart.
  - This step is necessary because scanned pages contain additional information such as addresses.

- Annotation
  - Annotation involves manually labeling objects in image data to indicate their locations.
  - Since the image recognition model needs to be fine-tuned for organizational charts, it is necessary to create training data manually.

- Department detection
  - Move to Google Colab for GPU acceleration
  - Retrain [Mask R-CNN](https://ai.meta.com/research/publications/mask-r-cnn/) model using the annotation data and detect department locations within images.
    
- Creating Network Data
  - Use normalized distances between coordinates to create network data.
  - *Library: *networkX (Python)
  - Represent hierarchical structures using the shortest path length.

3. Analysis
- Combine with productivity data (JLCP from RIETI) and Management Score for analysis.


## Structure of this repository

```
├── README.md
├── _scrap
├── analysis
│   └── analysis.ipynb
└── make_data/
    ├── _memo.md
    ├── steps
    │   ├── deeplearning_detection.ipynb
    │   ├── layout_detection.ipynb
    │   ├── network.ipynb
    │   └── ocr.ipynb
    └── output
```
