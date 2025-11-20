# clean up old video
rm cheese.mp4

# convert to png images
pdftoppm -png -r 48 -progress -singlefile -f 10 cheese.pdf cheese
pdftoppm -png -r 240 -progress cheese.pdf cheese

# convert to video
ffmpeg \
  -ss 00:00:00 -i cheese-%03d.png \
  -ss 00:00:50 -i Eurythmics_Annie_Lennox_Dave_Stewart_-_Sweet_Dreams_Are_Made_Of_This_Lyrics-Aura_Melodies-IRr_CfNbBpA.m4a \
  -shortest cheese_raw.mp4

# repair video
HandBrakeCLI --crop 0:0:0:0  -i cheese_raw.mp4 -o cheese.mp4

# clean up
if [ -e "cheese.mp4" ]; then
  rm cheese-*.png
  rm cheese_raw.mp4
fi