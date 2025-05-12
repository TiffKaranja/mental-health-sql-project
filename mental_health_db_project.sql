create schema mentalhealthassignment;

-- Create the mental_health_patients table
CREATE TABLE mental_health_patients (
    patient_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    phone_number VARCHAR(15),
    email VARCHAR(100),
    address VARCHAR(255),
    diagnosis VARCHAR(100)
);

select * from mental_health_patients;


-- Insert 15 rows into the mental_health_patients table


INSERT INTO mental_health_patients (first_name, last_name, age, gender, phone_number, email, address, diagnosis)
VALUES
('John', 'Doe', 29, 'Male', '0712345678', 'john.doe@example.com', '123 Main St, Nairobi', 'Depression'),
('Jane', 'Smith', 34, 'Female', '0723456789', 'jane.smith@example.com', '456 Oak Rd, Mombasa', 'Anxiety'),
('Paul', 'Otieno', 40, 'Male', '0734567890', 'paul.otieno@example.com', '789 Pine Ave, Kisumu', 'Bipolar Disorder'),
('Mary', 'Okello', 27, 'Female', '0745678901', 'mary.okello@example.com', '321 Cedar Blvd, Nairobi', 'Schizophrenia'),
('Susan', 'Njeri', 50, 'Female', '0756789012', 'susan.njeri@example.com', '654 Maple Dr, Mombasa', 'PTSD'),
('James', 'Mwangi', 60, 'Male', '0767890123', 'james.mwangi@example.com', '987 Elm St, Kisumu', 'OCD'),
('Rebecca', 'Karanja', 23, 'Female', '0778901234', 'rebecca.karanja@example.com', '123 Birch Ln, Nairobi', 'Depression'),
('Samuel', 'Kimani', 32, 'Male', '0789012345', 'samuel.kimani@example.com', '432 Willow Rd, Mombasa', 'Generalized Anxiety Disorder'),
('Grace', 'Achieng', 45, 'Female', '0790123456', 'grace.achieng@example.com', '789 Cedar St, Kisumu', 'Bipolar Disorder'),
('Peter', 'Juma', 28, 'Male', '0801234567', 'peter.juma@example.com', '654 Oak Blvd, Nairobi', 'Post-traumatic Stress Disorder');

-- Create the mental_health_doctors table
CREATE TABLE mental_health_doctors (
    doctor_id SERIAL PRIMARY KEY,
    doctor_name VARCHAR(100),
    specialization VARCHAR(50)
);

-- Insert 5 rows into the mental_health_doctors table
INSERT INTO mental_health_doctors (doctor_name, specialization)
VALUES
('Dr. Wilson', 'Psychiatrist'),
('Dr. Smith', 'Psychologist'),
('Dr. Allen', 'Psychiatrist'),
('Dr. White', 'Therapist'),
('Dr. Johnson', 'Psychologist');

-- Create the mental_health_visits table

CREATE TABLE mental_health_visits (
    visit_id SERIAL PRIMARY KEY,
    patient_id INT REFERENCES mental_health_patients(patient_id),
    doctor_id INT REFERENCES mental_health_doctors(doctor_id),
    visit_date DATE,
    visit_type VARCHAR(50),
    notes TEXT
);

-- Insert 10 rows into the mental_health_visits table


INSERT INTO mental_health_visits (patient_id, doctor_id, visit_date, visit_type, notes)
VALUES
(1, 1, '2024-01-15', 'Consultation', 'Initial consultation for depression'),
(2, 2, '2024-01-16', 'Follow-up', 'Ongoing treatment for anxiety'),
(3, 1, '2024-02-01', 'Consultation', 'Assessment for bipolar disorder'),
(4, 3, '2024-02-02', 'Emergency', 'Schizophrenia crisis intervention'),
(5, 4, '2024-02-10', 'Follow-up', 'Ongoing therapy for PTSD'),
(6, 5, '2024-02-15', 'Consultation', 'Initial session for OCD'),
(7, 1, '2024-03-01', 'Follow-up', 'Follow-up on depression treatment'),
(8, 2, '2024-03-05', 'Consultation', 'Generalized anxiety disorder diagnosis'),
(9, 3, '2024-03-10', 'Emergency', 'Emergency care for bipolar disorder'),
(10, 4, '2024-03-12', 'Follow-up', 'PTSD recovery follow-up');



