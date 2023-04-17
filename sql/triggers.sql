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
  RAISE_APPLICATION_ERROR(-20001, 'No se pueden borrar series');
END NOBORRARSER;
/

/***No dejar borrar episodios (Habría que borrar de obras)**/
CREATE or REPLACE TRIGGER NOBORRAREPI
BEFORE DELETE ON EPISODIOS
BEGIN
  RAISE_APPLICATION_ERROR(-20002, 'No se pueden borrar episodios');
END NOBORRAREPI;
/
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

/**No puede haber un episodio anterior a la serie**/
CREATE or REPLACE TRIGGER epAdelantado
BEFORE INSERT ON EPISODIOS
FOR EACH ROW 
DECLARE
numT NUMBER(10);
  BEGIN
  SELECT  O2.AgnoEstreno - O1.AgnoEstreno INTO numT 
  FROM    OBRAS O1, OBRAS O2 
  where   O1.idObra=:new.Serie 
          and O2.idObra=:new.idObra;
  if numT<0
  then 
       RAISE_APPLICATION_ERROR(-20000, 'No puede haber un capitulo previo a la serie');
  end if;
END capAdelantado;
/



------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
 CREATE or REPLACE TRIGGER conexPrevia
 BEFORE INSERT ON CONEXION
 FOR EACH ROW DECLARE
num NUMBER(10);
  BEGIN
  SELECT  O2.AgnoEstreno - O1.AgnoEstreno INTO num 
  FROM    OBRAS O1, OBRAS O2 
  where   O1.idObra=:new.idObra 
          and O2.idObra=:new.idObra2 
          and :new.tipo =   'follows' 
          or  :new.tipo =   'edited from'
          or  :new.tipo =   'references'
          or  :new.tipo =   'version of'
          or  :new.tipo =   'spin of'
          or  :new.tipo =   'reamake of'
          or  :new.tipo =   'features';
  if num<0
  then 
       RAISE_APPLICATION_ERROR(-20004, 'No puede haber una pelicula basada en una que es previo a la pelicula');
  end if;
END conexPrevia;
/


------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
