OPTIONS (SKIP = 1)
LOAD DATA
INFILE '../data/staff.csv'
INTO TABLE STAFF
FIELDS TERMINATED BY ';'
( 
    funcion
    IdPer,
    IdObra
)