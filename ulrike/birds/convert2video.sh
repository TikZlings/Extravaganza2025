# clean up old video
rm birds.mp4

# convert to png images
pdftoppm -png -r 48 -progress -singlefile -f 336 birds.pdf birds
pdftoppm -png -r 240 -progress birds_repeat.pdf birds

# convert to video
ffmpeg \
  -ss 00:00:00 -i birds-%03d.png \
  -ss 00:01:17 -i The_Birds_children_singing-Sian_Film_Teacher-JOGC3sNJJxs.m4a \
  -shortest birds_raw.mp4

# repair video
HandBrakeCLI --crop 0:0:0:0  -i birds_raw.mp4 -o birds.mp4

# clean up
if [ -e "birds.mp4" ]; then
  rm birds-*.png
  rm birds_raw.mp4
fi