# clean up old video
rm example.mp4

# convert to images
pdftoppm -png -r 48 -progress -singlefile -f 10 example.pdf example
pdftoppm -r 240 -progress example.pdf example

# convert to video
ffmpeg \
  -ss 00:00:00 -i example-%03d.ppm \
  -ss 00:00:10 -i Music.m4a \
  -shortest example_raw.mp4

# repair video
HandBrakeCLI --crop 0:0:0:0  -i example_raw.mp4 -o example.mp4

# clean up
if [ -e "example.mp4" ]; then
  rm example-*.ppm
  rm example_raw.mp4
fi