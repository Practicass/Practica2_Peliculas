OPTIONS (SKIP = 1)
LOAD DATA
INFILE '../data/series.csv'
INTO TABLE SERIES
FIELDS TERMINATED BY ';'
( 
    inicio,
    fin 
)