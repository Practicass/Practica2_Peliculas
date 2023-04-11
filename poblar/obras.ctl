OPTIONS (SKIP = 1)
LOAD DATA
INFILE '../data/obras.csv'
INTO TABLE OBRAS
FIELDS TERMINATED BY ';'
( 
    titulo,
    AgnoEstreno,
    idObr
)