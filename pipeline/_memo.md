# Image Processing Workflow
I use only the first page of the each firm.
- original image: year/image.png

## 1. OCR
- Read the firm codes using OCR.
- Rename the files based on the extracted codes.
- output: renamed/code_year.png
- memo  : Data in 2002 and 2010 are done. Data in 2006 is proceeding (needs to be adjusted but).

## 2. Layout Detection
- Detect the location of the organizational chart in the images.
- Crop the images to isolate the organizational chart.
- output: cropped/cropped_code_year.png

## 3. Coordinate Detection with deep-learning model
- Use a deep learning model to identify the coordinates of departments within the image.
- output: image/coordination/coordination_code_year.csv

## 4. Network Creation and Hierarchy and Complexity Calculation
- Create a network dataset based on distance metrics between the detected departments.
- Calculate hierarchical structures and their complexity based on the network data.
- output: data/org_data.csv (firm_code, year, hierarchy, complexity)