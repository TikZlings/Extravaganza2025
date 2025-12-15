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
tex_width := $(shell echo "$$(( $(width) / $(tex_scale) ))")
tex_height := $(shell echo "$$(( $(height) / $(tex_scale) ))")
dpi := $(shell echo "$$(( $(tex_scale) * 72 ))")

# Rules
icons.pdf: icons.tex
	lualatex "$<"

commercial.pdf: commercial.cld icons.pdf
	context --forcecld --once \
		"$<" \
		--frame-rate=${frame_rate} \
		--width=${tex_width} \
		--height=${tex_height} || ( \
			rm $@ 2>/dev/null || true; \
			exit 1; \
		)

.DEFAULT_GOAL := commercial.mp4
commercial.mp4: commercial.pdf commercial.m4a
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
		-i commercial.m4a \
		-shortest \
		-c:a copy \
		-c:v hevc_vaapi -vf "format=nv12,hwupload" \
		-movflags +faststart \
		"$@"
