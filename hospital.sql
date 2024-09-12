CREATE TABLE doctors (
    doctor_id SERIAL PRIMARY KEY,
    doctor_name VARCHAR(100),
    specialty VARCHAR(50)
);

CREATE TABLE patients (
    patient_id SERIAL PRIMARY KEY,
    patient_name VARCHAR(100),
    doctor_id INT REFERENCES doctors(doctor_id)
);

CREATE TABLE appointments (
    appointment_id SERIAL PRIMARY KEY,
    patient_id INT REFERENCES patients(patient_id),
    appointment_date DATE
);


-- Insertar datos en la tabla doctors
INSERT INTO doctors (doctor_name, specialty)
VALUES 
('Dr. Smith', 'Cardiology'), 
('Dr. Johnson', 'Neurology'), 
('Dr. Williams', 'Orthopedics'),
('Dr. Brown', 'Pediatrics');

-- Insertar datos en la tabla patients
INSERT INTO patients (patient_name, doctor_id)
VALUES 
('John Doe', 1), 
('Jane Doe', 2), 
('Tom Brown', 3),
('Lucy Black', 1),
('Mike White', 4);

-- Insertar datos en la tabla appointments
INSERT INTO appointments (patient_id, appointment_date)
VALUES 
(1, '2024-09-01'), 
(2, '2024-09-02'),
(3, '2024-09-03'),
(5, '2024-09-05');
