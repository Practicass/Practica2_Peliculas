#!/bin/bash
cat DatosPeliculas.csv | cut -d ';' -f 18 | cut -d '"' -f 1 | sort | uniq  >directores.csv
