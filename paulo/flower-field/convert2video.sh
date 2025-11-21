# clean up old video
rm flower-field.mp4

# convert to png images
pdftoppm -png -r 48 -progress -singlefile -f 10 flower-field.pdf flower-field
pdftoppm -png -r 240 -progress flower-field.pdf flower-field

# convert to video
ffmpeg \
  -ss 00:00:00 -i flower-field-%03d.png \
  -ss 00:00:08 -i Where_Have_All_The_Flowers_Gone_-_With_Lyrics_-_Pete_Seeger-MR_BING_DIY-JANHG_OYbso.m4a \
  -shortest flower-field_raw.mp4

# repair video
HandBrakeCLI --crop 0:0:0:0  -i flower-field_raw.mp4 -o flower-field.mp4

# clean up
if [ -e "flower-field.mp4" ]; then
  rm flower-field-*.png
  rm flower-field_raw.mp4
fi