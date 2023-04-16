-- Listar el título de las películas de género familiar que sólo han sido interpretadas por actrices:
SELECT O.Titulo
FROM OBRAS O, GENERO G
WHERE   O.IdObra = G.IdObra 
        and G.Genero = 'family' 
        and EXISTS (SELECT P.IdObra
                    FROM PELICULAS P
                    WHERE P.IdObra = O.IdObra)
        and NOT EXISTS (SELECT PERS.IdPer
                        FROM PERSONAS PERS, ACTORES A
                        WHERE   PERS.IdPer = A.IdPer 
                                and A.IdObra = O.IdObra 
                                and PERS.Sexo = 'm');




--Listar el nombre de los directores que han dirigido al menos seis series distintas en la década de los 90.

SELECT PERS.Nombre AS nomPer, COUNT(S.IdObra) AS contador
FROM OBRAS O, SERIES S, DIRECTORES D, EPSIODIOS E
JOIN PERSONAS PERS ON PERS.IdPer = D.IdPer
WHERE ((O.AgnoEstreno < 1990
    AND (S.fin IS NULL OR S.fin >= 1990)) OR (O.AgnoEstreno>=1990 and O.Agnoestreno < 2000))
    AND S.IdObra = O.IdObra
    AND O.IdObra = D.IdObra
    AND PERS.Nombre IN (
        SELECT PERS2.Nombre
        FROM PERSONAS PERS2
        JOIN DIRECTORES D2 ON D2.IdPer = PERS2.IdPer
        JOIN OBRAS O2 ON O2.IdObra = D2.IdObra
        JOIN SERIES S2 ON O2.IdObra = S2.IdObra
        WHERE ((O2.AgnoEstreno < 1990
    AND (S2.fin IS NULL OR S2.fin >= 1990)) OR (O2.AgnoEstreno>=1990 and O2.Agnoestreno < 2000))
        GROUP BY PERS2.Nombre
        HAVING COUNT(DISTINCT O2.IdObra) >= 6
    )
GROUP BY PERS.Nombre
HAVING COUNT(DISTINCT O.IdObra) >= 6
ORDER BY contador DESC;


SELECT PERS2.Nombre, count(S2.IdObra)
        FROM PERSONAS PERS2, DIRECTORES D2, OBRAS O2, SERIES S2
        WHERE ((O2.AgnoEstreno < 1990
    AND (S2.fin >= 1990)) OR (O2.AgnoEstreno>=1990 and O2.Agnoestreno < 2000))
        and D2.IdPer = PERS2.IdPer
        and O2.IdObra = D2.IdObra
        and O2.IdObra = S2.IdObra
        GROUP BY PERS2.Nombre
        HAVING COUNT(DISTINCT O2.IdObra) >= 6
    