#!/bin/bash
## Example: ./add-stamp-background-to-pdf.sh doc.pdf test@example.com

src_pdf=${1?provide path of pdf}
target_pdf=$(echo "$src_pdf" | sed 's/.pdf/-stamped.pdf/')
stamp_text=${2?provide stamp text}
stamp_file="stamp-$RANDOM.pdf"

./create-stamp-pdf.sh "$stamp_text" > "$stamp_file"

pdftk "$src_pdf" stamp "$stamp_file" output "$target_pdf"

rm "$stamp_file"
