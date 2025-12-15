# clean up old video
rm Lumberjack.mp4

# convert to images
pdftoppm -png -r 48 -progress -singlefile -f 173 Lumberjack.pdf Lumberjack
pdftoppm -r 240 -progress Lumberjack.pdf Lumberjack

# convert to video
ffmpeg \
  -ss 00:00:00 -i Lumberjack-%03d.ppm \
  -ss 00:00:24 -i Monty_Python_-_Lumberjack_Song-Oduncu_Gomle_i-FshU58nI0Ts.m4a \
  -shortest Lumberjack_raw.mp4

# repair video
HandBrakeCLI --crop 0:0:0:0  -i Lumberjack_raw.mp4 -o Lumberjack.mp4

# clean up
if [ -e "Lumberjack.mp4" ]; then
  rm Lumberjack-*.ppm
  rm Lumberjack_raw.mp4
fi