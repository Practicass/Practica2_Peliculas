#!/bin/bash
cat DatosPeliculas_copia.csv | cut -d ';' -f 16,17,19,20,21 | cut -d '"' -f 1 | sort | uniq  >actores.csv
#cat actores.csv | cut -d '"' -f 1 >actores2.csv