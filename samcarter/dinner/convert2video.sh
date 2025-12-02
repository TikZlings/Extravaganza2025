# clean up old video
rm dinner.mp4

# convert to png images
pdftoppm -png -r 48 -progress -singlefile -f 10 dinner.pdf dinner
pdftoppm -png -r 240 -progress dinner.pdf dinner

# convert to video
ffmpeg \
  -ss 00:00:00 -i dinner-%03d.png \
  -ss 00:01:40 -i My_Way_2008_Remastered-Frank_Sinatra-qQzdAsjWGPg.m4a \
  -shortest dinner_raw.mp4

# repair video
HandBrakeCLI --crop 0:0:0:0  -i dinner_raw.mp4 -o dinner.mp4

# clean up
if [ -e "dinner.mp4" ]; then
  rm dinner-*.png
  rm dinner_raw.mp4
fi