#!/bin/bash
cat DatosPeliculas.csv | cut -d ';' -f 13,18 | cut -d '"' -f 1 | sort | uniq  >genero.csv
