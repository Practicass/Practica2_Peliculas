-----------------------------------------------------------------------------------------------------------------------
--NO NOS SIRVEN PERO IGUAL LA IDEA DE AL METER LOS DATOS METERLOS DIRECTAMENTE SE PUEDE DAR UNA VUELTA
-- CREATE or REPLACE TRIGGER ACTORNEW
-- BEFORE INSERT ON PERSONAS 
-- FOR EACH ROW
-- WHEN ((:new.puesto = 'actor') OR (:new.PERSONA = 'actress'))
--   BEGIN
--   INSERT INTO ACTOR(idPer,IdObra,personaje) VALUES (:new.idPer,:new.idObra,:new.personaje);
-- END ACTORNEW;
-- /

-- CREATE or REPLACE TRIGGER DIRECNEW
-- BEFORE INSERT ON PERSONAS 
-- FOR EACH ROW
-- WHEN (new.puesto = 'director')
--   BEGIN
--   INSERT INTO DIRECTORES(idPer,IdObra) VALUES (:new.idPer, :new.idObra);
-- END DIRECNEW;
-- /

-- CREATE or REPLACE TRIGGER STAFFNEW
-- BEFORE INSERT ON PERSONAS 
-- FOR EACH ROW
-- WHEN NOT ((new.puesto = 'director') OR (:new.puesto = 'actor') OR (:new.PERSONA = 'actress'))
--   BEGIN
--   INSERT INTO STAFF(idPer,idObra,funcion) VALUES (:new.idPer,:new.idObra,:new.funcion);
-- END DIRECNEW;
-- /
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

/**No puede haber un episodio anterior a la serie**/
CREATE or REPLACE TRIGGER epAdelantado
BEFORE INSERT ON EPISODIOS
FOR EACH ROW 
DECLARE
numT NUMBER(10);
  BEGIN
  SELECT  O2.AgnoEstreno - O1.AgnoEstreno INTO numT FROM OBRAS O1, OBRAS O2 where O1.idObra=:new.Serie and O2.id=:new.idObra;
  if numT<0
  then 
       RAISE_APPLICATION_ERROR(-20000, 'No puede haber un capitulo previo a la serie');
  end if;
END capAdelantado;
/

------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------


/***No dejar borrar peliculas (Habría que borrar de obras)**/
CREATE or REPLACE TRIGGER NOBORRARPELI
BEFORE DELETE ON PELICULAS
BEGIN
  RAISE_APPLICATION_ERROR(-20000, 'No se pueden borrar peliculas');
END NOBORRARPELI;
/

/***No dejar borrar series (Habría que borrar de obras)**/
CREATE or REPLACE TRIGGER NOBORRARSER
BEFORE DELETE ON SERIE
BEGIN
  RAISE_APPLICATION_ERROR(-20000, 'No se pueden borrar series');
END NOBORRARSER;
/

/***No dejar borrar episodios (Habría que borrar de obras)**/
CREATE or REPLACE TRIGGER NOBORRAREPI
BEFORE DELETE ON EPISODIOS
BEGIN
  RAISE_APPLICATION_ERROR(-20000, 'No se pueden borrar episodios');
END NOBORRAREPI;
/