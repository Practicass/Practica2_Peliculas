-- CREATE or REPLACE TRIGGER ACTORNEW
-- BEFORE INSERT ON PUESTO 
-- FOR EACH ROW
-- WHEN ((new.puesto = 'actor') OR (new.puesto = 'actress'))
--   BEGIN
--   INSERT INTO ACTOR(id) VALUES (:new.id_per);
-- END ACTORNEW;
-- /


-- /**No puede haber un capítulo anterior a la serie**/

-- CREATE or REPLACE TRIGGER capAdelantado
-- BEFORE INSERT ON CAPITULO
-- FOR EACH ROW 
-- DECLARE
-- numT NUMBER(10);
--   BEGIN
--   SELECT  M2.estreno - M1.estreno INTO numT FROM material_audiovisual M1, material_audiovisual M2 where M1.id=:new.idSerie and M2.id=:new.id_mat;
--   if numT<0
--   then 
--        RAISE_APPLICATION_ERROR(-20000, 'No puede haber un capitulo previo a la serie');
--   end if;
-- END capAdelantado;
-- /

-- /***No dejar borrar series (Habría que borrar de material_audiovisual)**/
-- CREATE or REPLACE TRIGGER NOBORRARSER
-- BEFORE DELETE ON SERIE
-- BEGIN
--   RAISE_APPLICATION_ERROR(-20000, 'No se pueden borrar series');
-- END NOBORRARSER;
-- /
