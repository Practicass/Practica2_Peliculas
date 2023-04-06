#!/bin/bash
cat DatosPeliculas.csv | cut -d ';' -f 7 | cut -d '"' -f 1   >fechas.csv

sed -ie 's/-/;/' fechas.csv 