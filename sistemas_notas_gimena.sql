DROP DATABASE  sistema_notas_gimena;

CREATE DATABASE IF NOT EXISTS sistema_notas_gimena;
USE sistema_notas_gimena;

-- Tabla de usuarios
CREATE TABLE usuarios (
    codigo VARCHAR(7) PRIMARY KEY,
    contrasena VARCHAR(255) NOT NULL,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    rol VARCHAR(50) NOT NULL
);

-- Tabla de cursos (cada curso tiene un docente)
CREATE TABLE cursos (
    codigo VARCHAR(6) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    codigo_docente VARCHAR(7) NOT NULL,
    FOREIGN KEY (codigo_docente) REFERENCES usuarios(codigo)
    ON DELETE CASCADE
);

-- Tabla de matrículas (relación curso-estudiante)
CREATE TABLE matriculas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo_estudiante VARCHAR(7) NOT NULL,
    codigo_curso VARCHAR(6) NOT NULL,

    FOREIGN KEY (codigo_curso) REFERENCES cursos(codigo)
    ON DELETE CASCADE,
    FOREIGN KEY (codigo_estudiante) REFERENCES usuarios(codigo)
    ON DELETE CASCADE,
    UNIQUE (codigo_estudiante, codigo_curso)
);

-- Tabla de notas (cada fila pertenece a una matrícula)
CREATE TABLE notas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_matricula INT UNIQUE,
    -- Primera mitad
    p1 FLOAT,
    p2 FLOAT,
    p3 FLOAT,
    p4 FLOAT,
    ti FLOAT,
    ep FLOAT,
    -- Segunda mitad
    p1_2 FLOAT,
    p2_2 FLOAT,
    p3_2 FLOAT,
    p4_2 FLOAT,
    ti_2 FLOAT,
    ep_2 FLOAT,
    -- Final
    ec FLOAT,
    nota_final FLOAT,
    FOREIGN KEY (id_matricula) REFERENCES matriculas(id)
    ON DELETE CASCADE
);

-- Insertar usuarios de ejemplo
INSERT INTO usuarios(codigo, contrasena, nombres, apellidos, rol) VALUES
    ('A00001G', 'admin123', 'Gimena Cristel', 'Mendoza Ricse', 'administrador'),
    ('D00001J', 'docente1', 'Jose Luis', 'Lopez Ramos', 'docente'),
    ('E00001M', 'estudiante1', 'Maria Ana', 'Rodriguez Huaman', 'estudiante');

INSERT INTO cursos (codigo, nombre, codigo_docente) VALUES
('CUR001', 'Matemática Básica', 'D00001J');

INSERT INTO matriculas (codigo_estudiante, codigo_curso) VALUES
('E00001M', 'CUR001');

-- Verificar contenido inicial
SELECT * FROM usuarios;
SELECT * FROM cursos;
SELECT * FROM matriculas;

