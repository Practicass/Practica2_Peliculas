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

-- RESPUESTA DE CLASE=1

-- Listar el nombre de los directores que han dirigido al menos seis series distintas en la década de los 90:
SELECT UNIQUE PERS.Nombre
FROM PERSONAS PERS, DIRECTORES D
WHERE PERS.IdPer = D.IdPer and 6 >= (SELECT count(*)
                                    FROM OBRAS O, SERIES S 
                                    WHERE   O.IdObra = D.IdObra 
                                            and O.AgnoEstreno >= '1990' 
                                            and O.AgnoEstreno < '2000' 
                                            and S.IdObra = O.IdObra
                                        );



------------------------------------------------
SELECT PERS.Nombre AS nomPer, COUNT(S.IdObra) AS contador
FROM OBRAS O, SERIES S, DIRECTORES D
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
-- RESPUESTA DE CLASE=4


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

-- Obtener el número de personajes distintos que han sido interpretados por al menos cuatro actores o actrices
-- distintos y que aparecen en películas de alguna saga (es decir, que son secuelas/precuelas unas de otras)

SELECT UNIQUE A.personaje
FROM ACTORES A
WHERE 4 <= (SELECT count(  A.IdPer)
            FROM ACTORES A2
            WHERE A2.Personaje = A.personaje and (SELECT P1.IdObra --Primera pelicula de una saga
                                                                                      FROM CONEXION P1
                                                                                      WHERE     A.IdObra = P1.IdObra2 
                                                                                                and NOT EXISTS (SELECT IdObra
                                                                                                                FROM CONEXION P2   
                                                                                                                WHERE P2.IdObra2=P1.IdObra and P2.Tipo='followed by')
                                                                                                and EXISTS (SELECT IdObra
                                                                                                                FROM CONEXION P3
                                                                                                                WHERE P3.IdObra=P1.IdObra and P3.Tipo='followed by')) = (SELECT P1.IdObra --Primera pelicula de una saga
                                                                                      FROM CONEXION P1
                                                                                      WHERE     A2.IdObra = P1.IdObra2 
                                                                                                and NOT EXISTS (SELECT IdObra
                                                                                                                FROM CONEXION P2   
                                                                                                                WHERE P2.IdObra2=P1.IdObra and P2.Tipo='followed by')
                                                                                                and EXISTS (SELECT IdObra
                                                                                                                FROM CONEXION P3
                                                                                                                WHERE P3.IdObra=P1.IdObra and P3.Tipo='followed by')));


(actor)

(peli1, peli2, followed by)
(peli1, peli3, followed by)
(pel2, peli1, follows)
(pel3, peli1, follows)

--LO DE ABAJO SON PRUEBAS

SELECT count(*)
FROM ACTORES A
WHERE 4 <= (SELECT count(DISTINCT A.IdPer)
            FROM ACTORES A2
            WHERE A2.Personaje = A.Personaje and (A.IdObra,A2.IdObra)=(SELECT UNIQUE P.IdObra, P.IdObra2
                                                                      FROM CONEXION P
                                                                      WHERE P.IdObra=(SELECT P1.IdObra
                                                                                      FROM CONEXION P1
                                                                                      WHERE NOT EXISTS (SELECT IdObra
                                                                                                        FROM CONEXION P2   
                                                                                                        WHERE P2.IdObra2=P1.IdObra and P2.Tipo='followed by'))));


--LA PRIMERA PELI DE CADA SAGA
SELECT P.IdObra
FROM PELICULAS P
WHERE NOT EXISTS (SELECT P2.IdObra
                  FROM PELICULAS P2   
                  WHERE P2.IdObra2=P.IdObra and P2.Tipo="followed by")
                  and EXISTS (SELECT P3.IdObra
                              FROM PELICULAS P3
                              WHERE P3.IdObra=P.IdObra and P2.Tipo="followed by")


SELECT UNIQUE P.IdObra, P.IdObra2
FROM PELICULAS P
WHERE NOT EXISTS (SELECT IdObra
                  FROM PELICULAS P2   
                  WHERE P2.IdObra2=P.IdObra and P2.Tipo="followed by")
                  and EXISTS (SELECT IdObra
                              FROM PELICULAS P3
                              WHERE P3.IdObra=P.IdObra and P2.Tipo="followed by")
