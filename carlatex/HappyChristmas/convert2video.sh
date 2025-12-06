# clean up old video
rm HappyChristmas.mp4

# convert to png images
pdftoppm -png -r 48 -progress -singlefile -f 265 HappyChristmas.pdf HappyChristmas
pdftoppm -png -r 240 -progress HappyChristmas.pdf HappyChristmas

# convert to video
ffmpeg \
  -ss 00:00:00 -i HappyChristmas-%03d.png \
  -ss 00:00:18 -i Henry_Mancini_His_Orchestra_-_Baby_Elephant_Walk_Official_Audio-Henry_Mancini-EbI2nl3Duf8.m4a \
  -shortest HappyChristmas_raw.mp4

# repair video
HandBrakeCLI --crop 0:0:0:0  -i HappyChristmas_raw.mp4 -o HappyChristmas.mp4

# clean up
if [ -e "HappyChristmas.mp4" ]; then
  rm HappyChristmas-*.png
  rm HappyChristmas_raw.mp4
fi