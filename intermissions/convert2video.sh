#!/bin/bash

# passing a title to the intermission
# Params:
# 1: jobname
# 2: some string for the title
convert2video(){

    # compiling
    latexmk -jobname=extravaganza-intermission-$1 -pretex="\def\mytitle{$2}" -usepretex extravaganza-intermission
    
    # clean up old video
    rm $1.mp4

    # convert to png images
    # convert -density 160 extravaganza-intermission-$1.pdf $1.png
    pdftoppm -png -r 240 -progress extravaganza-intermission-$1.pdf $1

    # convert to video
    ffmpeg -r 10 -ss 00:00:00 -i $1-%02d.png -ss 00:00:00 -i christmas-music-box-music.m4a -shortest $1_raw.mp4

    # repair video
    HandBrakeCLI --crop 0:0:0:0 -i $1_raw.mp4 -o $1.mp4

    # clean up
    rm $1-*.png
    rm $1_raw.mp4
    rm extravaganza-intermission-$1.aux
    rm extravaganza-intermission-$1.log
    rm extravaganza-intermission-$1.nav
    rm extravaganza-intermission-$1.snm
    rm extravaganza-intermission-$1.toc
    rm extravaganza-intermission-$1.out
    rm extravaganza-intermission-$1.fls
    rm extravaganza-intermission-$1.fdb_latexmk

}

# repeat an existing pdf several times
# Params:
# 1: jobname
# 2: path and name to the pdf file
# 3: number of repetitions [default 75]
repeatconvert(){

    # compiling
    latexmk -jobname=extravaganza-intermission-$1 -pretex="\def\filename{$2}\def\myrepeat{$3}" -usepretex repeat  
    
    # clean up old video
    rm $1.mp4

    # convert to png images
    pdftoppm -png -r 240 -progress extravaganza-intermission-$1.pdf $1

    # convert to video
    ffmpeg -r 10 -ss 00:00:00 -i $1-%03d.png -ss 00:00:00 -i christmas-music-box-music.m4a -shortest $1_raw.mp4

    # repair video
    HandBrakeCLI --crop 0:0:0:0 -i $1_raw.mp4 -o $1.mp4

    # clean up
    rm $1-*.png
    rm $1_raw.mp4
    rm extravaganza-intermission-$1.aux
    rm extravaganza-intermission-$1.log
    rm extravaganza-intermission-$1.nav
    rm extravaganza-intermission-$1.snm
    rm extravaganza-intermission-$1.toc
    rm extravaganza-intermission-$1.out
    rm extravaganza-intermission-$1.fls
    rm extravaganza-intermission-$1.fdb_latexmk
        
}

# preview images
pdftoppm -png -r 48 -progress -singlefile extravaganza-titlepage.pdf icon_small
pdftoppm -png -r 100 -progress -singlefile extravaganza-titlepage.pdf icon_medium
pdftoppm -png -r 150 -progress -singlefile extravaganza-titlepage.pdf icon_large

# Converting
repeatconvert title "./extravaganza-titlepage.pdf" 101
convert2video mirage "Mirage"
convert2video StormyWeather "Stormy Weather"
convert2video flower-field "Where have all the flowers gone?"
convert2video Avignon "En vacançes"
convert2video cheese "Sweet dreams are made of cheese"
convert2video dinner "Dinner"
convert2video TikZlingsAbbey "TikZlings Abbey"
convert2video Lumberjack "Lumberjack"
repeatconvert credits "./extravaganza-credits.pdf" 150
