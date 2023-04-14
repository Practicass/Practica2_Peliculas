OPTIONS (SKIP = 1)
LOAD DATA
INFILE '../data/conexion.csv'
INTO TABLE CONEXION
FIELDS TERMINATED BY ';'
( 
    tipo,
    IdObra,
    IdObra2
)