# clean up old video
rm globe.mp4

# convert to png images
pdftoppm -png -r 48 -progress -singlefile -f 10 globe.pdf globe
pdftoppm -png -r 240 -progress globe.pdf globe

# convert to video
ffmpeg \
  -ss 00:00:00 -i globe-%03d.png \
  -ss 00:00:00 -i Benedict_Cumberbatch_-_All_The_World_s_A_Stage_-_The_Seven_Ages_Of_Man_-_Solo_-_Subtitles_-_4K-Shakespeare_Network-0178jo7Mka0.m4a \
  -shortest globe_raw.mp4

# repair video
HandBrakeCLI --crop 0:0:0:0  -i globe_raw.mp4 -o globe.mp4

# clean up
if [ -e "globe.mp4" ]; then
  rm globe-*.png
  rm globe_raw.mp4
fi