#!/bin/bash
cat DatosPeliculas_copia.csv | cut -d ';' -f 13,20,21 | cut -d '"' -f 1 | sort | uniq  >genero.csv
