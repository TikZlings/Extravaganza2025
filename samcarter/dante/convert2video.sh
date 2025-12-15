# clean up old video
rm dante.mp4

# convert to images
pdftoppm -png -r 48 -progress -singlefile -f 297 dante.pdf dante
pdftoppm -r 240 -progress dante.pdf dante

# convert to video
ffmpeg \
  -ss 00:00:00 -i dante-%03d.ppm \
  -ss 00:00:37 -i Pierre_Attaingnant_Basse_danse_La_Magdalena-Thomas_Turner-UF1MwE7Knfs.m4a \
  -shortest dante_raw.mp4

# repair video
HandBrakeCLI --crop 0:0:0:0  -i dante_raw.mp4 -o dante.mp4

# clean up
if [ -e "dante.mp4" ]; then
  rm dante-*.ppm
  rm dante_raw.mp4
fi