#!/bin/bash -x
#screencasts.sh for CPLUG
#sample:ffmpeg -f alsa -ac 2 -i hw:0,1 -f x11grab -r 30 -s 1280x1024 -i :0.0 -acodec pcm_s16le -vcodec libx264 -vpre lossless_ultrafast -threads 0 output.avi
#sample2:avconv -f alsa -i pulse -f x11grab -r 25 -s 1920x1080 -i :0.0 -vcodec mpeg4 -b 12000k -g 300 -bf 2 -acodec libmp3lame -ab 256k Screencast.avi

DATE=$(date)

# 0 = automatic number of threads
THREADS=0

#Resolution
RESO=1920x1080

#Audio Device
AUDIO=alsa

#Channels
CHANNELS=2

#SoundCard
SOUNDCARD=pulse

#Frames per second
FPS=25

#Directory where your video is gonna be saved.(include / at the end)
DIRECTORY=$PWD

#File name
FILENAME=videocast $(date +%d%m%Y_%H.%M.%S).avi

#tmpdir
TMPDIR=$(mktemp -d)


avconv -f "$AUDIO" -ac "$CHANNELS" -i "$SOUNDCARD" -f -b 10000k -g 300 -bf 2 -acodec libmp3lame -ab 128k -threads "$THREADS" "$TMPDIR/audio.avi"
ffmpeg -f x11grab -r "$FPS" -s "$RESO" -i :0.0 -vcodec huffyuv -sameq $TMPDIR/screencast.avi
ffmpeg -isync -i "$TMPDIR/audio.avi" -i "$TMPDIR/screencast.avi" -acodec mp2 -ab 192k -vcodec copy "$FILENAME"
mv "$FILENAME" "$PWD"
rm -r "$TMPDIR"
#echo "The name of your file is $FILENAME in your $PWD. \n"
