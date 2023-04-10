#!/bin/bash
cat DatosPeliculas.csv | cut -d ';' -f 5-6,18 | cut -d '"' -f 1 | sort | uniq  >episodios.csv
