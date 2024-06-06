#!/bin/bash

# SCRIPT USAGE
if [ "$#" -ne 1 ]; then
    echo "Usage:     $0 FILENAME"
    exit 1
fi

# GENERAL INITIALIZATION
PDF_FILE="$1"
PREFIX="exported"
KEY=$RANDOM

About_Dialogue() {
    yad --about \
  --image=gtk-about \
  --license="GPL3" \
  --comments="A simple GUI to organize and display the output of PDF tools" \
  --copyright="(c) 2024 Troy E. Spier, Ph.D." \
  --pversion="v0.1" \
  --pname="SimplePDFAnalyzer"
}

export -f About_Dialogue

# RETRIEVES AND CLEANS THE OUTPUT FROM PDFINFO
# BY ORGANIZING IT INTO APPROPRIATE KEY-VALUE PAIRS
yad --plug=$KEY --tabnum=1 --list --no-click --no-selection --column="Key" --column="Value" \
    < <(pdfinfo "$PDF_FILE" | sed -r "s/:[ ]*/\n/") &

# RETRIEVES AND CLEANS THE OUTPUT FROM EXIFTOOL
# BY ORGANIZING IT INTO APPROPRIATE KEY-VALUE PAIRS
yad --plug=$KEY --tabnum=2 --list --no-click --no-selection --column="Key" --column="Value" \
    < <(exiftool "$PDF_FILE" | sed -r "s/:[ ]*/\n/") &

# RETRIEVES AND CLEANS THE OUTPUT FROM PDFIMAGES
# BY ORGANIZING IT INTO SIXTEEN COLUMNS CORRESPONDING
# TO THE DETAILS RETURNED
yad --plug=$KEY --tabnum=3 --list --no-click --no-selection  --column="Page" --column="Number" --column="Type" \
    --column="Width" --column="Height" --column="Color" --column="Color Components" --column="Bits Per Component" --column="Encoding" \
    --column="Interpolation" --column="Object ID" --column="X-PPI" --column="Y-PPI" --column="Size" \
    --column="Ratio" --column="Raw Data" \
    < <(pdfimages -list "$PDF_FILE" | \
    awk 'NR>2 {
            printf "%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n", $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16
        }') &

# RETRIEVES AND CLEANS THE OUTPUT FROM PDFFONTS
# BY ORGANIZING IT INTO SEVEN COLUMNS CORRESPONDING
# TO THE DETAILS RETURNED
yad --plug=$KEY --tabnum=4 --list --no-click --no-selection --column="Name" --column="Type" --column="Encoding" \
    --column="Embedded" --column="Subset" --column="Unicode" --column="Object ID" \
    < <(pdffonts "$PDF_FILE" | \
    awk 'NR>2 {
            printf "%s\n%s\n%s\n%s\n%s\n%s\n%s\n", $1, $2, $3, $4, $5, $6, $7
        }') &

# RETRIEVES THE OUTPUT FROM PDFTOTEXT AND SAVES
# TO A TEMPORARY FILE TO BE DELETED UPON CLOSING
pdftotext "$PDF_FILE" - > "pdftext.txt"
yad --plug=$KEY --tabnum=5 --text-info --wrap --margins=10 --show-cursor --show-uri --uri-color=red --filename="pdftext.txt" &

# BUILDS AND DISPLAYS THE GUI WITH FUNCTIONS TO EXPORT
# UPON CLICKING THE RELEVANT BUTTONS, A FOLDER IS CREATED,
# IF IT DOES NOT ALREADY EXIST, TO HOUSE THE EXPORTED
# INFORMATION.
yad --notebook --width=1000 --height=700 --title="Simple PDF Analyzer" --button="Export Information:bash -c 'mkdir -p exported \
    && cd exported && pdfinfo \"$PDF_FILE\" > basic_info.txt && exiftool \"$PDF_FILE\" > detailed_info.txt \
    && pdfimages -list \"$PDF_FILE\" > image_info.txt && pdffonts \"$PDF_FILE\" > font_info.txt'" \
    --button="Export Images:bash -c 'mkdir -p exported && cd exported && pdfimages -all \"$PDF_FILE\" $PREFIX'" \
    --button="Export Contents:bash -c 'mkdir -p exported && cd exported && pdftotext \"$PDF_FILE\" contents.txt'" --button="About:bash -c About_Dialogue" --button="Close":1 \
    --key=$KEY --tab="Basic Info" --tab="Detailed Info" --tab="Image Info" --tab="Font Info" --tab="File Contents"

# THIS REMOVES THE TEMPORARY FILE CREATED EARLIER
# FOR THE PDFTOTEXT CONTENTS TO BE DISPLAYED
# BECAUSE USERS MIGHT NOT WANT TO EXPORT THE CONTENTS
rm pdftext.txt
