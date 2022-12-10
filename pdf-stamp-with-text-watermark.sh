#!/bin/bash

##################################################################################
# Stamps PDF with text watermark. 
# Usage: Stamp private documents with recipient e-mail, so in case of leak you find out the source.  
# Example: ./{script-name} private-doc.pdf test@example.com
##################################################################################

src_pdf=${1?provide path of pdf}
target_pdf=$(echo "$src_pdf" | sed 's/.pdf/-stamped.pdf/')
stamp_text=${2?provide stamp text}
stamp_file="stamp-$RANDOM.pdf"

./_create-text-watermark-in-pdf-format.sh "$stamp_text" > "$stamp_file"

pdftk "$src_pdf" stamp "$stamp_file" output "$target_pdf"

rm "$stamp_file"
