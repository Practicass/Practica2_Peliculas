Listar el título de las películas de género familiar que sólo han sido interpretadas por actrices:
SELECT O.Titulo
FROM OBRAS O, GENERO G
WHERE O.IdObra = G.IdObra and G.Genero = "familiar" and EXISTS (SELECT P.IdObra
                                                                FROM PELICULAS P
                                                                WHERE P.IdObra = O.IdObra)
        and NOT EXISTS (SELECT PERS.IdPer
                        FROM PERSONAS PERS, ACTORES A
                        WHERE PERS.IdPer = A.IdPer and A.IdObra = O.IdObra and PERS.Sexo = "hombre")

RESPUESTA DE CLASE=1

Listar el nombre de los directores que han dirigido al menos seis series distintas en la década de los 90:
SELECT PERS.Nombre
FROM PERSONAS PERS, DIRECTORES D
WHERE PERS.IdPer = D.IdPer and 6 <=    (SELECT count(*)
                                        FROM OBRAS O, 
                                        WHERE O.IdObra = D.IdObra and O.AgnoEstreno>="1990" and O.AgnoEstreno<"2000"and EXISTS   (SELECT S.IdObra
                                                                                                                                    FROM SERIES S
                                                                                                                                    WHERE S.IdObra = O.IdObra)
                                        )

RESPUESTA DE CLASE=4


Obtener el número de personajes distintos que han sido interpretados por al menos cuatro actores o actrices
distintos y que aparecen en películas de alguna saga (es decir, que son secuelas/precuelas unas de otras)

SELECT count(*)
FROM ACTORES A
WHERE 4 <= (SELECT count(DISTINCT A.IdPer)
            FROM ACTORES A2
            WHERE A2.Personaje = A.Personaje and (A.IdObra,A2.IdObra)=(SELECT UNIQUE P.IdObra, P.IdObra2
                                                                      FROM PELICULAS P
                                                                      WHERE P.IdObra=(SELECT P1.IdObra
                                                                                      FROM PELICULAS P1
                                                                                      WHERE NOT EXISTS (SELECT IdObra
                                                                                                        FROM PELICULAS P2   
                                                                                                        WHERE P2.IdObra2=P1.IdObra and P2.Tipo="followed by")
                                                                                                        and EXISTS (SELECT IdObra
                                                                                                                    FROM PELICULAS P3
                                                                                                                    WHERE P3.IdObra=P1.IdObra and P3.Tipo="followed by"))))

//LO DE ABAJO SON PRUEBAS


//LA PRIMERA PELI DE CADA SAGA
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
//GROUP BY P.IdObra


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

