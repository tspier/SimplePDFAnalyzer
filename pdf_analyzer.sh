#!/bin/bash

# SCRIPT USAGE
if [ "$#" -ne 1 ]; then
    echo "Usage:     $0 FILENAME"
    exit 1
fi

PDF_FILE="$1"
DIRECTORY="exported"
KEY=$RANDOM

export_info() {
    echo "HELLO";
}

# RETRIEVES AND CLEANS THE OUTPUT FROM PDFINFO
yad --plug=$KEY --tabnum=1 --list --no-click --no-selection --column="Key" --column="Value" \
    < <(pdfinfo "$PDF_FILE" | sed -r "s/:[ ]*/\n/") &

# RETRIEVES AND CLEANS THE OUTPUT FROM EXIFTOOL
yad --plug=$KEY --tabnum=2 --list --no-click --no-selection --column="Key" --column="Value" \
    < <(exiftool "$PDF_FILE" | sed -r "s/:[ ]*/\n/") &

# RETRIEVES AND CLEANS THE OUTPUT FROM PDFIMAGES
yad --plug=$KEY --tabnum=3 --list --no-click --no-selection  --column="Page" --column="Num" --column="Type" \
    --column="Width" --column="Height" --column="Color" --column="Color Components" --column="Bits Per Component" --column="Encoding" \
    --column="Interpolation" --column="Object ID" --column="X-PPI" --column="Y-PPI" --column="Size" \
    --column="Ratio" --column="Raw Data" \
    < <(pdfimages -list "$PDF_FILE" | \
    awk 'NR>2 {
            printf "%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n", $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16
        }') &

# RETRIEVES AND CLEANS THE OUTPUT FROM PDFFONTS
yad --plug=$KEY --tabnum=4 --list --no-click --no-selection --column="Name" --column="Type" --column="Encoding" \
    --column="Embedded" --column="Subset" --column="Unicode" --column="Object ID" \
    < <(pdffonts "$PDF_FILE" | \
    awk 'NR>2 {
            printf "%s\n%s\n%s\n%s\n%s\n%s\n%s\n", $1, $2, $3, $4, $5, $6, $7
        }') &

# BUILDS AND DISPLAYS THE GUI WITH FUNCTIONS TO EXPORT
yad --notebook --width=1000 --height=700 --title="Simple PDF Analyzer" --button="Export Information:bash -c 'mkdir -p exported \
    && cd exported && pdfinfo \"$PDF_FILE\" > basic_info.txt && exiftool \"$PDF_FILE\" > detailed_info.txt \
    && pdfimages -list \"$PDF_FILE\" > image_info.txt && pdffonts \"$PDF_FILE\" > font_info.txt'" \
    --button="Export Images:bash -c 'mkdir -p exported && cd exported && pdfimages -all \"$PDF_FILE\" $DIRECTORY'" --button="Close":1 \
    --key=$KEY --tab="Basic Info" --tab="Detailed Info" --tab="Image Info" --tab="Font Info"