select * from mental_health_patients;

select * from mental_health_doctors;

select * from mental_health_visits;

-- Joins--


-- 1.	List all patients and the names of the doctors they saw during their last visit.

SELECT 
    p.first_name,
    p.last_name,
    d.doctor_name,
    v.visit_date
FROM 
    mental_health_patients p
JOIN 
    mental_health_visits v ON p.patient_id = v.patient_id
JOIN 
    mental_health_doctors d ON v.doctor_id = d.doctor_id
WHERE 
    v.visit_date = (
        SELECT MAX(v2.visit_date)
        FROM mental_health_visits v2
        WHERE v2.patient_id = p.patient_id
    )
ORDER BY 
    p.patient_id;


-- 2.	List all employees in the “Psychiatrist” specialty and the patients they are treating.
SELECT 
    d.doctor_name,
    d.specialization,
    p.first_name,
    p.last_name,
    v.visit_date
FROM 
    mental_health_doctors d
JOIN 
    mental_health_visits v ON d.doctor_id = v.doctor_id
JOIN 
    mental_health_patients p ON v.patient_id = p.patient_id
WHERE 
    d.specialization = 'Psychiatrist'
ORDER BY 
    d.doctor_name, v.visit_date;


-- 3.	Show all patients and the doctors they’ve visited, including patients who haven’t seen any doctor.
SELECT 
    p .first_name,
    p.last_name,
    d.doctor_name,
    v.visit_date
FROM 
    mental_health_patients p
LEFT JOIN 
    mental_health_visits v ON p.patient_id = v.patient_id
LEFT JOIN 
    mental_health_doctors d ON v.doctor_id = d.doctor_id
ORDER BY 
    p.patient_id;

-- 5.	List all visits and the patients associated with them, including projects that have no associated patient (use RIGHT JOIN).
SELECT 
    v.visit_id,
    v.visit_date,
    v.visit_type,
    p.first_name,
    p.last_name
FROM 
    mental_health_patients p
RIGHT JOIN 
    mental_health_visits v ON p.patient_id = v.patient_id
ORDER BY 
    v.visit_id;

-- 6.	Show all patients and their doctors, including patients who have not seen a doctor and doctors with no assigned patients.
SELECT 
    p.first_name AS patient_first_name,
    p.last_name AS patient_last_name,
    d.doctor_name,
    v.visit_date
FROM 
    mental_health_patients p
FULL OUTER JOIN 
    mental_health_visits v ON p.patient_id = v.patient_id
FULL OUTER JOIN 
    mental_health_doctors d ON v.doctor_id = d.doctor_id
ORDER BY 
    patient_first_name, doctor_name;

-- 7.	Find all patients who had a follow-up visit in January 2024.
SELECT 
    p.first_name,
    p.last_name,
    v.visit_date,
    v.visit_type
FROM 
    mental_health_visits v
JOIN 
    mental_health_patients p ON v.patient_id = p.patient_id
WHERE 
    v.visit_type = 'Follow-up'
    AND v.visit_date BETWEEN '2024-01-01' AND '2024-01-31'
ORDER BY 
    v.visit_date;

-- 8.	List all patients who have visited a doctor and are suffering from “Anxiety.”

SELECT 
    DISTINCT p.first_name,
    p.last_name,
    p.diagnosis,
    v.visit_date
FROM 
    mental_health_patients p
JOIN 
    mental_health_visits v ON p.patient_id = v.patient_id
WHERE 
    p.diagnosis = 'Anxiety'
ORDER BY 
    p.last_name;

-- 9.	Find all patients who have visited more than 2 doctors.
SELECT 
    p.first_name,
    p.last_name,
    COUNT(DISTINCT v.doctor_id) AS num_doctors
