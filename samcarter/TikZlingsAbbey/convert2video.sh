# clean up old video
rm TikZlingsAbbey.mp4

# convert to png images
pdftoppm -png -r 48 -progress -singlefile -f 10 TikZlingsAbbey.pdf TikZlingsAbbey
pdftoppm -png -r 240 -progress TikZlingsAbbey.pdf TikZlingsAbbey

# convert to video
ffmpeg \
  -ss 00:00:00 -i TikZlingsAbbey-%03d.png \
  -ss 00:00:00 -i Downton_Abbey_Main_Theme-Jessie_Conran-j3_E9qVmrV0.m4a \
  -shortest TikZlingsAbbey_raw.mp4

# repair video
HandBrakeCLI --crop 0:0:0:0  -i TikZlingsAbbey_raw.mp4 -o TikZlingsAbbey.mp4

# clean up
if [ -e "TikZlingsAbbey.mp4" ]; then
  rm TikZlingsAbbey-*.png
  rm TikZlingsAbbey_raw.mp4
fi