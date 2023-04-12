OPTIONS (SKIP = 1)
LOAD DATA
INFILE '../data/actores.csv'
INTO TABLE ACTORES
FIELDS TERMINATED BY ';'
( 
     personaje,
     IdPer,
     IdObra,
     idPapel
)