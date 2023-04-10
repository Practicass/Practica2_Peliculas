#!/bin/bash
cat DatosPeliculas.csv | cut -d ';' -f 17-18 | cut -d '"' -f 1 | sort | uniq  >actores.csv
