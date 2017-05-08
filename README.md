# EasyDashCam by SOJA
Easily Speed up your DashCam videos taken by any Sport/DSLR/Mobile Camera

## Inputs:
[***fileType=*** mp4]  [ ***speed=*** 4 ]


## To Start:

1. make sure you have ffmpeg installed on your system

2. Download the DashCamPipeline.sh and copy it in a folder of your choice (we call it DC_Home)
3. Open terminal in that folder, ctrl+alt+t and cd to DC_Home, Now run these commands:
-- `chmod +x DashCamPipeline.sh`  
`mkdir 1.DO` 

2. Put all your Video files in 1.DO folder, pass the file extension as the first parameter and desirabel speed rate as the second input and Run it:

-	`./DashCamPipeline.sh mp4 1` 
to just simply remove the audio and concatinate all videos with mp4 format

-	`./DashCamPipeline.sh mp4 5`  
to remove the audio and speed up (5X) and concatinate all videos with mp4 format

-	`./DashCamPipeline.sh avi 5`  
to remove the audio and speed up (5X) and concatinate all videos with avi format

-	`./DashCamPipeline.sh` 
to remove the audio and speed up (4X) and concatinate all videos with mp4 format - Default


Enjoy your output file in 4.Final...


	
  


  
