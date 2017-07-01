#!/usr/bin/env python3

import sys

PIECES_TO_IGNORE = {
    "abstract", "address", "archivePrefix", "arxivId", "file", "keywords",
    "mendeley-tags", "primaryClass"
}
TEMPLATE_WITH_COMMA    = "  {} = {},"
TEMPLATE_WITHOUT_COMMA = "  {} = {}"

BIBTEX_SOURCE = sys.argv[1]
BIBTEX_TARGET = sys.argv[2]


def correct_url(url):
    url = url.replace(' ', '%20')
    url = url.replace('{\\&}', '&')
    url = url.replace('{\\_}', '_')
    url = url.replace('{~}', '~')
    return url


def get_item(line):
    line = line.strip()
    fields = line.split('{')
    return (fields[0][1:], fields[1].rstrip(','))


def process_current(current, output):
    print("@{}{{{},".format(*current.pop('@')), file=output)
    
    has_doi = "doi" in current
    
    items = sorted(current.items())
    while items:
        piece, value = items.pop(0)
        if piece in PIECES_TO_IGNORE:
            continue
        if piece == "url" and has_doi:
            continue
        
        if items:
            template = TEMPLATE_WITH_COMMA
        else:
            template = TEMPLATE_WITHOUT_COMMA
        print(template.format(piece, value), file=output)
        
    print("}", file=output)


with open(BIBTEX_SOURCE) as f, open(BIBTEX_TARGET, 'w') as output:
    ignoring = True
    current = {}
    for line in f:
        line = line.rstrip('\n')
        
        if line.lstrip().startswith('@'):
            ignoring = False
            
            item = get_item(line)
            current = {'@': item}
        
        elif line.strip() == "}":
            process_current(current, output)
            ignoring = True
        
        elif not ignoring:
            piece, value = line.split('=', 1)
            piece = piece.strip()
            value = value.strip().rstrip(',').rstrip()
            
            if piece == "url" or piece == "doi":
                value = "{" + correct_url(value[1:-1]) + "}"
            
            current[piece] = value
