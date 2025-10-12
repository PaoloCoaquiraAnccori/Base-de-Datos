CREATE DATABASE Hospital;
GO

USE Hospital;
GO

CREATE TABLE Medicos (
    IdMedico INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    Especialidad NVARCHAR(100) NOT NULL
);

CREATE TABLE Pacientes (
    IdPaciente INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    DNI NVARCHAR(20) UNIQUE,
    Telefono NVARCHAR(20)
);

CREATE TABLE Medicamentos (
    IdMedicamento INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    Tipo NVARCHAR(50),
    Stock INT NOT NULL
);

CREATE TABLE Citas (
    IdCita INT PRIMARY KEY IDENTITY(1,1),
    Fecha DATETIME DEFAULT GETDATE(),
    IdPaciente INT,
    IdMedico INT,
    FOREIGN KEY (IdPaciente) REFERENCES Pacientes(IdPaciente),
    FOREIGN KEY (IdMedico) REFERENCES Medicos(IdMedico)
);

CREATE TABLE Recetas (
    IdReceta INT PRIMARY KEY IDENTITY(1,1),
    IdCita INT,
    IdMedicamento INT,
    Cantidad INT NOT NULL,
    Indicaciones NVARCHAR(200),
    FOREIGN KEY (IdCita) REFERENCES Citas(IdCita),
    FOREIGN KEY (IdMedicamento) REFERENCES Medicamentos(IdMedicamento)
);

INSERT INTO Medicos (Nombre, Especialidad) VALUES ('Dr. Juan Perez', 'Cardiologia');
INSERT INTO Medicos (Nombre, Especialidad) VALUES ('Dra. Maria Lopez', 'Pediatria');

INSERT INTO Pacientes (Nombre, DNI, Telefono) VALUES ('Carlos Gomez', '12345678', '999111222');
INSERT INTO Pacientes (Nombre, DNI, Telefono) VALUES ('Ana Torres', '87654321', '988776655');

INSERT INTO Medicamentos (Nombre, Tipo, Stock) VALUES ('Paracetamol', 'Analgesico', 200);
INSERT INTO Medicamentos (Nombre, Tipo, Stock) VALUES ('Amoxicilina', 'Antibiotico', 150);

INSERT INTO Citas (IdPaciente, IdMedico) VALUES (1, 1);
INSERT INTO Citas (IdPaciente, IdMedico) VALUES (2, 2);

INSERT INTO Recetas (IdCita, IdMedicamento, Cantidad, Indicaciones) VALUES (1, 1, 10, 'Tomar cada 8 horas');
INSERT INTO Recetas (IdCita, IdMedicamento, Cantidad, Indicaciones) VALUES (2, 2, 5, 'Tomar cada 12 horas');

SELECT P.Nombre AS Paciente, M.Nombre AS Medico, C.Fecha, R.Cantidad, Med.Nombre AS Medicamento, R.Indicaciones
FROM Recetas R
JOIN Citas C ON R.IdCita = C.IdCita
JOIN Pacientes P ON C.IdPaciente = P.IdPaciente
JOIN Medicos M ON C.IdMedico = M.IdMedico
JOIN Medicamentos Med ON R.IdMedicamento = Med.IdMedicamento;
