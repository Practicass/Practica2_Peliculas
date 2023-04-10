OPTIONS (SKIP = 1)
LOAD DATA
INFILE '../data/episodios.csv'
INTO TABLE DIVISIONES
FIELDS TERMINATED BY ';'
( 
    temp, 
    num 
)