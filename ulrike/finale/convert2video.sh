# clean up old video
rm finale.mp4

# convert to png images
pdftoppm -png -r 48 -progress -singlefile -f 68 finale.pdf finale
pdftoppm -png -r 240 -progress finale.pdf finale

# convert to video
ffmpeg \
  -ss 00:00:00 -i finale-%03d.png \
  -ss 00:00:45 -i Miguel_Rios_-_A_Song_Of_Joy_1970_4K_UHD-Music_Butler_Channel-D2MqD3FEjcs.m4a \
  -shortest finale_raw.mp4

# repair video
HandBrakeCLI --crop 0:0:0:0  -i finale_raw.mp4 -o finale.mp4

# clean up
if [ -e "finale.mp4" ]; then
  rm finale-*.png
  rm finale_raw.mp4
fi