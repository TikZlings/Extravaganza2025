# clean up old video
rm nhl.mp4

# convert to images
pdftoppm -png -r 48 -progress -singlefile -f 10 nhl_repeat.pdf nhl
pdftoppm -r 240 -progress nhl_repeat.pdf nhl

# convert to video
ffmpeg \
  -ss 00:00:00 -i nhl-%03d.ppm \
  -ss 00:00:05 -i Andre_Rieu_SNOW_WALTZ_Schneewalzer-Maria_Lindig-r4ugf3FTCj4.m4a \
  -shortest nhl_raw.mp4

# repair video
HandBrakeCLI --crop 0:0:0:0  -i nhl_raw.mp4 -o nhl.mp4

# clean up
if [ -e "nhl.mp4" ]; then
  rm nhl-*.ppm
  rm nhl_raw.mp4
fi