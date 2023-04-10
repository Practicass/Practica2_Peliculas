OPTIONS (SKIP = 1)
LOAD DATA
INFILE '../data/directores.csv'
INTO TABLE DIVISIONES
FIELDS TERMINATED BY ';'
( 
    denominacion 
)