--GROUP BY P.IdObra


SELECT UNIQUE P.IdObra, P.IdObra2
FROM PELICULAS P
WHERE P.IdObra=(SELECT P1.IdObra

                FROM PELICULAS P1
                WHERE NOT EXISTS (SELECT IdObra
                                  FROM PELICULAS P2   
                                  WHERE P2.IdObra2=P1.IdObra and P2.Tipo="followed by")
                                  and EXISTS (SELECT IdObra
                                              FROM PELICULAS P3
                                              WHERE P3.IdObra=P1.IdObra and P3.Tipo="followed by"))







/***
Muestra los actores y actrices que han participado en todas las secuelas de una 
saga formada por al menos cuatro películas (notar que pueden no haber 
participado en la primera película de la saga).
**/

CREATE VIEW actoresSagas as /**actores que actuan en cada peli de la saga**/
select distinct nombrecomp,SAGAS.idP1 as idP1, SAGAS.idP2 as idP2
from
    persona
INNER JOIN
ACTUA
ON ACTUA.ID_ACT=PERSONA.ID
RIGHT JOIN
(
    select * from 
        secuela 
    NATURAL JOIN
        (
            select distinct  idp2
                from secuela SEC1
                where NOT EXISTS (select idP1 from secuela SEC2  where SEC1.idp2=SEC2.idp1 )
                group by idp2
                 HAVING count(*)>2
        ) SEC/**primer peli de sagas con 4  mas pelis**/
)SAGAS /** secuelas de sagas con mas de 3 pelis**/
ON ACTUA.ID_MAT=SAGAS.idP1
;


select distinct nombrecomp as Actores
from actoresSagas T 
where (
    /**veces que sale un actor en una saga**/
    select count(nombrecomp) from actoresSagas where nombrecomp=T.nombrecomp and idp2=T.idp2 GROUP BY idP2,nombrecomp  )=
    /**peliculas de saga**/
    (select count(*) from (select distinct idP1, idp2 from actoresSagas ) where idp2=T.idp2 group by idp2 )
;
DROP VIEW actoresSagas;








-- SELECT PERS.Nombre AS nomPer, COUNT(S.IdObra) AS contador
-- FROM OBRAS O, SERIES S, DIRECTORES D, EPSIODIOS E
-- JOIN PERSONAS PERS ON PERS.IdPer = D.IdPer
-- WHERE ((O.AgnoEstreno < 1990
--     AND (S.fin IS NULL OR S.fin >= 1990)) OR (O.AgnoEstreno>=1990 and O.Agnoestreno < 2000))
--     AND S.IdObra = O.IdObra
--     AND O.IdObra = D.IdObra
--     AND PERS.Nombre IN (
--         SELECT PERS2.Nombre
--         FROM PERSONAS PERS2
--         JOIN DIRECTORES D2 ON D2.IdPer = PERS2.IdPer
--         JOIN OBRAS O2 ON O2.IdObra = D2.IdObra
--         JOIN SERIES S2 ON O2.IdObra = S2.IdObra
--         WHERE ((O2.AgnoEstreno < 1990
--     AND (S2.fin IS NULL OR S2.fin >= 1990)) OR (O2.AgnoEstreno>=1990 and O2.Agnoestreno < 2000))
--         GROUP BY PERS2.Nombre
--         HAVING COUNT(DISTINCT O2.IdObra) >= 6
--     )
-- GROUP BY PERS.Nombre
-- HAVING COUNT(DISTINCT O.IdObra) >= 6
-- ORDER BY contador DESC;


-- select p.nombre as direc, count(e.IdObra) as contador
-- from directores d, episodios e, obras o, personas p
-- where o.IdObra = e.IdObra and d.IdObra = e.IdObra and (o.AgnoEstreno >='1990' and o.AgnoEstreno < '2000') and p.IdPer = d.IdPer
-- GROUP BY p.Nombre
-- ORDER BY contador DESC;