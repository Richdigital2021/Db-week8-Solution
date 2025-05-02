-- DROP DATABASE IF EXISTS clinic_db;
CREATE DATABASE IF NOT EXISTS clinic_db;
USE clinic_db;

-- Patients Table
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    gender ENUM('Male', 'Female', 'Other'),
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE
);

-- Doctors Table
CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(100),
    phone VARCHAR(15) UNIQUE,
    email VARCHAR(100) UNIQUE
);

-- Services Table
CREATE TABLE services (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    service_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    fee DECIMAL(10, 2) NOT NULL
);

-- Doctor_Services Table (MANY-TO-MANY)
CREATE TABLE doctor_services (
    doctor_id INT,
    service_id INT,
    PRIMARY KEY (doctor_id, service_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE CASCADE,
    FOREIGN KEY (service_id) REFERENCES services(service_id) ON DELETE CASCADE
);

-- Appointments Table
CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    service_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    notes TEXT,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    FOREIGN KEY (service_id) REFERENCES services(service_id)
);

-- SAMPLE DATA

-- Patients
INSERT INTO patients (first_name, last_name, date_of_birth, gender, phone, email)
VALUES 
('John', 'Doe', '1990-05-12', 'Male', '08012345678', 'john@example.com'),
('Jane', 'Smith', '1985-07-30', 'Female', '08087654321', 'jane@example.com');

-- Doctors
INSERT INTO doctors (first_name, last_name, specialization, phone, email)
VALUES 
('Dr. Alice', 'Williams', 'Cardiologist', '08011112222', 'alice@clinic.com'),
('Dr. Bob', 'Johnson', 'Dermatologist', '08033334444', 'bob@clinic.com');

-- Services
INSERT INTO services (service_name, description, fee)
VALUES
('Cardiac Consultation', 'Consultation with a cardiologist', 150.00),
('Skin Treatment', 'Basic skin consultation and treatment', 100.00),
('General Checkup', 'Routine health check', 80.00);

-- Doctor-Services Mapping
INSERT INTO doctor_services (doctor_id, service_id)
VALUES
(1, 1), -- Alice offers Cardiac Consultation
(2, 2), -- Bob offers Skin Treatment
(1, 3), -- Alice offers General Checkup
(2, 3); -- Bob offers General Checkup

-- Appointments
INSERT INTO appointments (patient_id, doctor_id, service_id, appointment_date, status, notes)
VALUES
(1, 1, 1, '2025-05-03 09:00:00', 'Scheduled', 'First visit'),
(2, 2, 2, '2025-05-03 11:00:00', 'Scheduled', 'Skin rash for 2 weeks');

-- 1. List all appointments with patient and doctor details
SELECT 
    a.appointment_id, 
    p.first_name AS patient, 
    d.first_name AS doctor, 
    s.service_name, 
    a.appointment_date, 
    a.status
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id
JOIN services s ON a.service_id = s.service_id;

-- 2. Show all doctors and their services
SELECT 
    d.first_name AS doctor, 
    s.service_name
FROM doctor_services ds
JOIN doctors d ON ds.doctor_id = d.doctor_id
JOIN services s ON ds.service_id = s.service_id;

-- 3. Count number of appointments per doctor
SELECT 
    d.first_name, 
    COUNT(a.appointment_id) AS total_appointments
FROM doctors d
LEFT JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id;

-- 4. List patients with multiple appointments
SELECT 
    p.first_name, 
    p.last_name, 
    COUNT(*) AS appointment_count
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
GROUP BY p.patient_id
HAVING COUNT(*) > 1;

-- 5. Find available services that no doctor currently offers
SELECT s.service_name
FROM services s
LEFT JOIN doctor_services ds ON s.service_id = ds.service_id
WHERE ds.doctor_id IS NULL;
