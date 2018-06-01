CREATE TABLE Zona (
idZona NUMBER PRIMARY KEY NOT NULL,
NombreZona varchar (30) NOT NULL,
TipoZona varchar (20) NOT NULL
);
CREATE SEQUENCE SEQ_ZONA
MINVALUE 1
MAXVALUE 1000000
START WITH 1
INCREMENT BY 1;
CREATE or replace TRIGGER TR_ZONA
BEFORE INSERT ON ZONA FOR EACH ROW
DECLARE
NUMERO NUMBER;
BEGIN
SELECT SEQ_ZONA.NEXTVAL INTO NUMERO FROM DUAL;
:NEW.idZONA :=NUMERO;
END;
/
prompt 1
CREATE TABLE Recurso (
idRecurso NUMBER PRIMARY KEY NOT NULL,
NombreRecurso varchar (25) NOT NULL
);
CREATE TABLE Indicador (
idIndicador NUMBER PRIMARY KEY NOT NULL,
idRecurso NUMBER NOT NULL,
NombreIndicador varchar (200) NULL,
Sigla varchar (15) NULL,
TipoIndicador varchar (30) NOT NULL,
Ambito varchar (30) NULL,
Descripcion varchar (1000) NULL
);
CREATE TABLE EstacionMuestreo (
idEstacionMuestreo NUMBER PRIMARY KEY NOT NULL,
idZona NUMBER NOT NULL,
Nombre varchar (50) NULL,
Ubicación varchar (300) NULL,
Longitud decimal (18, 0) NOT NULL
);
CREATE SEQUENCE SEQ_EstacionMuestreo
MINVALUE 49
MAXVALUE 1000000
START WITH 49
INCREMENT BY 1;
CREATE OR REPLACE TRIGGER TR_EstacionMuestreo
BEFORE INSERT ON EstacionMuestreo FOR EACH ROW
DECLARE
NUMERO NUMBER;
BEGIN
SELECT SEQ_EstacionMuestreo.NEXTVAL INTO NUMERO FROM DUAL;
:NEW.idEstacionMuestreo :=NUMERO;
END;
/
prompt 2
CREATE TABLE MuestraMensual (
idMuestraMensual NUMBER PRIMARY KEY NOT NULL,
idIndicador NUMBER NOT NULL,
Fecha NUMBER NOT NULL,
Mes NUMBER NOT NULL,
Valor decimal (18, 0) NOT NULL
);
CREATE SEQUENCE SEQ_MuestraMensual
MINVALUE 1
MAXVALUE 1000000
START WITH 1
INCREMENT BY 1;
CREATE OR REPLACE TRIGGER TR_MuestraMensual
BEFORE INSERT ON MuestraMensual FOR EACH ROW
DECLARE
NUMERO NUMBER;
BEGIN
SELECT SEQ_MuestraMensual.NEXTVAL INTO NUMERO FROM DUAL;
:NEW.idMuestraMensual :=NUMERO;
END;
/
CREATE TABLE MuestraAnual (
idMuestraAnual NUMBER PRIMARY KEY NOT NULL,
idEstacionMuestreo NUMBER NOT NULL,
idIndicador NUMBER NOT NULL,
Fecha NUMBER NOT NULL,
Valor decimal (18, 0) NULL
);
CREATE SEQUENCE SEQ_MuestraAnual
MINVALUE 1
MAXVALUE 1000000
START WITH 1
INCREMENT BY 1;
CREATE OR REPLACE TRIGGER TR_MuestraAnual
BEFORE INSERT ON MuestraAnual FOR EACH ROW
DECLARE
NUMERO NUMBER;
BEGIN
SELECT SEQ_MuestraAnual.NEXTVAL INTO NUMERO FROM DUAL;
:NEW.idMuestraAnual :=NUMERO;
END;
/
/*LLAVES FORANEAS*/
ALTER TABLE Indicador
ADD FOREIGN KEY( idRecurso ) REFERENCES Recurso ( idRecurso );
ALTER TABLE EstacionMuestreo
ADD FOREIGN KEY( idZona ) REFERENCES Zona ( idZona );
ALTER TABLE MuestraMensual
ADD FOREIGN KEY( idIndicador ) REFERENCES Indicador ( idIndicador );
ALTER TABLE MuestraAnual
ADD FOREIGN KEY( idEstacionMuestreo ) REFERENCES EstacionMuestreo (
idEstacionMuestreo );
ALTER TABLE MuestraAnual
ADD FOREIGN KEY( idIndicador ) REFERENCES Indicador ( idIndicador );
INSERT INTO Zona ( idZona , NombreZona , TipoZona ) VALUES (1, ‘Canal Rio Negro’, ‘Cuenca’);
INSERT INTO Zona ( idZona , NombreZona , TipoZona ) VALUES (2, ‘Canal torca’, ‘Cuenca’);
INSERT INTO Zona ( idZona , NombreZona , TipoZona ) VALUES (3, ‘Sector Urbano’, ‘Area Influencia’);
INSERT INTO Zona ( idZona , NombreZona , TipoZona ) VALUES (4, ‘Canal Rio Grande’, ‘Cuenca’);
INSERT INTO Zona ( idZona , NombreZona , TipoZona ) VALUES (5, ‘Perimetro Urbano’, ‘Area Influencia’);
INSERT INTO Zona ( idZona , NombreZona , TipoZona ) VALUES (6, ‘Sector Industria’, ‘IndustriaControlada’);
INSERT INTO Zona ( idZona , NombreZona , TipoZona ) VALUES (7, ‘SectorRural’, ‘Area Influencia’);

