#!/bin/sh

ICON_FILE="$1"
FIRST_LINE="$2"
SECOND_LINE="$3"
THIRD_LINE="$4"
ICON_PATH="$5"
MODIFIED_IMAGE_HEIGTH_PART=0.6

IMAGE_WIDTH=$(identify -format %w "${ICON_FILE}")
IMAGE_HEIGHT=$(identify -format %h "${ICON_FILE}")
MODIFIED_IMAGE_HEIGTH=$(echo ${IMAGE_HEIGHT}*${MODIFIED_IMAGE_HEIGTH_PART} | bc)
GRAY_AREA_SIZE="${IMAGE_WIDTH}x${MODIFIED_IMAGE_HEIGTH}"

convertFile() {
    file="$1"
    convert \
        -background '#0008' \
        -fill white \
        -gravity center \
        -size "${GRAY_AREA_SIZE}" caption:"${FIRST_LINE}\n${SECOND_LINE}\n${THIRD_LINE}" "${file}" \
        +swap \
        -gravity south \
        -colorspace RGB \
        -composite "${file}"
}

# If path is not given, modify a single file
if [ -z ${ICON_PATH} ]; then
    echo "Modifying: ${ICON_FILE} ${IMAGE_WIDTH} ${IMAGE_HEIGHT} ${GRAY_AREA_SIZE}"
    convertFile "${ICON_FILE}"
    
#otherwise modifly all .png's from given path
else
    if [[ -d ${ICON_PATH} ]]; then
        for file in ${ICON_PATH}/*
        do
            if [[ ${file: -4} == ".png" ]]; then
                echo "Modifying: ${file} ${IMAGE_WIDTH} ${IMAGE_HEIGHT} ${GRAY_AREA_SIZE}"
                convertFile "${file}"
            fi
        done
    fi
fi