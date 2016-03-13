#!/bin/bash

#  main.command
#  VLC-cutter

#  Created by Karl Holz on 2016-02-11.
#  Copyright © 2016 Karl Holz. All rights reserved.

##############################
#  cut Video to save directory
#

function time2sec {
    if [[ $1 =~ ^[0-9]+$ ]]; then
        echo $1
    else
        $m=$(echo $1 | cut -d':' -f1)
        $s=$(echo $1 | cut -d':' -f2)
        if [[ $m =~ ^[0-9]+$ ]]; then
            if [[ $s =~ ^[0-5][0-9]$ ]]; then
                if [[ $s =~ ^0[1-9] ]]; then
                    s=$(echo $s| tr -d '0')
                elif [[ $s =~ ^00 ]]; then
                    s=0
                fi
            else
                s=0
            fi
        else
            s=0
        fi
        echo $(( $(( $m * 60 )) + $s ))
    fi
}

CMD=/Applications/VLC.app/Contents/MacOS/VLC
while read start_stop; do
#start
    if [ $start_sec == 0 ]; then
        test=$(echo $start_stop|cut -d' ' -f1)
        start=$(time2sec $test)

    else
        start=$start_sec
    fi
#stop
    if [ $stop_sec == 0 ]; then
        test=$(echo $start_stop|cut -d' ' -f2)
        stop=$(time2sec $test)
    else
        stop=$stop_sec
    fi
#cut video
    save="$savepath/$(basename ${filename}) - ${1}-${2}.mp4"
    sout="--sout=\'#transcode{vcodec=h264,vb=1024,acodec=mp3,ab=192,channels=2,samplerate=44100}:std{access=file,mux=ts,dst=$save}\'"
    $CMD --intf=rc --start-time $start --stop-time $stop $filename vlc://quit $sout 2>/dev/null
    echo $save

done
exit 0