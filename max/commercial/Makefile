# Settings
.SUFFIXES:
.SILENT:
.ONESHELL:
SHELL := bash
.SHELLFLAGS := -eu -o pipefail -c
MAKEFLAGS += --no-builtin-rules

# Variables
frame_rate := 25
width := 1920
height := 1080
tex_scale := 12

# Derived variables
tex_width := $(shell echo "${width} / ${tex_scale}" | bc --mathlib)
tex_height := $(shell echo "${height} / ${tex_scale}" | bc --mathlib)
dpi := $(shell echo "${tex_scale} * 72" | bc --mathlib)

# Rules
icons.pdf: icons.tex
	lualatex "$<"

background.jpg:
	wget --output-document="$@" \
		"https://pixabay.com/get/g09e63518b557fcaadd5bf5f19c37ae4e6026aac4ac1c5f4d3b69576a38115c491247fd91227b61b46345c30af47fba02373e7b4f9dea39e8e12f58e0902e22030263eb049e1f84e78ba2e557c85d1f98_1920.jpg"

music.m4a:
	yt-dlp --preset-alias=aac --output="$@" \
		"https://www.youtube.com/watch?v=XfBLfHV8sdQ"
	mv "$@" temp.m4a
	ffmpeg \
		-hide_banner -loglevel error \
		-y \
		-ss 00:20.0000 -i "temp.m4a" -ss 0 \
		-c copy \
		-to 01:12.8764 \
		-avoid_negative_ts make_zero \
		"$@"
	rm temp.m4a

commercial.pdf: commercial.cld icons.pdf background.jpg
	context --forcecld --once \
		"$<" \
		--frame-rate=${frame_rate} \
		--width=${tex_width} \
		--height=${tex_height} || ( \
			rm $@ 2>/dev/null || true; \
			exit 1; \
		)

.DEFAULT_GOAL := commercial.mp4
commercial.mp4: commercial.pdf music.m4a
	temp_dir=$$(mktemp -d)
	trap 'rm -rf "$$temp_dir"' EXIT

	pages=$$(pdfinfo "$<" | grep '^Pages:' | awk '{print $$2}')
	parallel "pdftoppm -r ${dpi} -f {1} -l {= \$$_+=10 =} $< '$$temp_dir/out'" \
		::: $$(seq 1 10 $$pages)

	DRI_PRIME=1 ffmpeg \
		-hide_banner -loglevel error \
		-y \
		-hwaccel vaapi \
		-framerate ${frame_rate} \
		-i "$$temp_dir/out-%03d.ppm" \
		-i music.m4a \
		-shortest \
		-c:a copy \
		-c:v h264_vaapi -vf "format=nv12,hwupload" \
		-movflags +faststart \
		"$@"