/****** Object: Table Recurso ******/
INSERT INTO Recurso ( idRecurso , NombreRecurso ) VALUES (6, ‘Agua’);
INSERT INTO Recurso ( idRecurso , NombreRecurso ) VALUES (7, ‘Aire’);
INSERT INTO Recurso ( idRecurso , NombreRecurso ) VALUES (8, ‘Fauna’);
INSERT INTO Recurso ( idRecurso , NombreRecurso ) VALUES (9, ‘Suelo’);
INSERT INTO Recurso ( idRecurso , NombreRecurso ) VALUES (10, ‘Vegetación y Arbolado’);
commit;

CREATE SEQUENCE SEQ_RECURSO
MINVALUE 11
MAXVALUE 1000000
START WITH 11
INCREMENT BY 1;
CREATE OR REPLACE TRIGGER TR_RECURSO
BEFORE INSERT ON RECURSO FOR EACH ROW
DECLARE
NUMERO NUMBER;
BEGIN
SELECT SEQ_RECURSO.NEXTVAL INTO NUMERO FROM DUAL;
:NEW.idRECURSO :=NUMERO;
END;
/
INSERT INTO Indicador ( idIndicador , idRecurso , NombreIndicador , Sigla
, TipoIndicador , Ambito , Descripcion ) VALUES (100, 6, ‘Agua Superficial
Indicadores en Corrientes, Canal Torca’, ‘WQI Torca’, ‘Calidad’, N’Cuenca’,
N’Agua Superficial Indicadores en Corrientes (Por Cuenca). La Secretaria Distrital
de Ambiente luego de un estudio realizado, teniendo en cuenta los monitoreos
realizados en cada uno de los ríos de la ciudad y las series históricas
de caracterizaciones proporcionadas por la Red de Calidad Hídrica de Bogotá
-RCHB, estableció que el índice más apropiado para representar de manera
clara y entendible la calidad de las corrientes que atraviesan la ciudad es el
índice de calidad creado por el Consejo Canadiense del Ministerio de Ambiente
CCME- Water Quality Indicator WQI’);
INSERT INTO Indicador ( idIndicador , idRecurso , NombreIndicador , Sigla
, TipoIndicador , Ambito , Descripcion ) VALUES (110, 6, ‘Carga Contaminante
de Matería Orgánica {DBO5, Demanda Biológica de Oxigeno}’, ‘CDBOI’,
‘Control Calidad Ambiental’, ‘Municipal’, ‘Este indicador hace referencia a la
mediana estadística anual de la carga de Contaminante de Materia Orgánica
(DBO5, Demanda Biológica de Oxígeno) vertida por la muestra de industrias
a las que se les realiza control en el marco del programa de seguimiento de
efluentes industriales y usuarios objeto de seguimiento ambiental en el tema
de vertimientos.’);
INSERT INTO Indicador ( idIndicador , idRecurso , NombreIndicador , Sigla
, TipoIndicador , Ambito , Descripcion ) VALUES (120, 6, ‘Agua Residual Tratada
- ART’, ‘ART’, ‘Gestión’, ‘Urbano’, ‘El término tratamiento de aguas es el
conjunto de operaciones unitarias de tipo físico, químico o biológico cuya finalidad
es la eliminación o reducción de la contaminación o las características no
deseables de las aguas, bien sean naturales, de abastecimiento, de proceso o
residuales. La finalidad de estas operaciones es obtener unas aguas con las características
adecuadas al uso que se les vaya a dar, por lo que la combinación
y naturaleza exacta de los procesos varía en función tanto de las propiedades
de las aguas de partida como de la eficiencia de remoción que se quiera dar al
tratamiento, para así llegar a las características deseadas.’);
INSERT INTO Indicador ( idIndicador , idRecurso , NombreIndicador , Sigla
, TipoIndicador , Ambito , Descripcion ) VALUES (130, 6, ‘Carga Contaminante
de Sólidos Suspendidos Totales, en el Sector Industrial’, ‘SSTI’, ‘Calidad
- Estado’, ‘Urbano’, ‘Este indicador hace referencia a la mediana estadística
mensual de la carga de sólidos suspendidos totales vertida por la muestra de
industrias que se les realiza control en el marco del programa de seguimiento
de efluentes industriales y usuarios objeto de seguimiento ambiental en el
tema de vertimientos’);
INSERT INTO Indicador ( idIndicador , idRecurso , NombreIndicador , Sigla
, TipoIndicador , Ambito , Descripcion ) VALUES (200, 7, ‘Dióxido de Azufre
Promedio Anual’, ‘SO2’, ‘Calidad - Estado’, ‘Urbano’, ‘La contaminación atmosférica 
tiene su origen en los gases y partículas transportadas por el aire que, si
alcanzan niveles excesivos, resultan nocivos para la salud humana, las obras
de arte y los ecosistemas.’);
INSERT INTO Indicador ( idIndicador , idRecurso , NombreIndicador , Sigla
, TipoIndicador , Ambito , Descripcion ) VALUES (210, 7, ‘Ozono Promedio 8
horas Anual’, ‘O3’, ‘Calidad - Estado’, ‘Urbano’, ‘El Ozono O3 es un gas azul pálido
que, en las capas bajas de la atmósfera, se origina como consecuencia de
las reacciones entre los óxidos de nitrógeno y los hidrocarburos (gases compuestos
de carbono e hidrógeno principalmente); en presencia de la luz solar.
Es un oxidante fuerte, muy fácil de producir pero a la vez muy fácil de destruir;
es el compuesto más representativo de los compuestos fotoquímicos. Sus
efectos en el sistema respiratorio son de cuidado ya que es un gas altamente
oxidante e irritante.’);
INSERT INTO Indicador ( idIndicador , idRecurso , NombreIndicador , Sigla
, TipoIndicador , Ambito , Descripcion ) VALUES (300, 9, ‘Determinantes Ambientales
Emitidas en Instrumentos de Gestión del Suelo’, ‘DAEIGS’, ‘Calidad’,
‘Urbano’, ‘La Subdirección de Ecourbanismo y Gestión Ambiental Empresarial
de la Secretaria Distrital de Ambiente genera lineamientos ambientales según
la normatividad vigente para el desarrollo de los instrumentos de planeamiento
urbano, estos determinantes son requisitos para el diseño, construcción, operación
e incorporación de nuevos suelos al perímetro urbano o su re-desarrollo
en áreas subutilizadas. Así mismo, emite conceptos sobre los proyectos a formular
y construir en los procesos de regularización y legalización de barrios.’);
INSERT INTO Indicador ( idIndicador , idRecurso , NombreIndicador , Sigla
, TipoIndicador , Ambito , Descripcion ) VALUES (310, 9, ‘Disposición
de Escombros contaminados en el Relleno Sanitario Doña Juana’, ‘DERSDJ’,
‘Gestión’, ‘Urbano’, ‘Este indicador nos da a conocer la cantidad de escombros
contaminados con residuos sóloidos convencionales y/o ordinarios que son
dispuestos en el Relleno Sanitario Doña Juana, provenientes de la atención y
limpieza de puntos criticos.’);
INSERT INTO Indicador ( idIndicador , idRecurso , NombreIndicador , Sigla
, TipoIndicador , Ambito , Descripcion ) VALUES (320, 9, ‘Disposición de
Residuos en el Relleno Sanitario Doña Juana’, ‘DRRSDJ’, ‘Gestión’, ‘Urbano’,
‘Los residuos sólidos, comúnmente llamados basuras, se han convertido en un
factor que amenaza la salud humana y el medio ambiente por su alto volumen
de generación en las ciudades.’);
INSERT INTO Indicador ( idIndicador , idRecurso , NombreIndicador , Sigla
, TipoIndicador , Ambito , Descripcion ) VALUES (400, 8, ‘Número de Especímenes
de la Fauna Silvestre Recuperados’, ‘NEFSR’, ‘Gestión’, ‘Urbano’, ‘El
tráfico y la tenencia ilegal de fauna silvestre, constituyen dos eslabones de una
cadena de aprovechamiento ilegal de este recurso que ha llevado a que muchas
de nuestras especies se encuentren amenazadas de extinción.’);
INSERT INTO Indicador ( idIndicador , idRecurso , NombreIndicador , Sigla
, TipoIndicador , Ambito , Descripcion ) VALUES (500, 9, ‘Árboles Plantados’,
‘AP’, ‘Gestión’, ‘Urbano’, ‘El indicador representa el avance en el número
de árboles plantados por el Jardín Botánico de Bogotá José Celestino Mutis, a 
través de convenios con entidades INTEGEReresadas en participar de procesos
de arborización urbana, gestión con participación ciudadana e institucional y
plantación directa.’);
commit;
INSERT INTO EstacionMuestreo ( idEstacionMuestreo , idZona , Nombre ,Ubicación , Longitud ) VALUES (49, 1, ‘Tramo 1 ‘, N’Regadera’, 1);
INSERT INTO EstacionMuestreo ( idEstacionMuestreo , idZona , Nombre ,Ubicación , Longitud ) VALUES (50, 1, ‘Tramo2’, ‘Yomasa Doña Juana’, 4);
INSERT INTO EstacionMuestreo ( idEstacionMuestreo , idZona , Nombre, Ubicación , Longitud ) VALUES (51, 1, ‘Tramo3’, ‘Doña Juana Barrio Mexico San Benito Makro Autopista’, 14);
INSERT INTO EstacionMuestreo ( idEstacionMuestreo , idZona , Nombre ,Ubicación , Longitud ) VALUES (52, 1, ‘Tramo4’, ‘Makro Autopista Sur Transversal86 Puente la Independencia’, 14);
INSERT INTO EstacionMuestreo ( idEstacionMuestreo , idZona , Nombre ,Ubicación , Longitud ) VALUES (53, 2, ‘Tramo1’, ‘Canal El Cedro’, 6);
INSERT INTO EstacionMuestreo ( idEstacionMuestreo , idZona , Nombre ,Ubicación , Longitud ) VALUES (54, 2, ‘Tramo2’, ‘Makro 193’, 7);
INSERT INTO EstacionMuestreo ( idEstacionMuestreo , idZona , Nombre ,Ubicación , Longitud ) VALUES (55, 4, ‘Tramo1’, ‘Parque Santander’, 1);
INSERT INTO EstacionMuestreo ( idEstacionMuestreo , idZona , Nombre ,Ubicación , Longitud ) VALUES (56, 4, ‘Tramo2’, ‘Arzobispo Carrera 7 Carrera 30 Calle 53’, 2);
INSERT INTO EstacionMuestreo ( idEstacionMuestreo , idZona , Nombre ,Ubicación , Longitud ) VALUES (57, 4, ‘Tramo3’, ‘Carrefour Av 68 Transversal 91 Planta Salitre Salitre ‘, 13);
INSERT INTO EstacionMuestreo ( idEstacionMuestreo , idZona , Nombre ,Ubicación , Longitud ) VALUES (58, 3, ‘Relleno Sanitario’, ‘Yomasa Doña Juana’,10);
INSERT INTO EstacionMuestreo ( idEstacionMuestreo , idZona , Nombre ,Ubicación , Longitud ) VALUES (59, 3, ‘Perimetro Urbano’, ‘Perimetro Urbano’,100);
INSERT INTO EstacionMuestreo ( idEstacionMuestreo , idZona , Nombre, Ubicación , Longitud ) VALUES (60, 6, ‘Industrias Controladas’, ‘PerimetroUrbano’, 25);
commit;

INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (1, 120, 2004, 7, 10);
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (2, 120, 2004, 8, 9);
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (3, 120, 2004, 9, 9);
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (4, 120, 2004, 10, 12);
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (5, 120, 2004, 11, 11);
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (6, 120, 2004, 12, 11);
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (7, 120, 2005, 1, 9);
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (8, 120, 2005, 2, 10);
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (9, 120, 2005, 3, 10);
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (10, 120, 2005, 4, 10);
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (11, 120, 2005, 5, 11);
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (12, 120, 2005, 6, 10);
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (13, 120, 2005, 7, 10);
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (14, 120, 2005, 8, 11 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (15, 120, 2005, 9, 10 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (16, 120, 2005, 10, 11 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (17, 120, 2005, 11, 11 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (18, 120, 2005, 12, 11 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (19, 120, 2006, 1, 11 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (20, 120, 2006, 2, 9 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (21, 120, 2006, 3, 11 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (22, 120, 2006, 4, 13 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (23, 120, 2006, 5, 18 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (24, 120, 2006, 6, 12 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (25, 120, 2006, 7, 10 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (26, 120, 2006, 8, 10 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (27, 120, 2006, 9, 10 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (28, 120, 2006, 10, 11 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (29, 120, 2006, 11, 11 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (30, 120, 2006, 12, 10 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (31, 120, 2007, 1, 10 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (32, 120, 2007, 2, 10 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (33, 120, 2007, 3, 11 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (34, 120, 2007, 4, 10 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (35, 120, 2007, 5, 11 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (36, 120, 2007, 6, 10 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (37, 120, 2007, 7, 10 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (38, 120, 2007, 8, 11 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (39, 120, 2007, 9, 10 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (40, 120, 2007, 10, 12 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (41, 120, 2007, 11, 14 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (42, 120, 2007, 12, 11 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (43, 120, 2008, 1, 11 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (44, 120, 2008, 2, 10 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (45, 120, 2008, 3, 11 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (46, 120, 2008, 4, 10 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (47, 120, 2008, 5, 13 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (48, 120, 2008, 6, 10 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (49, 120, 2008, 7, 11 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (50, 120, 2008, 8, 11 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (51, 120, 2008, 9, 10 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (52, 120, 2008, 10, 10 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (53, 120, 2008, 11, 10 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (54, 120, 2008, 12, 10 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (55, 120, 2009, 1, 10 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (56, 120, 2009, 2, 10 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (57, 120, 2009, 3, 11 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (58, 120, 2009, 4, 11 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (59, 120, 2009, 5, 11 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (60, 120, 2009, 6, 10 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (61, 120, 2009, 7, 11 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (62, 120, 2009, 8, 10 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (63, 120, 2009, 9, 9 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (64, 120, 2009, 10, 10 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (65, 120, 2009, 11, 11 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (66, 120, 2009, 12, 9 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (67, 120, 2010, 1, 11 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (68, 120, 2010, 2, 10 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (69, 120, 2010, 3, 11 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (70, 120, 2010, 4, 11 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (71, 120, 2010, 5, 11 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (72, 120, 2010, 6, 11 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (73, 120, 2010, 7, 11 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (74, 120, 2010, 8, 11 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (75, 120, 2010, 9, 11 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (76, 120, 2010, 10, 11 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (77, 120, 2010, 11, 16 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (78, 120, 2010, 12, 16 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (79, 120, 2011, 1, 11 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (80, 120, 2011, 2, 10 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (81, 120, 2011, 3, 11 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (82, 120, 2011, 4, 19 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (83, 120, 2011, 5, 25 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (84, 120, 2011, 6, 19 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (85, 120, 2011, 7, 10 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (86, 120, 2011, 8, 10 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (87, 120, 2011, 9, 10 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (88, 120, 2011, 10, 11 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (89, 300, 2009, 4, 4 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (90, 300, 2009, 5, 9 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (91, 300, 2009, 6, 16 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (92, 300, 2009, 7, 6 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (93, 300, 2009, 8, 9 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (94, 300, 2009, 9, 8 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (95, 300, 2009, 10, 5 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (96, 300, 2009, 11, 6 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (97, 300, 2009, 12, 5 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (98, 300, 2010, 1, 3 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (99, 300, 2010, 2, 1 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (100, 300, 2010, 3, 6 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (101, 300, 2010, 4, 4 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (102, 300, 2010, 5, 3 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (103, 300, 2010, 6, 5 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (104, 300, 2010, 7, 2 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (105, 300, 2010, 8, 2 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (106, 300, 2010, 9, 2 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (107, 300, 2010, 10, 5 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (108, 300, 2010, 11, 6 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (109, 300, 2010, 12, 7 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (110, 300, 2011, 1, 0 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (111, 300, 2011, 2, 2 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (112, 300, 2011, 3, 4 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (113, 300, 2011, 4, 7 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (114, 300, 2011, 5, 7 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (115, 300, 2011, 6, 1 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (116, 300, 2011, 7, 6 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (117, 300, 2011, 8, 6 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (118, 300, 2011, 9, 6 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (119, 300, 2011, 10, 2 );
INSERT INTO MuestraMensual ( idMuestraMensual , idIndicador , Fecha ,Mes , Valor ) VALUES (120, 300, 2011, 11, 4 );
commit;

INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (1, 59, 200, 1999, 17 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (2, 59, 200, 2000, 17 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (3, 59, 200, 2001, 13 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (4, 59, 200, 2002, 11 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (5, 59, 200, 2003, 11 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (6, 59, 200, 2004, 13 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (7, 59, 200, 2005, 9 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (8, 59, 200, 2006, 6 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (9, 59, 200, 2007, 7 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (10, 59, 200, 2008, 9 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (11, 59, 200, 2009, 8 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (12, 59, 200, 2010, 4 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (13, 59, 210, 2005, 41 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (14, 59, 210, 2006, 10 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (15, 59, 210, 2007, 14 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (16, 59, 210, 2008, 14 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (17, 59, 210, 2009, 14 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (18, 59, 210, 2010, 14 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (19, 60, 110, 2002, 8574 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (20, 60, 110, 2003, 3867 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (21, 60, 110, 2004, 3867 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador 
, Fecha , Valor ) VALUES (22, 60, 110, 2005, 4268 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (23, 60, 110, 2006, 4268 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (24, 60, 110, 2007, 4268 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (25, 60, 110, 2008, 4268 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (26, 60, 110, 2009, 4280 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (27, 60, 110, 2010, 1868 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (28, 60, 130, 2002, 7746 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (29, 60, 130, 2003, 7692 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (30, 60, 130, 2004, 7692 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (31, 60, 130, 2005, 2611 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (32, 60, 130, 2006, 2611 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (33, 60, 130, 2007, 2611 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (34, 60, 130, 2008, 2611 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (35, 60, 130, 2009, 1671 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (36, 60, 130, 2010, 1816 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (37, 58, 310, 2003, 22918 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (38, 58, 310, 2004, 201058 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (39, 58, 310, 2005, 228712 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (40, 58, 310, 2006, 227699 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (41, 58, 310, 2007, 258133 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (42, 58, 310, 2008, 202961 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (43, 58, 310, 2009, 253066 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (44, 58, 310, 2010, 279166 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador 
, Fecha , Valor ) VALUES (45, 58, 320, 2002, 1844020 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (46, 58, 320, 2003, 1837240 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (47, 58, 320, 2004, 1965170 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (48, 58, 320, 2005, 1974240 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (49, 58, 320, 2006, 1960000 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (50, 58, 320, 2007, 2091410 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (51, 58, 320, 2008, 2161720 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (52, 58, 320, 2009, 2096550 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (53, 58, 320, 2010, 2239335 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (54, 59, 500, 1998, 6220 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (55, 59, 500, 1999, 40078 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (56, 59, 500, 2000, 61777 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (57, 59, 500, 2001, 28653 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (58, 59, 500, 2002, 7812 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (59, 59, 500, 2003, 51186 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (60, 59, 500, 2004, 7257 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (61, 59, 500, 2005, 23399 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (62, 59, 500, 2006, 13493 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (63, 59, 500, 2007, 17736 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (64, 59, 500, 2008, 15489 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (65, 59, 500, 2009, 22038 );
INSERT INTO MuestraAnual ( idMuestraAnual , idEstacionMuestreo , idIndicador
, Fecha , Valor ) VALUES (66, 59, 500, 2010, 22314 );
commit;