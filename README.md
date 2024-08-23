## Organization Charts
Task

1. Cut out the location of the organizational chart → Done
   
   ・Cutting header and edges

   ・Footer detection and cutting

2. Firm code detection with OCR → Done
   
   ・Cutting header

   ・Preprocessing image and OCR


3. Measure the complexity metrics of the chart → Done

   ・Calculating the entropy
   
![7f1b2afb-a004-4595-907c-f3c9f468ddbb](https://github.com/user-attachments/assets/9ef549fc-9421-4f4f-b741-f52aaa0255ee)

   ・Reduction to the 3rd dimension

![92805c27-56cc-4660-9a95-bce4ca2e5b05](https://github.com/user-attachments/assets/3cdda38a-fa07-49d3-a617-e7c55b3e3144)


5. Measure the hierarchical structure of the chart → In progress

   ・Text detection
   
    Perfect OCR is not possible because layouts are so diverse.
   
   ・Node detection

     This is a difficult problem. I think we have to use some deep-learning models like https://arxiv.org/abs/2311.10234

   ・Junction point detection

