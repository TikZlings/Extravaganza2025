# clean up old video
rm TikZlingsAbbey.mp4

# convert to images
pdftoppm -png -r 48 -progress -singlefile -f 253 TikZlingsAbbey.pdf TikZlingsAbbey
pdftoppm -r 240 -progress TikZlingsAbbey.pdf TikZlingsAbbey

# convert to video
ffmpeg \
  -ss 00:00:00 -i TikZlingsAbbey-%03d.ppm \
  -ss 00:00:00 -i Downton_Abbey_Main_Theme-Jessie_Conran-j3_E9qVmrV0.m4a \
  -shortest TikZlingsAbbey_raw.mp4

# repair video
HandBrakeCLI --crop 0:0:0:0  -i TikZlingsAbbey_raw.mp4 -o TikZlingsAbbey.mp4

# clean up
if [ -e "TikZlingsAbbey.mp4" ]; then
  rm TikZlingsAbbey-*.ppm
  rm TikZlingsAbbey_raw.mp4
fi