FROM 
    mental_health_patients p
JOIN 
    mental_health_visits v ON p.patient_id = v.patient_id
GROUP BY 
    p.patient_id, p.first_name, p.last_name
HAVING 
    COUNT(DISTINCT v.doctor_id)>2
ORDER BY 
    num_doctors DESC;

    
-- 10.	List all patients who visited a doctor with a specialty that matches their diagnosis.

 SELECT 
    p.first_name,
    p.last_name,
    p.diagnosis,
    d.doctor_name,
    d.specialization,
    v.visit_date
FROM 
    mental_health_patients p
JOIN 
    mental_health_visits v ON p.patient_id = v.patient_id
JOIN 
    mental_health_doctors d ON v.doctor_id = d.doctor_id
WHERE 
    CASE 
        WHEN p.diagnosis IN ('Depression', 'Bipolar Disorder', 'Schizophrenia', 'PTSD', 'OCD', 'Post-traumatic Stress Disorder') THEN 'Psychiatrist'
        WHEN p.diagnosis IN ('Anxiety', 'Generalized Anxiety Disorder') THEN 'Psychologist'
        ELSE NULL
    END = d.specialization
ORDER BY 
    p.last_name;


-- 11.	Show the average age of patients who visited a psychiatrist.
 SELECT 
    AVG(p.age) AS average_age
FROM 
    mental_health_patients p
JOIN 
    mental_health_visits v ON p.patient_id = v.patient_id
JOIN 
    mental_health_doctors d ON v.doctor_id = d.doctor_id
WHERE 
    d.specialization = 'Psychiatrist';

-- 12.	Count the total number of visits for each patient.
SELECT 
    p.first_name,
    p.last_name,
    COUNT(v.visit_id) AS total_visits
FROM 
    mental_health_patients p
JOIN 
    mental_health_visits v ON p.patient_id = v.patient_id
GROUP BY 
    p.patient_id
ORDER BY 
    total_visits DESC;

-- 13.	Show employees with the doctors they’ve visited 
SELECT 
    p.first_name AS patient_first_name,
    p.last_name AS patient_last_name,
    d.doctor_name,
    v.visit_date
FROM 
    mental_health_patients p
JOIN 
    mental_health_visits v ON p.patient_id = v.patient_id
JOIN 
    mental_health_doctors d ON v.doctor_id = d.doctor_id
ORDER BY 
    p.last_name, v.visit_date;

-- Subqueries in SQL --

-- 	Show the total number of visits for each patient in the result set, using a subquery in the SELECT clause.
SELECT 
    p.first_name AS patient_first_name,
    p.last_name AS patient_last_name,
    d.doctor_name,
    v.visit_date
FROM 
    mental_health_patients p
JOIN 
    mental_health_visits v ON p.patient_id = v.patient_id
JOIN 
    mental_health_doctors d ON v.doctor_id = d.doctor_id
ORDER BY 
    p.last_name, v.visit_date;

-- 	Display each department and the highest salary within that department using a subquery in the SELECT clause.
SELECT 
    e.department_name,
    (SELECT MAX(e1.salary)
     FROM employees e1
     WHERE e1.department_name = e.department_name) AS highest_salary
FROM 
    (SELECT DISTINCT department_name FROM employees) e;




-- Use a subquery in the FROM clause to show all patients with their total number of visits.
SELECT 
    d.specialization,
    MAX(visit_count) AS max_visits
FROM 
    mental_health_doctors d
JOIN 
    (SELECT doctor_id, COUNT(visit_id) AS visit_count
     FROM mental_health_visits
     GROUP BY doctor_id) v
ON d.doctor_id = v.doctor_id
GROUP BY 
    d.specialization;


--	Find all patients who have had at least one visit in the past year (2024) using a subquery in the WHERE clause.
 
SELECT * 
FROM mental_health_patients p
WHERE p.patient_id IN (
    SELECT v.patient_id
    FROM mental_health_visits v
    WHERE v.visit_date BETWEEN '2024-01-01' AND '2024-12-31'
);










