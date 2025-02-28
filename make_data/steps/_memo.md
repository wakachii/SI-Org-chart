# Image Processing Workflow
I use only the first page of the each firm.
- original image: year/image.png

## 1. OCR
- Read the firm codes using OCR.
- Rename the files based on the extracted codes.
- File: ocr.ipynb

## 2. Layout Detection
- Detect the location of the organizational chart in the images.
- Crop the images to isolate the organizational chart.
- File: layout_detection.ipynb

## 3. Coordinate Detection with deep-learning model
- Use a deep learning model to identify the coordinates of departments within the image.
- File: deeplearning_detection.ipynb

## 4. Network Creation and Hierarchy and Complexity Calculation
- Create a network dataset based on distance metrics between the detected departments.
- Calculate hierarchical structures and their complexity based on the network data.
- File: network.ipynb