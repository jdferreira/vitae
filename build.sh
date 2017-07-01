#!/usr/bin/env bash

if [ -z "$1" ]; then
    NAME="main.tex"
else
    NAME="$1"
fi
NAME="${NAME%%.tex}"

BIB_SOURCE="$HOME/Dropbox/BibTeX/BibTeX collections-My Publications.bib"
BIB_TARGET="content/references.bib"
MAIN_TEX="$NAME.tex"
OUT_PDF="out/$NAME.pdf"

if [ ! -f "$BIB_TARGET" -o "$BIB_SOURCE" -nt "$BIB_TARGET" ]; then
    echo "Copying .bib file"
    python3 correct_bib.py "$BIB_SOURCE" "$BIB_TARGET"
    # cp "$BIB_TARGET" "$(dirname "$OUT_PDF")"
fi

echo "Compiling $MAIN_TEX"
latexmk "$MAIN_TEX" && cp "$OUT_PDF" .
