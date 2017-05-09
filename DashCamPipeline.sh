#!/bin/bash

#########
## SOJA #
#########

ALL_START_TIME=$SECONDS

START_TIME=$SECONDS

rm -r 2.NoAudio  3.Fast logs
mkdir -p 1.Do  2.NoAudio  3.Fast  4.Final logs


# --------------------------------- Variables ------------------------------------

OriginalFrameRate=${3:-30}
NewFrameRate=$(($OriginalFrameRate*${2:-4}))

speed=$(bc <<<"scale=3;1/${2:-4}")
FileType=${1:-"mp4"}
now=$(date +"%m_%d_%Y__%H%M")

# ---------------------------------------------------------------------------------------
echo -e "Removing Audio..."
cd 1.Do
for f in *.$FileType; do
	ffmpeg -i $PWD/$f -vcodec copy -an ../2.NoAudio/$f 2>> ../logs/$now.log
done
ELAPSED_TIME=$(($SECONDS - $START_TIME))
echo -e "\t-Done in $(($ELAPSED_TIME/60)) min $(($ELAPSED_TIME%60)) sec\n\n"
START_TIME=$SECONDS


echo -e "Fasten Video Tracks..."
cd ../2.NoAudio/

for f in *.$FileType; do
	# for audio and Video 
	# ffmpeg -i $PWD/$f -r 75 -filter_complex "[0:v]setpts=0.5*PTS[v];[0:a]atempo=2.0[a]" -map "[v]" -map "[a]" ../3.fast/$f

	#only for video:
	
	ffmpeg -i $PWD/$f -r $NewFrameRate -filter:v "setpts=$speed*PTS" ../3.Fast/$f 2>> ../logs/$now.log
done
ELAPSED_TIME=$(($SECONDS - $START_TIME))
echo -e "\t-Done in $(($ELAPSED_TIME/60)) min $(($ELAPSED_TIME%60)) sec\n\n"
START_TIME=$SECONDS

echo -e "Concatinate all..."

cd ../3.Fast
ffmpeg -f concat -safe 0 -i <(for f in *.$FileType; do echo -e "file '$PWD/$f'"; done) -c copy ../4.Final/RoadTrip_$now.$FileType 2>> ../logs/$now.log


ELAPSED_TIME=$(($SECONDS - $START_TIME))
echo -e "\t-Done in $(($ELAPSED_TIME/60)) min $(($ELAPSED_TIME%60)) sec\n\n"
START_TIME=$SECONDS



echo -e "*** All Done! in ***"
ELAPSED_TIME=$(($SECONDS - $ALL_START_TIME))
echo -e "\t\t-Overall time: $(($ELAPSED_TIME/60)) min $(($ELAPSED_TIME%60)) sec\n"
