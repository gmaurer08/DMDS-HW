



-- Patients (patient_id, name, surname, dob, gender, email, phone)
-- Doctors (doctor_id, name, surname, department, email, phone)
-- Appointments (appointment_id, patient_id, doctor_id, appointment_date, status)
-- Medical_Records (record_id, patient_id, diagnosis, treatment, record_date)
-- Medications (medication_id, name, dosage, side_effects)
-- Prescriptions (prescription_id, patient_id, doctor_id, medication_id, prescription_date)
-- Billing (billing_id, patient_id, amount, billing_date, payment_status)


-- QUERIES

-- 1. Select the names and surnames of all patients who have cancelled at least one appointment
SELECT DISTINCT p.name, p.surname
FROM patients p, appointments a
WHERE p.patient_id = a.patient_id AND a.status = 'Canceled';

-- 2. Select the names, surnames and emails of all doctors who have prescribed a medication to two or more patients
SELECT DISTINCT d.name, d.surname, d.email
FROM doctors d JOIN prescriptions p ON d.doctor_id = p.doctor_id
WHERE d.doctor_id in (
    SELECT doctor_id
    FROM prescriptions
    GROUP BY doctor_id
    HAVING COUNT(DISTINCT patient_id) >= 2
);
-- option: group by doctor_id and count the number of patients

-- 3. Select the names and surnames of patients who paid the highest amount in billing, along with the amount
-- and the department of the doctor who treated them
SELECT p.name, p.surname, d.department, b.amount
FROM patients p
JOIN billing b ON p.patient_id = b.patient_id
JOIN appointments a ON p.patient_id = a.patient_id
AND b.billing_date = a.appointment_date
JOIN doctors d ON a.doctor_id = d.doctor_id
WHERE b.amount = (SELECT MAX(amount) FROM billing) AND b.status = 'Paid';

-- Here only among the paid bills:
SELECT p.name, p.surname, d.department, b.amount
FROM patients p
JOIN billing b ON p.patient_id = b.patient_id
JOIN appointments a ON p.patient_id = a.patient_id
AND b.billing_date = a.appointment_date
JOIN doctors d ON a.doctor_id = d.doctor_id
WHERE b.amount = (SELECT MAX(amount) FROM billing WHERE payment_status = 'Paid');

-- ChatGPT:

SELECT p.name, p.surname, d.department, b.amount
FROM patients p
JOIN billing b ON p.patient_id = b.patient_id
JOIN appointments a ON p.patient_id = a.patient_id
AND b.billing_date = a.appointment_date
JOIN doctors d ON a.doctor_id = d.doctor_id
WHERE b.payment_status = 'Paid'
AND b.amount = (
    SELECT MAX(amount) 
    FROM billing 
    WHERE payment_status = 'Paid'
);


-- Patients (patient_id, name, surname, dob, gender, email, phone)
-- Doctors (doctor_id, name, surname, department, email, phone)
-- Appointments (appointment_id, patient_id, doctor_id, appointment_date, status)
-- Medical_Records (record_id, patient_id, diagnosis, treatment, record_date)
-- Medications (medication_id, name, dosage, side_effects)
-- Prescriptions (prescription_id, patient_id, doctor_id, medication_id, prescription_date)
-- Billing (billing_id, patient_id, amount, billing_date, payment_status)



-- 4. Find the names and surnames of the doctors who treated the maximum number of patients
-- along with the sum of the ages of those patients

WITH DoctorPatientCounts AS (
    SELECT 
        d.doctor_id, 
        d.name AS doctor_name, 
        d.surname AS doctor_surname, 
        COUNT(DISTINCT a.patient_id) AS patient_count,
        SUM(EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM p.dob)) AS total_patient_age
    FROM doctors d
    JOIN appointments a ON d.doctor_id = a.doctor_id
    JOIN patients p ON a.patient_id = p.patient_id
    GROUP BY d.doctor_id, d.name, d.surname
), MaxPatients AS (
    SELECT MAX(patient_count) AS max_patients FROM DoctorPatientCounts
)
SELECT dpc.doctor_name, dpc.doctor_surname, dpc.patient_count, dpc.total_patient_age
FROM DoctorPatientCounts dpc
JOIN MaxPatients mp ON dpc.patient_count = mp.max_patients;

-- 2025-year