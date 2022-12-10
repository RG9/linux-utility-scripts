#!/bin/bash

_create-text-watermark-in-pdf-format

##################################################################################
# Creates empty PDF with text watermark.
# Usage: Use to stamp other PDFs.
# Example: ./{script-name} "my-email@example.com" > stamp.pdf
##################################################################################

text=${1?provide stamp text, e.g. e-mail address}
angle=30 # in degrees counterclockwise from horizontal
grey=0.9 # 0 is black 1 is white

ps2pdf - - <<!
%!PS
/cm { 28.4 mul } bind def
/draft-Bigfont /Helvetica-Bold findfont 12 scalefont def
/draft-copy {
        gsave initgraphics $grey setgray
        17 cm 1 cm moveto
        $angle rotate
        draft-Bigfont setfont
        ($text) show grestore
 } def
draft-copy showpage
!
