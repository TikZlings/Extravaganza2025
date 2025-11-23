# clean up old video
rm Avignon.mp4

# convert to png images
pdftoppm -png -r 48 -progress -singlefile -f 10 Avignon.pdf Avignon
pdftoppm -png -r 240 -progress Avignon.pdf Avignon

# convert to video
ffmpeg \
  -ss 00:00:00 -i Avignon-%03d.png \
  -ss 00:00:10 -i Music.m4a \
  -shortest Sur_le_pont_d_Avignon-Comptines_et_chansons-uJKfxtYAt0s.m4a

# repair video
HandBrakeCLI --crop 0:0:0:0  -i Avignon_raw.mp4 -o Avignon.mp4

# clean up
if [ -e "Avignon.mp4" ]; then
  rm Avignon-*.png
  rm Avignon_raw.mp4
fi