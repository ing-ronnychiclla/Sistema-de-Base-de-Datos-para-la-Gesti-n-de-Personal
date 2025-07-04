--Creaci�n de SCHEMAS
CREATE SCHEMA ADM;
GO
CREATE SCHEMA RRHH;
GO

--Tipos de datos de usuario
CREATE TYPE TD_CADENA FROM VARCHAR(80) NOT NULL;
GO
CREATE TYPE TD_FECHA FROM DATE NULL;
GO
CREATE TYPE TD_MONEDA FROM SMALLMONEY NOT NULL;
GO


CREATE TABLE CARGO(
    CODCARGO INT PRIMARY KEY NOT NULL,
    CARGO TD_CADENA NOT NULL
);
GO

CREATE TABLE EMPLEADO(
    CODEMP INT PRIMARY KEY NOT NULL,
    NOMBRES TD_CADENA,
    DIRECCION TD_CADENA,
    CORREO TD_CADENA,
    GENERO TD_CADENA,
    FECHA_NAC TD_FECHA NOT NULL,
    SUELDO TD_MONEDA,
    CELULAR TD_CADENA,
    ESTADO BIT NOT NULL,
    CODCARGO INT NOT NULL 
);
GO
-- �RONNY CHICLLA ZAMORA
ALTER TABLE EMPLEADO
ADD CONSTRAINT FK_EMPLEADO_CARGO
FOREIGN KEY (CODCARGO) REFERENCES CARGO(CODCARGO);
GO

CREATE TABLE CAPACITACION(
    CODCAP INT PRIMARY KEY NOT NULL,
    TEMA TD_CADENA,
    SUBTEMA TD_CADENA,
    LUGAR TD_CADENA NOT NULL,
    RESPONSABLE TD_CADENA,
    ESTADO BIT NOT NULL
);
GO

CREATE TABLE DETA_CAPACITACION(
    CODCAP INT,
    CODEMP INT,
    FECHACAP TD_FECHA,
    HORA_DESDE TIME,
    HORA_HASTA TIME,
    PRIMARY KEY (CODCAP, CODEMP),
    FOREIGN KEY (CODCAP) REFERENCES CAPACITACION(CODCAP),
    FOREIGN KEY (CODEMP) REFERENCES EMPLEADO(CODEMP)
);
GO