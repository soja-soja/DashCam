# EasyDashCamEditor (EDCE) by SOJA
If you have a sport camera and want to create timelapse, remove sound and audio, and easily Speed up/down your DashCam videos taken by any Sport/DSLR/Mobile Camera, you are on the right rep.

## Inputs:
[***fileType=*** mp4]  [ ***speed=*** 4 ] [ ***frameRate=*** 30 ]


## To Start:

1. make sure you have ffmpeg installed on your system

2. Download the DashCamPipeline.sh and copy it in a folder of your choice (we call it DC_Home)
3. Open terminal in that folder, ctrl+alt+t and cd to DC_Home, Now run these commands:
-- `chmod +x DashCamPipeline.sh`  
`mkdir 1.DO` 

2. Put all your Video files in ./DO folder, pass the file extension as the first parameter and desirable speed rate as the second input and Run it:

-	`./DashCamPipeline.sh mp4 1` 
to just simply remove the audio and concatenate all videos with mp4 format

-	`./DashCamPipeline.sh mp4 5`  
to remove the audio and speed up (5X) and concatenate all videos with mp4 format

-	`./DashCamPipeline.sh avi 5`  
to remove the audio and speed up (5X) and concatenate all videos with avi format

-	`./DashCamPipeline.sh avi 5 60`  
to remove the audio and speed up (5X) and original FrameRate is 60 fps and concatenate all videos with avi format

-	`./DashCamPipeline.sh` 
to remove the audio and speed up (4X) and assume videos are 30fps and concatenate all videos with mp4 format - Default


Enjoy your output file in ./Final...


	
  


  
