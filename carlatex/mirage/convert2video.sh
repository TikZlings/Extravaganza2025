# clean up old video
rm Mirage.mp4

# convert to images
pdftoppm -png -r 48 -progress -singlefile -f 265 Mirage.pdf Mirage
pdftoppm -r 240 -progress Mirage.pdf Mirage

# convert to video
ffmpeg \
  -ss 00:00:00 -i Mirage-%03d.ppm \
  -ss 00:00:22 -i Singin_in_the_Rain_Gene_Kelly_Sings_Singin_in_the_Rain_Warner_Bros._Entertainment-Warner_Bros._Entertainment-gAI6hhsDNxc.m4a \
  -shortest Mirage_raw.mp4

# repair video
HandBrakeCLI --crop 0:0:0:0  -i Mirage_raw.mp4 -o Mirage.mp4

# clean up
if [ -e "Mirage.mp4" ]; then
  rm Mirage-*.ppm
  rm Mirage_raw.mp4
fi