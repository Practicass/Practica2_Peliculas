OPTIONS (SKIP = 1)
LOAD DATA
INFILE '../data/personas.csv'
INTO TABLE DIVISIONES
FIELDS TERMINATED BY ';'
( 
    nombre,
    sexo,
    idPer
)