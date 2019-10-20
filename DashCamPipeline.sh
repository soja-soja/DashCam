#!/bin/bash

######################################
## Written by: SOJA                 ##
###  Example						##
### ./DashCamPipeline.sh avi 5 60 0 ##
##[format] [speed] [frame] [threads]##
######################################

ALL_START_TIME=$SECONDS

START_TIME=$SECONDS

rm -r 2.NoAudio  3.Fast logs
mkdir -p 1.Do  2.NoAudio  3.Fast  4.Final logs


# --------------------------------- Variables ------------------------------------
MaxFrameRate=30
OriginalFrameRate=${3:-30}
Threads=${4:-0}
a=$(($OriginalFrameRate*${2:-4}))
NewFrameRate=$(( a < MaxFrameRate ? a : MaxFrameRate ))

speed=0.05
FileType=${1:-"AVI"}
now=$(date +"%m_%d_%Y__%H%M")

# ---------------------------------------------------------------------------------------
echo -e "\nRemoving Audio..."
cd 1.Do
for f in *.$FileType; do
	echo -n '*'
	ffmpeg -i $PWD/$f -vcodec copy -an ../2.NoAudio/$f -threads $Threads 2>> ../logs/$now.log
done
ELAPSED_TIME=$(($SECONDS - $START_TIME))
echo -e "\n\t-Done in $(($ELAPSED_TIME/60)) min $(($ELAPSED_TIME%60)) sec\n\n"
START_TIME=$SECONDS


echo -e "Fasten Video Tracks..."
cd ../2.NoAudio/

for f in *.$FileType; do
	# for audio and Video 
	# ffmpeg -i $PWD/$f -r $NewFrameRate -filter_complex "[0:v]setpts=$speed*PTS[v];[0:a]atempo=2.0[a]" -map "[v]" -map "[a]" ../3.Fast/$f 2>> ../logs/$now.log

	#only for video:
	echo -n '*'
	ffmpeg -i $PWD/$f -r $NewFrameRate -filter:v "setpts=$speed*PTS" ../3.Fast/$f -threads $Threads 2>> ../logs/$now.log
done
ELAPSED_TIME=$(($SECONDS - $START_TIME))
echo -e "\n\t-Done in $(($ELAPSED_TIME/60)) min $(($ELAPSED_TIME%60)) sec\n\n"
START_TIME=$SECONDS

echo -e "Concatinate all..."

cd ../3.Fast
ffmpeg -f concat -safe 0 -i <(for f in *.$FileType; do echo -e "file '$PWD/$f'"; done) -c copy ../4.Final/RoadTrip_$now.$FileType -threads $Threads 2>> ../logs/$now.log


ELAPSED_TIME=$(($SECONDS - $START_TIME))
echo -e "\t-Done in $(($ELAPSED_TIME/60)) min $(($ELAPSED_TIME%60)) sec\n\n"
START_TIME=$SECONDS



echo -e "*** All Done! in ***"
ELAPSED_TIME=$(($SECONDS - $ALL_START_TIME))
echo -e "\t\t-Overall time: $(($ELAPSED_TIME/60)) min $(($ELAPSED_TIME%60)) sec\n"

cd ..
# rm -r 2.NoAudio  3.Fast
