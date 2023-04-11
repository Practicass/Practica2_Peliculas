OPTIONS (SKIP = 1)
LOAD DATA
INFILE '../data/directores.csv'
INTO TABLE DIRECTORES
FIELDS TERMINATED BY ';'
( 
    denominacion 
)