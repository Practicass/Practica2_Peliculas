OPTIONS (SKIP = 1)
LOAD DATA
INFILE '../data/peliculas.csv'
INTO TABLE PELICULAS
FIELDS TERMINATED BY ';'
( 
    tipo,
    IdObra,
    IdObra2
)