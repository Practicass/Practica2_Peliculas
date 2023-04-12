#!/bin/bash
cat DatosPeliculas_copia3.csv | cut -d ';' -f 7,8,20,21 | cut -d '"' -f 1 | sort | uniq  >series.csv
