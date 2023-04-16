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
CREATE UNIQUE  INDEX fin_idx on SERIES(fin,IdObra);
CREATE UNIQUE  INDEX fecha_idx on OBRAS(AgnoEstreno,IdObra);




----------------TERCERA CONSULTA----------------
------------------------------------------------

CREATE MATERIALIZED VIEW  ConexPeli AS
SELECT DISTINCT c1.idObra
 FROM CONEXION c1, CONEXION c2
 WHERE c1.idObra = c2.idObra2 
                AND  c1.Tipo IN ('follows', 'followed by')
    AND c2.Tipo IN ('follows', 'followed by');

SELECT A.Personaje, COUNT(A.Personaje) AS NumeroPersonajes
FROM ACTORES A, ConexPeli C
WHERE A.IdObra = C.IdObra AND A.Personaje IS NOT NULL
GROUP BY A.Personaje
HAVING COUNT(DISTINCT A.IdPer) >= 4;

