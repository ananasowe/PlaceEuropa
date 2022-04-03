#!/bin/bash
# contact: patrolez

#
# requires 'imagemagic'
# In Ubuntu/Debian:
#     sudo apt-get install imagemagick-6.q16
#

TIMEOUT=20s
TIMEFORMAT=' Took %3lR'

COLORMAP_PNG='data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAApsAAAA3CAMAAAB0DXHqAAAABGdBTUEAALGPC/xhBQAAAAFzUkdCAdnJLH8AAAAgY0hSTQAAeiYAAICEAAD6AAAAgOgAAHUwAADqYAAAOpgAABdwnLpRPAAAAEtQTFRFAAAAAAAAAHVvAJ6qAKNoAMx4JFCkNpDqSTrBUen0alz/bUgvfu1WgR6fiY2QnGkmtErAvgA51NfZ/ziB/0UA/5mq/6gA/9Y1////7YWiNAAAAAF0Uk5TAEDm2GYAAAC3SURBVHja7dUxDoJQFERR8lXUoAESIvvfJIQG7Kz9U1Gcs4V3M6+MNabQJzWnrqFb6pUqoUuqTd1DzyrNT2ngnLSJNkGbaBO0iTZBm6BNtAnaRJugTdAm2gRtok3QJmgTbYI20SZoE22CNuGvNtcaS2hNbak+NKSO1Du0px6pLlR3AbuJnw7aRJugTbQJ2gRtok3QJtoEbYI20SZoE22CNkGbaBO0iTZBm6BNtAnaRJugTbQJ5/EFqJdtslLIGtgAAAAASUVORK5CYII='

function rplace_spread()
(
	local SUFFIX="-spre"

	set -euE
	in_file="$1"
	local extension="${in_file##*.}"
	local filepath_without_ext="${in_file%.*}"
	out_name="${filepath_without_ext}${SUFFIX}.${extension}"

	touch -a "${out_name}"
	print_status "$?" '%.0sCreated "%s" file!\n'

	printf 'Processing - inflating; src: %s\n' "${in_file}"
	time timeout --foreground -k 0 "$TIMEOUT" convert "$in_file" -background transparent \
			-gravity NorthWest -crop 1x0 +repage -splice 1x0 -gravity east -splice 1x0 +append \
			-gravity NorthWest -crop 0x1 +repage -splice 0x1 -gravity south -splice 0x1 -append \
			"${out_name}"
	print_status "$?"
)


function rplace_pack()
(
	local SUFFIX="-pack"

	set -euE
	in_file="$1"
	local extension="${in_file##*.}"
	local filepath_without_ext="${in_file%.*}"
	out_name="${filepath_without_ext}${SUFFIX}.${extension}"

	touch -a "${out_name}"
	print_status "$?" '%.0sCreated "%s" file!\n'

	printf 'Processing - pack; src: %s\n' "${in_file}"
	time timeout --foreground -k 0 "$TIMEOUT" convert "$in_file" -background transparent \
			-gravity NorthWest -crop 3x0 +repage -chop 1x0 -gravity east -chop 1x0 +append \
			-gravity NorthWest -crop 0x3 +repage -chop 0x1 -gravity south -chop 0x1 -append \
			"${out_name}"
	print_status "$?"
)

function rplace_approx_to_colormap()
(
	local SUFFIX="-red"

	set -euE
	in_file="$1"
	local extension="${in_file##*.}"
	local filepath_without_ext="${in_file%.*}"
	out_name="${filepath_without_ext}${SUFFIX}.${extension}"

	touch -a "${out_name}"
	print_status "$?" '%.0sCreated "%s" file!\n'

	printf 'Processing - adjusting colors; src: %s\n' "${in_file}"
	convert "$in_file" -dither FloydSteinberg -remap "inline:${COLORMAP_PNG}" "${out_name}"
	print_status "$?"
)

function rplace_render_preview()
(
	local SUFFIX="-prev"

	set -euE
	in_file="$1"
	local extension="${in_file##*.}"
	local filepath_without_ext="${in_file%.*}"
	out_name="${filepath_without_ext}${SUFFIX}.${extension}"

	touch -a "${out_name}"
	print_status "$?" '%.0sCreated "%s" file!\n'

	printf 'Processing - producing preview; src: %s\n' "${in_file}"
	convert -bordercolor white -compose Copy -border 2 "${filepath_without_ext%-*}"* -background transparent +append "${out_name}"
	print_status "$?"
)

function print_status()
{
	local OK_MSG=${2:-'Done:\n src: %s\n dst: %s\n'}
	local ERR_MSG=${3:-'Error!\n'}
	case "$1" in
		0   ) printf "$OK_MSG" "${in_file}" "${out_name}"; return ;;
		124 ) printf 'Timeout! Exceeded %s\n' "$TIMEOUT"; return ;;
		*   ) printf "$ERR_MSG" "${in_file}" "${out_name}"; return ;;
	esac
}

USAGE=$(cat <<-EOF
	USAGE:
	  To expand/spread/inflate/gap image:
	      "$0" --spread <file_path>
	    OR
	      "$0" -s <file_path>

	  To pack (remove gaps) from image:
	      "$0" --pack <file_path>
	    OR
	      "$0" -p <file_path>

	Requires 'imagemagic'
	In Ubuntu/Debian:
	    sudo apt-get install imagemagick-6.q16
EOF
)

function main()
{
	ARGS=( "$@" )
	while true; do
		if [ "$#" -eq 0 ]; then break; fi
		case "$1" in
			-h | --help ) echo "$USAGE"; exit ;;
		esac
		shift
	done

	set -- "${ARGS[@]}"
	while true; do
		case "$1" in
			-s | --spread ) { rplace_spread "$2"; }; break ;;
			-p | --pack )   { rplace_pack "$2"; }; break ;;
			* ) echo "$USAGE"; break ;;
		esac
	done
}

if ! (return 0 2>/dev/null)
then
	main "$@"
else
	echo '[OK] Sourced. Type "rplace_" for auto-completion'
fi


