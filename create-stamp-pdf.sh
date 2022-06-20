#!/bin/bash
## Example: ./create-stamp-pdf.sh "my-email@example.com" > stamp.pdf

text=${1?provide stamp text, e.g. e-mail address}
angle=45 # in degrees counterclockwise from horizontal
grey=0.75 # 0 is black 1 is white

ps2pdf - - <<!
%!PS
/cm { 28.4 mul } bind def
/draft-Bigfont /Helvetica-Bold findfont 42 scalefont def
/draft-copy {
        gsave initgraphics $grey setgray
        5 cm 10 cm moveto
        $angle rotate
        draft-Bigfont setfont
        ($text) show grestore
 } def
draft-copy showpage
!
