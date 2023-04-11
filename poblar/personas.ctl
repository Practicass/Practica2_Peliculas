OPTIONS (SKIP = 1)
LOAD DATA
INFILE '../data/personas.csv'
INTO TABLE PERSONAS
FIELDS TERMINATED BY ';'
( 
    nombre,
    sexo,
    idPer
)