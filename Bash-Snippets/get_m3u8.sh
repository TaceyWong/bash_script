#! /bin/env bash

if [ $("hash ffmpeg") ];then
    ffmpeg -i $1  -c copy out.mp4
else
    echo "pls install ffmpeg first"
fi