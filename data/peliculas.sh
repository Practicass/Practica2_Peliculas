#!/bin/bash
# cat DatosPeliculas_copia.csv | cut -d ';' -f 1,9,10,12,19,20 | cut -d '"' -f 1 | sort | uniq  >peliculas.csv
cat peliculas.csv | sort | uniq  >peliculas2.csv