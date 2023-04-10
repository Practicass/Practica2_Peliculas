#!/bin/bash
cat DatosPeliculas.csv | cut -d ';' -f 7,8,18 | cut -d '"' -f 1 | sort | uniq  >series.csv
