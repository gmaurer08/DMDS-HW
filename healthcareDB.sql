

\c postgres

DROP DATABASE IF EXISTS healthcareDB;

CREATE DATABASE healthcareDB;

\c healthcareDB;

DROP TABLE if exists Patients CASCADE;
DROP TABLE if exists Doctors CASCADE;
DROP TABLE if exists Appointments CASCADE;
DROP TABLE if exists Medical_Records CASCADE;
DROP TABLE if exists Medications CASCADE;
DROP TABLE if exists Prescriptions CASCADE;
DROP TABLE if exists Billing CASCADE;


CREATE TABLE Patients (
    patient_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    surname VARCHAR(255) NOT NULL,
    dob DATE NOT NULL,
    gender VARCHAR(10) CHECK (gender IN ('M', 'F', 'Other')),
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE Doctors (
    doctor_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    surname VARCHAR(255) NOT NULL,
    department VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE Appointments (
    appointment_id SERIAL PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date TIMESTAMP NOT NULL,
    status VARCHAR(50) CHECK (status IN ('Scheduled', 'Completed', 'Canceled')),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE
);

CREATE TABLE Medical_Records (
    record_id SERIAL PRIMARY KEY,
    patient_id INT NOT NULL,
    diagnosis TEXT NOT NULL,
    treatment TEXT NOT NULL,
    record_date DATE NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE
);

CREATE TABLE Medications (
    medication_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    dosage VARCHAR(100) NOT NULL,
    side_effects TEXT
);

CREATE TABLE Prescriptions (
    prescription_id SERIAL PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    medication_id INT NOT NULL,
    prescription_date DATE NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE,
    FOREIGN KEY (medication_id) REFERENCES Medications(medication_id) ON DELETE CASCADE
);

CREATE TABLE Billing (
    bill_id SERIAL PRIMARY KEY,
    patient_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL CHECK (amount >= 0),
    billing_date DATE NOT NULL,
    payment_status VARCHAR(50) CHECK (payment_status IN ('Paid', 'Pending', 'Overdue')),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE
);



INSERT INTO Patients (name, surname, dob, gender, email, phone) VALUES
('James', 'Carter', '1992-03-15', 'M', 'james.carter@gmail.com', '+1-415-135-0293'),
('Emily', 'Johnson', '1985-06-22', 'F', 'emily.johnson@hotmail.com', '+1-305-295-0928'),
('William', 'Harrison', '1978-11-03', 'M', 'william.harrison@outlook.com', '+1-312-771-1087'),
('Olivia', 'Parker', '1975-01-29', 'F', 'olivia.parker@gmail.com', '+1-215-723-0347'),
('Benjamin', 'Collins', '1984-08-14', 'M', 'benjamin.collins@hotmail.com', '+1-202-896-0611'),
('Charlotte', 'Reynolds', '1990-02-17', 'F', 'charlotte.reynolds@outlook.com', '+1-646-213-0785'),
('Henry', 'Adams', '1982-09-09', 'M', 'henry.adams@gmail.com', '+1-617-555-0924'),
('Sophia', 'Mitchell', '1993-12-10', 'F', 'sophia.mitchell@hotmail.com', '+1-213-998-1348'),
('Ethan', 'Turner', '2008-05-20', 'M', 'ethan.turner@outlook.com', '+1-314-718-0152'),
('Ava', 'Brooks', '2000-11-05', 'F', 'ava.brooks@gmail.com', '+1-323-213-0247'),
('Daniel', 'Clark', '1985-07-30', 'M', 'daniel.clark@hotmail.com', '+1-504-730-0684'),
('Grace', 'Bennett', '1992-04-25', 'F', 'grace.bennett@outlook.com', '+1-213-100-0941'),
('Alexander', 'Scott', '1960-10-19', 'M', 'alexander.scott@gmail.com', '+1-408-222-1215'),
('Mia', 'Richardson', '2010-03-08', 'F', 'mia.richardson@hotmail.com', '+1-512-234-1356'),
('Lucas', 'Evans', '1999-01-13', 'M', 'lucas.evans@outlook.com', '+1-210-578-0219'),
('Harper', 'White', '2001-09-02', 'F', 'harper.white@gmail.com', '+1-732-045-0093'),
('Noah', 'Phillips', '1989-12-05', 'M', 'noah.phillips@hotmail.com', '+1-617-423-0769'),
('Lily', 'Thompson', '1986-07-12', 'F', 'lily.thompson@outlook.com', '+1-408-132-0952'),
('Samuel', 'Foster', '1994-10-21', 'M', 'samuel.foster@gmail.com', '+1-925-776-1105'),
('Isabella', 'Wright', '1988-04-17', 'F', 'isabella.wright@hotmail.com', '+1-818-111-1323'),
('Jack', 'Morgan', '2002-08-26', 'M', 'jack.morgan@outlook.com', '+1-305-129-0738');

INSERT INTO Doctors (name, surname, department, email, phone) VALUES
('Lucas', 'White', 'Cardiology', 'lucas.white@gmail.com', '+1-415-119-0218'),
('Mia', 'Brooks', 'Neurology', 'mia.brooks@hotmail.com', '+1-323-231-0587'),
('Jacob', 'Parker', 'Orthopedics', 'jacob.parker@outlook.com', '+1-718-421-0489'),
('Sophie', 'Harris', 'Pediatrics', 'sophie.harris@gmail.com', '+1-512-002-0192'),
('Benjamin', 'Elliott', 'Dermatology', 'benjamin.elliott@hotmail.com', '+1-213-125-0724'),
('Harper', 'Lewis', 'Gastroenterology', 'harper.lewis@outlook.com', '+1-408-958-0872'),
('Noah', 'Hudson', 'Oncology', 'noah.hudson@gmail.com', '+1-646-993-0530'),
('Isabella', 'Holland', 'Endocrinology', 'isabella.holland@hotmail.com', '+1-202-138-0143'),
('George', 'Evans', 'Surgery', 'george.evans@outlook.com', '+1-305-308-0835'),
('Lauren', 'Wright', 'Psychiatry', 'lauren.wright@gmail.com', '+1-619-019-0768'),
('Michael', 'Green', 'Cardiology', 'michael.green@gmail.com', '+1-425-559-0194'),
('Olivia', 'Lopez', 'Neurology', 'olivia.lopez@hotmail.com', '+1-323-254-0968'),
('Samuel', 'King', 'Orthopedics', 'samuel.king@outlook.com', '+1-738-422-0679'),
('Emma', 'Davis', 'Pediatrics', 'emma.davis@outlook.com', '+1-215-437-3721'),
('James', 'Martinez', 'Orthopedics', 'james.martinez@gmail.com', '+1-510-383-1629');

INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status) VALUES
(1, 1, '2024-01-05', 'Completed'),
(1, 13, '2024-01-15', 'Completed'),
(2, 2, '2024-01-16', 'Completed'),
(3, 3, '2024-01-27', 'Completed'),
(4, 4, '2024-02-18', 'Completed'),
(6, 13, '2024-02-19', 'Completed'),
(1, 3, '2024-03-13', 'Completed'),
(6, 2, '2024-03-13', 'Completed'),
(8, 5, '2024-03-25', 'Canceled'),
(7, 5, '2024-04-01', 'Completed'),
(9, 4, '2024-04-03', 'Completed'),
(11, 15, '2024-04-16', 'Canceled'),
(12, 1, '2024-04-20', 'Completed'),
(13, 3, '2024-05-20', 'Completed'),
(14, 14, '2024-05-21', 'Completed'),
(15, 1, '2024-05-03', 'Completed'),
(16, 3, '2024-06-05', 'Completed'),
(17, 8, '2024-06-07', 'Canceled'),
(18, 10, '2024-06-08', 'Completed'),
(19, 2, '2024-07-14', 'Completed'),
(20, 3, '2024-07-19', 'Completed'),
(9, 14, '2024-07-30', 'Completed'),
(4, 3, '2024-08-28', 'Canceled'),
(4, 1, '2024-08-31', 'Completed'),
(1, 5, '2024-08-05', 'Completed'),
(6, 5, '2024-09-09', 'Canceled'),
(5, 2, '2024-09-10', 'Completed'),
(15, 3, '2024-09-16', 'Completed'),
(16, 8, '2024-10-16', 'Canceled'),
(18, 1, '2024-10-20', 'Completed'),
(19, 3, '2024-10-20', 'Completed'),
(20, 9, '2024-11-21', 'Completed'),
(12, 1, '2024-11-20', 'Completed'),
(4, 14, '2024-11-20', 'Completed'),
(4, 9, '2024-12-21', 'Canceled'),
(1, 5, '2024-12-21', 'Canceled'),
(6, 10, '2024-12-15', 'Completed'),
(5, 2, '2024-01-16', 'Completed'),
(15, 3, '2024-01-16', 'Completed'),
(16, 4, '2024-01-16', 'Completed'),
(18, 9, '2024-02-20', 'Scheduled'),
(19, 3, '2024-02-20', 'Scheduled'),
(20, 15, '2024-03-21', 'Scheduled'),
(12, 1, '2024-03-20', 'Scheduled'),
(4, 9, '2024-04-20', 'Scheduled'),
(16, 13, '2024-04-21', 'Scheduled'),
(1, 12, '2024-04-21', 'Scheduled'),
(6, 9, '2024-05-15', 'Scheduled'),
(5, 2, '2024-05-16', 'Canceled'),
(15, 3, '2024-06-16', 'Canceled'),
(16, 12, '2024-06-16', 'Scheduled'),
(18, 10, '2024-07-20', 'Scheduled'),
(19, 3, '2024-07-20', 'Scheduled'),
(20, 1, '2024-07-21', 'Scheduled');

INSERT INTO Medical_Records (patient_id, diagnosis, treatment, record_date) VALUES
-- Cardiology-related diagnoses
(1, 'Hyperlipidemia', 'Atorvastatin', '2024-01-05'),
(12, 'Hypertension', 'Lisinopril', '2024-04-20'),
(15, 'Arrhythmia', 'Metoprolol', '2024-05-03'),
(18, 'High Blood Pressure', 'Amlodipine', '2024-10-20'),
(20, 'Blood Clot Prevention', 'Clopidogrel', '2024-07-21'),
-- Neurology-related diagnoses
(2, 'Neuropathic Pain', 'Gabapentin', '2024-01-16'),
(6, 'Epilepsy', 'Carbamazepine', '2024-03-13'),
(19, 'Migraine', 'Sumatriptan', '2024-07-14'),
(5, 'Alzheimers Disease', 'Donepezil', '2024-09-10'),
(5, 'Seizure Disorder', 'Levetiracetam', '2024-01-16'),
-- Orthopedic-related diagnoses
(3, 'Osteoarthritis', 'Ibuprofen', '2024-01-27'),
(1, 'Joint Pain', 'Celecoxib', '2024-03-13'),
(13, 'Inflammation', 'Naproxen', '2024-05-20'),
(16, 'Post-Surgical Pain', 'Tramadol', '2024-06-05'),
(20, 'Rheumatoid Arthritis', 'Methotrexate', '2024-07-19'),
(15, 'Muscle Pain', 'Ibuprofen', '2024-09-16'),
(19, 'Chronic Pain', 'Celecoxib', '2024-10-20'),
-- Pediatric-related diagnoses
(4, 'Bacterial Infection', 'Amoxicillin', '2024-02-18'),
(9, 'Fever', 'Paracetamol', '2024-04-03'),
(16, 'Asthma', 'Montelukast', '2024-01-16'),
(4, 'Allergic Rhinitis', 'Cetirizine', '2024-11-20'),
-- Dermatology-related diagnoses
(8, 'Asthma', 'Salbutamol', '2024-03-25'),
(7, 'Eczema', 'Hydrocortisone', '2024-04-01'),
(1, 'Acne', 'Isotretinoin', '2024-08-05'),
(6, 'Fungal Infection', 'Clotrimazole', '2024-09-09'),
-- Gastroenterology-related diagnoses
(6, 'Bacterial Infection', 'Doxycycline', '2024-12-15'),
-- Oncology-related diagnoses
(18, 'Organ Transplant Rejection Prevention', 'Tacrolimus', '2024-06-07'),
-- Endocrinology-related diagnoses
(17, 'Diabetes Type 2', 'Metformin', '2024-06-07'),
(16, 'Hypothyroidism', 'Levothyroxine', '2024-10-16'),
-- Surgery-related diagnoses
(20, 'Diabetes Type 1', 'Insulin Glargine', '2024-11-21'),
(6, 'Diabetes Management', 'Glimepiride', '2024-05-15'),
(4, 'Autoimmune Disease', 'Prednisone', '2024-12-21'),
-- Psychiatry-related diagnoses
(18, 'Severe Pain', 'Morphine', '2024-06-08'),
(6, 'Bacterial Infection', 'Ceftriaxone', '2024-12-15'),
(18, 'Local Anesthesia', 'Lidocaine', '2024-07-20'),
-- General Diagnoses
(5, 'Blood Clot Prevention', 'Enoxaparin', '2024-05-16'),
(15, 'Post-Surgical Pain', 'Ketorolac', '2024-06-16'),
(19, 'Depression', 'Fluoxetine', '2024-07-20'),
(20, 'Anxiety Disorder', 'Sertraline', '2024-03-21'),
(4, 'Bipolar Disorder', 'Quetiapine', '2024-04-20'),
(16, 'Schizophrenia', 'Risperidone', '2024-04-21'),
(1, 'Anxiety', 'Lorazepam', '2024-04-21');


INSERT INTO Medications (name, dosage, side_effects) VALUES
('Atorvastatin', '10mg once daily', 'Headache, muscle pain, nausea'),
('Lisinopril', '5mg once daily', 'Dizziness, dry cough, fatigue'),
('Metoprolol', '50mg twice daily', 'Bradycardia, fatigue, dizziness'),
('Amlodipine', '5mg once daily', 'Swelling, flushing, dizziness'),
('Clopidogrel', '75mg once daily', 'Bleeding, bruising, rash'),
('Gabapentin', '300mg three times daily', 'Drowsiness, dizziness, weight gain'),
('Carbamazepine', '200mg twice daily', 'Nausea, dizziness, drowsiness'),
('Sumatriptan', '50mg as needed', 'Tingling, dizziness, warm sensation'),
('Donepezil', '10mg once daily', 'Insomnia, muscle cramps, nausea'),
('Levetiracetam', '500mg twice daily', 'Drowsiness, weakness, mood swings'),
('Ibuprofen', '400mg every 6 hours as needed', 'Stomach pain, nausea, heartburn'),
('Celecoxib', '200mg once daily', 'Diarrhea, gas, dizziness'),
('Naproxen', '500mg twice daily', 'Indigestion, dizziness, rash'),
('Tramadol', '50mg every 6 hours as needed', 'Drowsiness, nausea, constipation'),
('Methotrexate', '7.5mg once weekly', 'Mouth ulcers, fatigue, liver toxicity'),
('Amoxicillin', '250mg three times daily', 'Diarrhea, rash, nausea'),
('Paracetamol', '250mg every 4-6 hours as needed', 'Liver damage (high doses), nausea'),
('Montelukast', '5mg once daily', 'Stomach pain, headache, mood changes'),
('Cetirizine', '5mg once daily', 'Drowsiness, dry mouth, dizziness'),
('Salbutamol', '100mcg inhaler as needed', 'Tremors, palpitations, nervousness'),
('Hydrocortisone', 'Apply thin layer twice daily', 'Skin thinning, redness, burning'),
('Isotretinoin', '20mg once daily', 'Dry skin, liver toxicity, birth defects'),
('Clotrimazole', 'Apply twice daily for 2 weeks', 'Burning, redness, irritation'),
('Doxycycline', '100mg once daily', 'Sun sensitivity, nausea, diarrhea'),
('Tacrolimus', 'Apply twice daily', 'Skin irritation, burning, itching'),
('Metformin', '500mg twice daily', 'Nausea, diarrhea, weight loss'),
('Levothyroxine', '50mcg once daily', 'Palpitations, weight loss, anxiety'),
('Insulin Glargine', '10 units once daily', 'Hypoglycemia, weight gain, swelling'),
('Glimepiride', '2mg once daily', 'Hypoglycemia, dizziness, nausea'),
('Prednisone', '10mg once daily', 'Weight gain, mood changes, high blood pressure'),
('Morphine', '10mg every 4 hours as needed', 'Drowsiness, nausea, respiratory depression'),
('Ceftriaxone', '1g IV once daily', 'Diarrhea, rash, pain at injection site'),
('Lidocaine', 'Apply before procedure', 'Numbness, tingling, dizziness'),
('Enoxaparin', '40mg subcutaneous once daily', 'Bleeding, bruising, pain at injection site'),
('Ketorolac', '30mg IV every 6 hours', 'Stomach pain, kidney toxicity, dizziness'),
('Fluoxetine', '20mg once daily', 'Nausea, insomnia, weight loss'),
('Sertraline', '50mg once daily', 'Drowsiness, dizziness, dry mouth'),
('Quetiapine', '100mg at bedtime', 'Drowsiness, weight gain, dizziness'),
('Risperidone', '2mg once daily', 'Weight gain, dizziness, restlessness'),
('Lorazepam', '1mg twice daily', 'Drowsiness, confusion, dizziness');

INSERT INTO Prescriptions (patient_id, doctor_id, medication_id, prescription_date) VALUES
-- Cardiology (Doctors: 1, 11)
(1, 1, 1, '2024-01-05'),  -- Atorvastatin
(12, 1, 2, '2024-04-20'), -- Lisinopril
(15, 1, 3, '2024-05-03'), -- Metoprolol
(18, 1, 4, '2024-10-20'), -- Amlodipine
(20, 1, 5, '2024-07-21'), -- Clopidogrel
-- Neurology (Doctors: 2, 12)
(2, 2, 6, '2024-01-16'),  -- Gabapentin
(6, 2, 7, '2024-03-13'),  -- Carbamazepine
(19, 2, 8, '2024-07-14'), -- Sumatriptan
(5, 2, 9, '2024-09-10'),  -- Donepezil
(5, 2, 10, '2024-01-16'), -- Levetiracetam
-- Orthopedics (Doctors: 3, 13, 15)
(3, 3, 11, '2024-01-27'), -- Ibuprofen
(1, 3, 12, '2024-03-13'), -- Celecoxib
(13, 3, 13, '2024-05-20'), -- Naproxen
(16, 3, 14, '2024-06-05'), -- Tramadol
(20, 3, 15, '2024-07-19'), -- Methotrexate
(15, 3, 11, '2024-09-16'), -- Ibuprofen
(19, 3, 12, '2024-10-20'), -- Celecoxib
-- Pediatrics (Doctors: 4, 14)
(4, 4, 16, '2024-02-18'), -- Amoxicillin
(9, 4, 17, '2024-04-03'), -- Paracetamol
(16, 4, 18, '2024-01-16'), -- Montelukast
(4, 14, 19, '2024-11-20'), -- Cetirizine
-- Dermatology (Doctor: 5)
(8, 5, 20, '2024-03-25'), -- Salbutamol
(7, 5, 21, '2024-04-01'), -- Hydrocortisone
(1, 5, 22, '2024-08-05'), -- Isotretinoin
(6, 5, 23, '2024-09-09'), -- Clotrimazole
-- Gastroenterology (Doctor: 6)
(6, 6, 24, '2024-12-15'), -- Doxycycline
-- Oncology (Doctor: 7)
(18, 7, 25, '2024-06-07'), -- Tacrolimus
-- Endocrinology (Doctor: 8)
(17, 8, 26, '2024-06-07'), -- Metformin
(16, 8, 27, '2024-10-16'), -- Levothyroxine
-- Surgery (Doctor: 9)
(20, 9, 28, '2024-11-21'), -- Insulin Glargine
(6, 9, 29, '2024-05-15'), -- Glimepiride
(4, 9, 30, '2024-12-21'), -- Prednisone
-- Psychiatry (Doctor: 10)
(18, 10, 31, '2024-06-08'), -- Morphine
(6, 10, 32, '2024-12-15'), -- Ceftriaxone
(18, 10, 33, '2024-07-20'), -- Lidocaine
-- General Prescriptions
(5, 2, 34, '2024-05-16'), -- Enoxaparin
(15, 3, 35, '2024-06-16'), -- Ketorolac
(19, 3, 36, '2024-07-20'), -- Fluoxetine
(20, 15, 37, '2024-03-21'), -- Sertraline
(4, 9, 38, '2024-04-20'), -- Quetiapine
(16, 13, 39, '2024-04-21'), -- Risperidone
(1, 12, 40, '2024-04-21'); -- Lorazepam

 
INSERT INTO Billing (patient_id, amount, billing_date, payment_status) VALUES
(1, 250, '2024-01-05', 'Paid'),
(1, 300, '2024-01-15', 'Paid'),
(2, 200, '2024-01-16', 'Paid'),
(3, 180, '2024-01-27', 'Paid'),
(4, 150, '2024-02-18', 'Paid'),
(6, 320, '2024-02-19', 'Paid'),
(1, 220, '2024-03-13', 'Paid'),
(6, 270, '2024-03-13', 'Paid'),
(7, 180, '2024-04-01', 'Paid'),
(9, 160, '2024-04-03', 'Paid'),
(13, 290, '2024-05-20', 'Paid'),
(14, 150, '2024-05-21', 'Paid'),
(15, 310, '2024-06-05', 'Paid'),
(19, 280, '2024-07-14', 'Paid'),
(20, 350, '2024-07-19', 'Paid'),
(9, 170, '2024-07-30', 'Paid'),
(4, 200, '2024-08-31', 'Paid'),
(1, 210, '2024-08-05', 'Paid'),
(5, 220, '2024-09-10', 'Paid'),
(15, 330, '2024-09-16', 'Paid'),
(18, 400, '2024-10-20', 'Paid'),
(19, 250, '2024-10-20', 'Paid'),
(20, 500, '2024-11-21', 'Pending'),
(12, 300, '2024-11-20', 'Pending'),
(4, 200, '2024-11-20', 'Pending'),
(6, 180, '2024-12-15', 'Pending');