#!/bin/bash
cat DatosPeliculas.csv | cut -d ';' -f 16,18 | cut -d '"' -f 1 | sort | uniq  >staff.csv
