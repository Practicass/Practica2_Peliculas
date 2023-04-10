OPTIONS (SKIP = 1)
LOAD DATA
INFILE '../data/fechas.csv'
INTO TABLE DIVISIONES
FIELDS TERMINATED BY ';'
( 
    denominacion 
)