#!/bin/sh

ICON_FILE=$1
FIRST_LINE=$2
SECOND_LINE=$3
THIRD_LINE=$4
MODIFIED_IMAGE_HEIGTH_PART=0.6

IMAGE_WIDTH=$(identify -format %w ${ICON_FILE})
IMAGE_HEIGHT=$(identify -format %h ${ICON_FILE})
MODIFIED_IMAGE_HEIGTH=$(echo ${IMAGE_HEIGHT}*${MODIFIED_IMAGE_HEIGTH_PART} | bc)
GRAY_AREA_SIZE="${IMAGE_WIDTH}x${MODIFIED_IMAGE_HEIGTH}"

echo "Modifying: ${ICON_FILE} ${IMAGE_WIDTH} ${IMAGE_HEIGHT} ${GRAY_AREA_SIZE}"

convert \
    -background '#0008' \
    -fill white \
    -gravity center \
    -size "${GRAY_AREA_SIZE}" caption:"${FIRST_LINE}\n${SECOND_LINE}\n${THIRD_LINE}" "${ICON_FILE}" \
    +swap \
    -gravity south \
    -colorspace RGB \
    -composite ${ICON_FILE}