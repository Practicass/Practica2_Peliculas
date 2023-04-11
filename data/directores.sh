#!/bin/bash

# cat DatosPeliculas_copia.csv | cut -d ';' -f 16,19,20,21 | cut -d '"' -f 1 | sort | uniq  >directores2.csv
cat directores2.csv | cut -d '"' -f 1 >directores.csv