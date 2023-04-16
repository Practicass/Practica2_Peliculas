OPTIONS (SKIP = 1)
LOAD DATA
INFILE '../data/actores.csv'
INTO TABLE ACTORES
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
( 
     personaje,
     IdPer,
     IdObra,
     idPapel "sec.nextval"
)

