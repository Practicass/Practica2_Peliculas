OPTIONS (SKIP = 1)
LOAD DATA
INFILE '../data/episodios.csv'
INTO TABLE EPISODIOS
FIELDS TERMINATED BY ';'
( 
    
    temp, 
    num,
    IdObra,
    Serie
)