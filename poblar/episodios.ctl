OPTIONS (SKIP = 1)
LOAD DATA
INFILE '../data/episodios.csv'
INTO TABLE EPISODIOS
FIELDS TERMINATED BY ';'
( 
    Serie,
    temp, 
    num,
    IdObra
)