'''
SPRINT DE ENTREGA:

Se solicita como entregable de este Sprint la implementación final de todos los conceptos vistos durante el Módulo 2 de Bases de datos.
Tu aplicación necesita una base de datos para sistematizar el funcionamiento del soporte ‘En qué puedo ayudarte’. El soporte lo realizan operarios.
¿Cada vez que un usuario utiliza el soporte ‘’En qué puedo ayudarte?’ se le asigna un operario para ayudarlo con su problema.
Luego de esto, el usuario responde una encuesta donde califica al operario con una nota de 1 a 7, junto a un pequeño comentario sobre su atención.
Queremos sistematizar esta información en una base de datos.


Cada usuario tiene información sobre: nombre, apellido, edad, correo electrónico y número de veces que ha utilizado la aplicación (por defecto es 1, pero al insertar los registros debe indicar un número manual). 

Cada operario tiene información sobre: nombre, apellido, edad, correo electrónico y número de veces que ha servido de soporte (por defecto es 1, pero al insertar los registros debe indicar un número manual). 

Cada vez que se realiza un soporte, se reconoce quien es el operario, el cliente, la fecha y la evaluación que recibe el soporte.

Diagrame el modelo entidad relación.

- Construya una base de datos. 
- Asigne un usuario con todos los privilegios
- Construya las tablas. 
- Agregue 5 usuarios
- Agregue 5 operadores 
- Agregue 10 operaciones de soporte. 

Los datos debe crearlos según su imaginación.

- Seleccione las 3 operaciones con mejor evaluación.
- Seleccione las 3 operaciones con menos evaluación.
- Seleccione al operario que más soportes ha realizado.
- Seleccione al cliente que menos veces ha utilizado la aplicación.
- Agregue 10 años a los tres primeros usuarios registrados.
- Renombre todas las columnas ‘correo electrónico’. El nuevo nombre debe ser email.
- Seleccione solo los operarios mayores de 20 años.


A modo de entrega, se debe disponer un documento Word o PDF en el que se indique: 

- Ruta del repositorio en GitHub

Consideraciones adicionales

- El código debe estar debidamente indentado
- El formato del documento Word queda a criterio del equipo.

'''


-- Construya una base de datos. Asigne un usuario con todos los privilegios. Construya las tablas.
CREATE DATABASE sprint_individual;
-- CREAR USUARIO
CREATE USER ******* IDENTIFIED BY '*******';
-- ASIGNAR PERMISOS LECTURA Y ESCRITURA TODAS LA TABLAS
GRANT SELECT, INSERT, UPDATE, CREATE ON sprint_individual . * TO *******;
-- ACTUALIZAR PERMISOS
FLUSH PRIVILEGES;
-- VERIFICAR USUARIO
SELECT SESSION_USER();
--USAR BD 'appTest'
USE sprint_individual;

-- Cada usuario tiene información sobre: nombre, apellido, edad, correo electrónico y número de veces que ha utilizado la aplicación (por defecto es 1, pero al insertar los registros debe indicar un número manual).
CREATE TABLE usuario(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30) NOT NULL,
    edad INT,
    correo VARCHAR(60) NOT NULL,
    uso_aplicacion INT DEFAULT 1

);
-- Cada operario tiene información sobre: nombre, apellido, edad, correo electrónico y número de veces que ha servido de soporte (por defecto es 1, pero al insertar los registros debe indicar un número manual).
CREATE TABLE operario(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30) NOT NULL,
    edad INT,
    correo VARCHAR(60) NOT NULL,
    interacciones_soporte INT DEFAULT 1

);
-- Cada vez que se realiza un soporte, se reconoce quien es el operario, el cliente, la fecha y la evaluación que recibe el soporte.
CREATE TABLE soporte(
    id_operario INT NOT NULL,
    id_usuario INT NOT NULL,
    fecha DATETIME NOT NULL,
    evaluacion INT NOT NULL,
    CONSTRAINT fk_soporte_operario FOREIGN KEY (id_operario) REFERENCES operario(id),
    CONSTRAINT fk_soporte_usuario FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);

--  Los datos debe crearlos según su imaginación
--  Agregue 5 usuarios
INSERT INTO 
usuario 
VALUES
(NULL,'NombreUsuario1','ApellidoUsuario1',30,'usuario1@dato.com',5),
(NULL,'NombreUsuario2','ApellidoUsuario2',30,'usuario2@dato.com',3),
(NULL,'NombreUsuario3','ApellidoUsuario3',30,'usuario3@dato.com',4),
(NULL,'NombreUsuario4','ApellidoUsuario4',30,'usuario4@dato.com',6),
(NULL,'NombreUsuario5','ApellidoUsuario5',30,'usuario5@dato.com',7);

-- 5 operadores
INSERT INTO 
operario 
VALUES
(NULL,'NombreOperario1','ApellidoOperario1',30,'operario1@dato.com',6),
(NULL,'NombreOperario2','ApellidoOperario2',30,'operario2@dato.com',8),
(NULL,'NombreOperario3','ApellidoOperario3',30,'operario3@dato.com',20),
(NULL,'NombreOperario4','ApellidoOperario4',30,'operario4@dato.com',14),
(NULL,'NombreOperario5','ApellidoOperario5',30,'operario5@dato.com',2);

-- 10 operaciones de soporte
INSERT INTO 
soporte 
VALUES
(1,1,'2020-03-26',6),
(1,2,'2020-03-26',7),
(2,3,'2020-03-28',6),
(2,4,'2020-04-02',5),
(3,5,'2020-04-03',5),
(3,1,'2020-04-03',6),
(4,2,'2020-04-03',7),
(4,3,'2020-04-06',7),
(5,4,'2020-05-03',7),
(5,5,'2020-05-03',7);

-- Seleccione las 3 operaciones con mejor evaluación.
SELECT O.nombre, S.evaluacion 
FROM soporte S, operario O
WHERE S.id_operario = O.id
GROUP BY O.nombre, S.evaluacion 
ORDER BY S.evaluacion DESC
LIMIT 3;

-- Seleccione las 3 operaciones con menos evaluación.
SELECT O.nombre, S.evaluacion 
FROM soporte S, operario O
WHERE S.id_operario = O.id
GROUP BY O.nombre, S.evaluacion 
ORDER BY S.evaluacion ASC
LIMIT 3;

-- Seleccione al operario que más soportes ha realizado.
SELECT nombre, interacciones_soporte
FROM operario
WHERE interacciones_soporte = (SELECT MAX(interacciones_soporte) FROM operario);

-- Seleccione al cliente que menos veces ha utilizado la aplicación.
SELECT nombre, uso_aplicacion
FROM usuario
WHERE uso_aplicacion = (SELECT MIN(uso_aplicacion) FROM usuario);

-- Agregue 10 años a los tres primeros usuarios registrados.
UPDATE usuario
SET edad = edad + 10
WHERE id 
IN (1,2,3);

-- Renombre todas las columnas ‘correo electrónico’. El nuevo nombre debe ser email. 
ALTER TABLE usuario
CHANGE correo email VARCHAR(60) NOT NULL;

-- Seleccione solo los operarios mayores de 20 años.
SELECT * 
FROM operario
WHERE edad > 20;
