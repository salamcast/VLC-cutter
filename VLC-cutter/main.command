#!/bin/bash

#  main.command
#  VLC-cutter

#  Created by Karl Holz on 2016-02-11.
#  Copyright © 2016 Karl Holz. All rights reserved.

##############################
#  cut Video to save directory
#
function time2sec() {
    if [[ $1 =~ ^[0-9]+$ ]]; then
        echo $1
    else
        m=$(echo $1 | cut -d':' -f1)
        s=$(echo $1 | cut -d':' -f2)
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
if [ "x$pad" == "x" ]; then
    pad=5
fi
c=0
while read start_stop; do
    #start
    test=$(echo $start_stop|cut -d' ' -f1)
    start[$c]=$(time2sec $test)

    #stop
    test=$(echo $start_stop|cut -d' ' -f2)
    # pad seconds to avoid cutting off too much
    stop[$c]=$(time2sec $test)


    c=$(( $c + 1 ))
done

if [ "x${start[0]}" == "x" ]; then
    start[0]=$(time2sec $start_sec)
fi

if [ "x${stop[0]}" == "x" ]; then
    stop[0]=$(time2sec $stop_sec)
    if [ $start_sec === $stop_sec ]; then
        stop[0]=$(($start[0] + 15))
    fi
fi
if [ "x$savepath" == "x" ];then
    savepath=$(echo ~/Desktop)
fi

CMD=/Applications/VLC.app/Contents/MacOS/VLC
v=0
while [ "x${start[v]}" != "x" ]; do
    #pad so any glitches are on the first 1-5 or so seconds

    start[$v]=$((${start[v]} - $pad ))

    stop[$v]=$(( ${stop[v]} + $pad ))

    #cut video
    save=$savepath/$(echo $(basename -s .mp4 $filename )---${start[v]}-${stop[v]}.mp4 | tr ' ' '_' )
    $CMD --start-time=${start[v]} --stop-time=${stop[v]} --sout="#transcode{vcodec=h264,vb=1024,acodec=mp3,ab=192,channels=2,samplerate=44100}:std{access=file,mux=ts,dst=$save}"  "file://$filename" vlc://quit 2>/dev/null 1>/dev/null
    echo $save
    v=$(( $v + 1 ))
done
exit 0