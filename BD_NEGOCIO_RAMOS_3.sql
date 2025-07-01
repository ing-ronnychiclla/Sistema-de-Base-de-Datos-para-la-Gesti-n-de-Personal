ALTER SCHEMA RRHH TRANSFER DBO.EMPLEADO;
GO
ALTER SCHEMA RRHH TRANSFER DBO.CARGO;
GO
ALTER SCHEMA ADM TRANSFER DBO.CAPACITACION;
GO
ALTER SCHEMA ADM TRANSFER DBO.DETA_CAPACITACION;
GO

--implemente restricciones para los campos SUELDO de la tabla EMPLEADO 
--para que el valor sea MAYOR a 680 y MENOR a 4000 y el campo FECHA_NAC puede 
--ser antes de la fecha de hoy y no nulo.
ALTER TABLE RRHH.EMPLEADO
ADD CONSTRAINT CHK_SUELDO_RANGO CHECK (SUELDO > 680 AND SUELDO < 4000);
GO

ALTER TABLE RRHH.EMPLEADO
ADD CONSTRAINT CHK_FECHA_NAC_PASADA CHECK (FECHA_NAC < GETDATE());
GO

--Crear la función de partición (partition function)
CREATE PARTITION FUNCTION PF_FECHA_CAPA (DATE)
AS RANGE LEFT FOR VALUES ('2017-12-31', '2020-12-31');
GO
-- ©RONNY CHICLLA ZAMORA
--Crear el esquema de partición (partition scheme)
CREATE PARTITION SCHEME PS_FECHA_CAPA
AS PARTITION PF_FECHA_CAPA
TO (GRUPO1, GRUPO2, GRUPO3);
GO

--Crear la tabla particionada RESUMEN_CAPA dentro del esquema ADM
CREATE TABLE ADM.RESUMEN_CAPA (
	ID_ITEM INT NOT NULL,
	FECHA_CAPA DATE,
	ZONA VARCHAR(30),
	ESTADO VARCHAR(15)
)
ON PS_FECHA_CAPA(FECHA_CAPA); 
GO

--Insertar registros en la tabla particionada ADM.RESUMEN_CAPA
INSERT INTO ADM.RESUMEN_CAPA (ID_ITEM, FECHA_CAPA, ZONA, ESTADO) VALUES
(1, '2016-05-10', 'Zona Norte', 'Finalizado'),     
(2, '2018-07-22', 'Zona Sur', 'Pendiente'),        
(3, '2022-01-15', 'Zona Centro', 'En Proceso'),   
(4, '2017-12-31', 'Zona Este', 'Finalizado'),     
(5, '2019-06-30', 'Zona Oeste', 'Pendiente');     
GO

--Listar registros con el número de partición
SELECT ID_ITEM,FECHA_CAPA,ZONA,ESTADO,
$PARTITION.PF_FECHA_CAPA(FECHA_CAPA) AS NRO_PARTICION
FROM ADM.RESUMEN_CAPA;

CREATE INDEX idx_nombre_fecha_desc
ON RRHH.EMPLEADO (NOMBRES DESC, FECHA_NAC DESC);




