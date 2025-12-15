# clean up old video
rm commercial.mp4

# convert to png images
pdftoppm -png -r 48 -progress -singlefile -f 292 commercial_repeat.pdf commercial
pdftoppm -png -r 240 -progress commercial_repeat.pdf commercial

# convert to video
ffmpeg \
  -ss 00:00:00 -i commercial-%03d.png \
  -ss 00:00:20.37640 -i O_Canada_Canadian_National_Anthem_Beautiful_Choir_with_Piano_Updated_Lyrics-Sunday_7pm_Choir_Catholic_Christian_Choral_Music-XfBLfHV8sdQ.m4a \
  -shortest commercial_raw.mp4

# repair video
HandBrakeCLI --crop 0:0:0:0  -i commercial_raw.mp4 -o commercial.mp4

# clean up
if [ -e "commercial.mp4" ]; then
  rm commercial-*.png
  rm commercial_raw.mp4
fi