OPTIONS (SKIP = 1)
LOAD DATA
INFILE '../data/genero.csv'
INTO TABLE GENERO
FIELDS TERMINATED BY ';'
( 
    obraGen,
    IdObra
)