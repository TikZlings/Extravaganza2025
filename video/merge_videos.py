################################################################################
#
# stitching together the videos with transitions
# call with ` ~/.virtualenvs/bin/python3 merge_videos.py`
# 
################################################################################
from moviepy.editor import *
import os

# duration of the transitions between the videos
padding = 1.5

# change volume VideoFileClip("../example-scene/Example.mp4").volumex(1.0),
video_clips = [
  VideoFileClip("../intermissions/title.mp4"),
  VideoFileClip("../intermissions/mirage.mp4"),
  VideoFileClip("../carlatex/mirage/mirage.mp4"), 
  VideoFileClip("../intermissions/Lumberjack.mp4"),
  VideoFileClip("../carlatex/Lumberjack/Lumberjack.mp4"),
  VideoFileClip("../intermissions/StormyWeather.mp4"),
  VideoFileClip("../carlatex/StormyWeather/StormyWeather.mp4"),
  VideoFileClip("../intermissions/flower-field.mp4"),
  VideoFileClip("../paulo/flower-field/flower-field.mp4"),
  VideoFileClip("../intermissions/Avignon.mp4"),
  VideoFileClip("../samcarter/Avignon/Avignon.mp4"),
  VideoFileClip("../intermissions/cheese.mp4"),
  VideoFileClip("../samcarter/cheese/cheese.mp4"),
  VideoFileClip("../intermissions/dinner.mp4"),
  VideoFileClip("../samcarter/dinner/dinner.mp4"),
  VideoFileClip("../intermissions/TikZlingsAbbey.mp4"),
  VideoFileClip("../samcarter/TikZlingsAbbey/TikZlingsAbbey.mp4"),
  VideoFileClip("../intermissions/globe.mp4"),
  VideoFileClip("../samcarter/globe/globe.mp4"),
  VideoFileClip("../intermissions/finale.mp4"),
  VideoFileClip("../ulrike/finale/finale.mp4"),
  VideoFileClip("../intermissions/credits.mp4"),
]

################################################################################
#
# merge title and first intermission to get continious audio
#
################################################################################

video_fx_list = []
idx = 0
for video in video_clips[0:2]:
    video_fx_list.append(video.set_start(idx).crossfadein(padding).crossfadeout(padding).audio_fadein(padding).audio_fadeout(padding))
    idx += video.duration - padding

merged_video = CompositeVideoClip(video_fx_list)
duration = merged_video.end

audioclip = AudioFileClip("../intermissions/christmas-music-box-music.m4a").subclip(2,duration+2)
merged_video = merged_video.set_audio(audioclip)

################################################################################
#
# adding rest of the scenes
#
################################################################################

video_fx_list = []
idx = 0

# adding the merged video first
video_fx_list.append(merged_video.set_start(idx).crossfadein(padding).crossfadeout(padding).audio_fadein(padding).audio_fadeout(padding))
idx += merged_video.duration - padding

# rest of the videos
for video in video_clips[2:]:
    video_fx_list.append(video.set_start(idx).crossfadein(padding).crossfadeout(padding).audio_fadein(padding).audio_fadeout(padding))
    idx += video.duration - padding

final_video = CompositeVideoClip(video_fx_list)
final_video.write_videofile("Extravaganza_raw.mp4") 

os.system("HandBrakeCLI --crop 0:0:0:0 -i Extravaganza_raw.mp4 -o Extravaganza.mp4") 
os.system("rm Extravaganza_raw.mp4")