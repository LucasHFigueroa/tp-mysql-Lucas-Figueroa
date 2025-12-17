
--                        Ejercicio 1 – Crear Base de Datos
CREATE DATABASE IF NOT EXISTS veterinaria_patitas_felices;
USE veterinaria_patitas_felices;  

--                        Ejercicio 2 – Crear tabla duenos

CREATE TABLE duenos (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  telefono VARCHAR(20) NOT NULL, 
  direccion VARCHAR(100)
);

--                        Ejercicio 3 – Crear tabla duenos

CREATE TABLE mascotas (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL,
  especie VARCHAR(30) NOT NULL,
  fecha_nacimiento DATE, 
  id_dueno INT,
  FOREIGN KEY (id_dueno) REFERENCES duenos(id)
);

--                        Ejercicio 4 – Crear tabla veterinarios

CREATE TABLE veterinarios (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  matricula VARCHAR(20)NOT NULL UNIQUE, 
  especialidad VARCHAR(50) NOT NULL
);

--                        Ejercicio 5 – Crear tabla historial_clinico

CREATE TABLE historial_clinico (
  id INT PRIMARY KEY AUTO_INCREMENT,
  id_mascota INT,
  id_veterinario INT,
  fecha_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  descripcion VARCHAR(250) NOT NULL,

  FOREIGN KEY (id_mascota) REFERENCES mascotas(id) ON DELETE CASCADE,
  FOREIGN KEY (id_veterinario) REFERENCES veterinarios(id)
);

--                        Ejercicio 6 – Insertar registros

INSERT INTO duenos (nombre, apellido, telefono, direccion) VALUES
  ('Pedro','Picapiedras', '+5491122334401', 'Piedradura 1960  '),
  ('Homero','Simpson', '+5491122334402', 'Av. Siempre Viva 742'),
  ('Shaggy','Rogers', '+5491122334403', 'Maquina del Misterio 123')
;

INSERT INTO mascotas (nombre, especie, fecha_nacimiento, id_dueno) VALUES
  ('Dino','Dinosaurio','1960-10-21', 1),  
  ('Ayudante de Santa','Perro','1989-12-17', 2),
  ('Scooby-Doo','Perro','1968-09-13', 3)
;

INSERT INTO veterinarios (nombre, apellido, matricula, especialidad) VALUES
  ('Mario', 'Socolinsky', 'MAT-100', 'Cachorros'),
  ('Raul', 'Portal', 'MAT-200', 'Cardiología')
;

INSERT INTO historial_clinico (id_mascota, id_veterinario, descripcion) VALUES
  (1, 1, 'Vacunación completa'),
  (2, 2, 'Revisión del corazón con agujerito'),
  (3, 2, 'Electrocardiograma, paciente con mucho miedo')
;

--                        Ejercicio 7 – Actualizar registros

UPDATE duenos 
SET direccion = 'Calle falsa 123'
WHERE id = 2; 


UPDATE veterinarios
SET especialidad = 'Urología'
WHERE matricula = 'MAT-200';


UPDATE historial_clinico
SET descripcion = 'Vacunación completa y desparasitación'
WHERE id = 1;

--                        Ejercicio 8 – Eliminar registros

DELETE FROM mascotas WHERE id = 1;

SELECT * FROM historial_clinico;

--                        Ejercicio 9 – JOIN simple

SELECT m.nombre, m.especie, CONCAT(d.nombre, ' ', d.apellido) AS dueno 
FROM mascotas m 
JOIN duenos d ON m.id_dueno = d.id;

--                        Ejercicio 10 – JOIN múltiple con historial

SELECT 
  m.nombre AS Mascota,
  m.especie,
  CONCAT(d.nombre, ' ', d.apellido) AS Dueno,
  CONCAT(v.nombre, ' ', v.apellido) AS Veterinario,
  h.fecha_registro,
  h.descripcion
FROM historial_clinico h
JOIN mascotas m ON h.id_mascota = m.id
JOIN duenos d ON m.id_dueno = d.id
JOIN veterinarios v ON h.id_veterinario = v.id
ORDER BY h.fecha_registro DESC;
