OPTIONS (SKIP = 1)
LOAD DATA
INFILE '../data/obras.csv'
INTO TABLE DIVISIONES
FIELDS TERMINATED BY ';'
( 
    titulo,
    AgnoEstreno 
)