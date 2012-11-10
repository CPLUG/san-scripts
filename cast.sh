#!/bin/bash
INRES="1920x1200"
OUTRES="1920x1200"
FPS="30"
QUAL="veryfast"
STREAM_KEY="****************"

#ffmpeg -f x11grab -s "$INRES" -r "$FPS" -i :0.0 -f alsa -ac 2 -i pulse -vcodec libx264 -crf 25 -maxrate 1000k -bufsize 500k -s "$OUTRES" -acodec libmp3lame -ab 128k -ar 44100 -threads 0 -f flv file.avi
ffmpeg -f x11grab -s "$INRES" -r "$FPS" -i :0.0 -f alsa -ac 2 -i pulse -vcodec libx264 -maxrate 1000k -s "$OUTRES" -acodec libmp3lame -ab 128k -ar 44100 -threads 0 -f flv file.avi


