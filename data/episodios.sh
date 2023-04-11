#!/bin/bash
cat DatosPeliculas_copia.csv | cut -d ';' -f 3,5,6,9,20,21 | cut -d '"' -f 1 | sort | uniq  >episodios.csv
