SET ECHO ON

CREATE TABLE PERSONAS (
    IdPer NUMBER(6) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Sexo CHAR(1)
);

CREATE TABLE OBRAS (
    IdObra NUMBER(6) PRIMARY KEY,
    Titulo VARCHAR(100) NOT NULL,
    AgnoEstreno NUMBER(4)
);

CREATE TABLE ACTORES (
    IdObra NUMBER(6),
    IdPer NUMBER(6),
    personaje VARCHAR(50),
    FOREIGN KEY(IdObra) REFERENCES OBRAS(IdObra) ON DELETE CASCADE,
    FOREIGN KEY(IdPer) REFERENCES PERSONAS(IdPer) ON DELETE CASCADE,
    CONSTRAINT ACTORES_PK PRIMARY KEY(IdObra, IdPer)
);

CREATE TABLE DIRECTORES (
    IdObra NUMBER(6),
    IdPer NUMBER(6),
    FOREIGN KEY(IdObra) REFERENCES OBRAS(IdObra) ON DELETE CASCADE,
    FOREIGN KEY(IdPer) REFERENCES PERSONAS(IdPer) ON DELETE CASCADE,
    CONSTRAINT DIRECTORES_PK PRIMARY KEY(IdObra, IdPer)
);

CREATE TABLE STAFF (
    IdObra NUMBER(6),
    IdPer NUMBER(6),
    funcion VARCHAR(100),
    FOREIGN KEY(IdObra) REFERENCES OBRAS(IdObra) ON DELETE CASCADE,
    FOREIGN KEY(IdPer) REFERENCES PERSONAS(IdPer) ON DELETE CASCADE,
    CONSTRAINT STAFF_PK PRIMARY KEY(IdObra, IdPer, funcion)
);

CREATE TABLE GENERO (
    Genero VARCHAR(100),
    IdObra NUMBER(6),
    FOREIGN KEY(IdObra) REFERENCES OBRAS(IdObra) ON DELETE CASCADE,
    CONSTRAINT GENERO_PK PRIMARY KEY(Genero,IdObra)
);

CREATE TABLE SERIES (
    IdObra NUMBER(6) PRIMARY KEY,
    inicio NUMBER(4),
    fin NUMBER(4),
    FOREIGN KEY(IdObra) REFERENCES OBRAS(IdObra) ON DELETE CASCADE,
    CHECK (inicio < fin)
);

CREATE TABLE EPISODIOS (
    IdObra NUMBER(6) PRIMARY KEY,
    Serie NUMBER(6),
    num NUMBER(4),
    temp NUMBER(4),
    FOREIGN KEY(Serie) REFERENCES SERIES(IdObra) ON DELETE CASCADE,
    FOREIGN KEY(IdObra) REFERENCES OBRAS(IdObra) ON DELETE CASCADE
);



CREATE TABLE PELICULAS (
    IdObra NUMBER(6) PRIMARY KEY,
    IdObra2 NUMBER(6),
    tipo VARCHAR(20),
    FOREIGN KEY(IdObra) REFERENCES OBRAS(IdObra) ON DELETE CASCADE,
    FOREIGN KEY(IdObra2) REFERENCES PELICULAS(IdObra) ON DELETE CASCADE
);




DROP TABLE PERSONAS ;
DROP TABLE OBRAS;
DROP TABLE ACTORES;
DROP TABLE DIRECTORES;
DROP TABLE STAFF ;
DROP TABLE GENERO ;
DROP TABLE SERIES ;
DROP TABLE EPISODIOS; 
DROP TABLE PELICULAS ;


