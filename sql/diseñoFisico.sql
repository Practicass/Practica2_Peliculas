----------------PRIMERA CONSULTA----------------
------------------------------------------------
CREATE VIEW obraFami as
SELECT idObra
FROM GENERO
WHERE genero = 'family';

SELECT O.Titulo
FROM OBRAS O, obraFami oF
WHERE   O.IdObra = oF.IdObra 
        and EXISTS (SELECT P.IdObra
                    FROM PELICULAS P
                    WHERE P.IdObra = O.IdObra)
        and NOT EXISTS (SELECT PERS.IdPer
                        FROM PERSONAS PERS, ACTORES A
                        WHERE   PERS.IdPer = A.IdPer 
                                and A.IdObra = O.IdObra 
                                and PERS.Sexo = 'm');

------------------------------------------------
DROP materialized VIEW peliFami;
CREATE  materialized VIEW peliFami as
SELECT idObra
FROM GENERO g 
WHERE genero = 'family'
     and EXISTS (SELECT P.IdObra
                    FROM PELICULAS P
                    WHERE P.IdObra = g.IdObra);

SELECT O.Titulo
FROM OBRAS O, peliFami pF
WHERE   O.IdObra = pF.IdObra 
        and NOT EXISTS (SELECT PERS.IdPer
                        FROM PERSONAS PERS, ACTORES A
                        WHERE   PERS.IdPer = A.IdPer 
                                and A.IdObra = O.IdObra 
                                and PERS.Sexo = 'm');





----------------SEGUNDA CONSULTA----------------
------------------------------------------------
CREATE UNIQUE INDEX fin_idx on SERIES(fin,IdObra);
CREATE UNIQUE INDEX fecha_idx on OBRAS(AgnoEstreno,IdObra);