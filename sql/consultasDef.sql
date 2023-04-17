-- Listar el título de las películas de género familiar que sólo han sido interpretadas por actrices:
SELECT O.Titulo
FROM OBRAS O, GENERO G, PELICULAS P
WHERE   O.IdObra = G.IdObra 
        and G.Genero = 'family' 
        and P.IdObra = O.IdObra
        and NOT EXISTS (SELECT PERS.IdPer
                        FROM PERSONAS PERS, ACTORES A
                        WHERE   PERS.IdPer = A.IdPer 
                                and A.IdObra = O.IdObra 
                                and PERS.Sexo = 'm');




--Listar el nombre de los directores que han dirigido al menos seis series distintas en la década de los 90.
SELECT PERS2.Nombre, count(S2.IdObra) as num_veces
        FROM PERSONAS PERS2, DIRECTORES D2, OBRAS O2, SERIES S2
        WHERE ((O2.AgnoEstreno < 1990
    AND (S2.fin >= 1990)) OR (O2.AgnoEstreno>=1990 and O2.Agnoestreno < 2000))
        and D2.IdPer = PERS2.IdPer
        and O2.IdObra = D2.IdObra
        and O2.IdObra = S2.IdObra
        GROUP BY PERS2.Nombre
        HAVING COUNT(DISTINCT O2.IdObra) >= 6


--Obtener el número de personajes distintos que han sido interpretados por al menos cuatro actores o actrices 
--distintos y que aparecen en películas de alguna saga (es decir, que son secuelas/precuelas unas de otras):
SELECT COUNT(DISTINCT A2.Personaje) as "Numero de Personajes"
FROM ACTORES A2
WHERE A2.personaje IN 
(SELECT A.Personaje
FROM ACTORES A
WHERE A.idObra IN (
    	SELECT DISTINCT c1.idObra
    	FROM CONEXION c1, CONEXION c2
   	 WHERE c1.idObra = c2.idObra2 
                  	AND  c1.Tipo IN ('follows', 'followed by')
     	AND c2.Tipo IN ('follows', 'followed by') 
)  AND A.Personaje IS NOT NULL
GROUP BY A.Personaje
HAVING COUNT(DISTINCT A.IdPer) >= 4);