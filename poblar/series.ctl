OPTIONS (SKIP = 1)
LOAD DATA
INFILE '../data/series.csv'
INTO TABLE DIVISIONES
FIELDS TERMINATED BY ';'
( 
    inicio,
    fin 
)