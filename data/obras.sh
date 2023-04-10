#!/bin/bash
cat DatosPeliculas.csv | cut -d ';' -f 1-2,18 | cut -d '"' -f 1 | sort | uniq  >obras.csv
