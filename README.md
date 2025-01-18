# Organization Charts Project

## Data Sources
### Organization charts
- Dataset: *Organization Chart/System Diagram Handbook* (Diamond, Inc.)
- Period: 2006, 2008, 2011  

### Firm-level performance
- Dataset: JLCP  
- Provider: [RIETI](https://www.rieti.go.jp/jp/database/JLCP2021/index.html)
- Period: 1960-2020
  
### Management survey
1. **Intangible assets interview survey in Japan**  
   - Period: 2008, 2012  
   - Source: [RIETI](https://www.rieti.go.jp/jp/projects/research_activity/intangible-assets/)

2. **Japan Management of Survey (JP MOPS)**  
   - Period: 2016, 2018, 2020  
   - Source: [ESRI (内閣府 経済社会総合研究所)](https://www.e-stat.go.jp/stat-search/files?page=1&toukei=00100412&tstat=000001103115&result_page=1)

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
