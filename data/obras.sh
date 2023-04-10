#!/bin/bash
cat DatosPeliculas.csv | cut -d ';' -f 14-15,18 | cut -d '"' -f 1 | sort | uniq  >obras.csv
