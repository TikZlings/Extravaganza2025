# clean up old video
rm silentnight.mp4

# convert to png images
pdftoppm -png -r 48 -progress -singlefile -f 10 silentnight.pdf silentnight
pdftoppm -png -r 240 -progress silentnight.pdf silentnight

# convert to video
ffmpeg \
  -ss 00:00:00 -i silentnight-%03d.png \
  -ss 00:00:08 -i Silent_Night......The_Christmas_---_Myer_Levin_Advanced_Steel_Band-WSTglobalHD-IaeVqF05nTg.m4a \
  -shortest silentnight_raw.mp4

# repair video
HandBrakeCLI --crop 0:0:0:0  -i silentnight_raw.mp4 -o silentnight.mp4

# clean up
if [ -e "silentnight.mp4" ]; then
  rm silentnight-*.png
  rm silentnight_raw.mp4
fi