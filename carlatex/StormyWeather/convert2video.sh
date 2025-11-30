# clean up old video
rm StormyWeather.mp4

# convert to png images
pdftoppm -png -r 48 -progress -singlefile -f 10 StormyWeather.pdf StormyWeather
pdftoppm -png -r 240 -progress StormyWeather.pdf StormyWeather

# convert to video
ffmpeg \
  -ss 00:00:00 -i StormyWeather-%03d.png \
  -ss 00:00:23 -i Richard_Wagner_-_Der_Walkurenritt_Die_Walkure-neuIlaryRheinKlange-p_MDQzyVFew.m4a \
  -shortest StormyWeather_raw.mp4

# repair video
HandBrakeCLI --crop 0:0:0:0  -i StormyWeather_raw.mp4 -o StormyWeather.mp4

# clean up
if [ -e "StormyWeather.mp4" ]; then
  rm StormyWeather-*.png
  rm StormyWeather_raw.mp4
fi