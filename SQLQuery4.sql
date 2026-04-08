--معرفة كل موعد مع اسم المريض والطبيب
SELECT
    a.appointment_id,
    p.first_name + ' ' + p.last_name AS Patient_Name,
    d.first_name + ' ' + d.last_name AS Doctor_Name,
    d.specialization,
    a.appointment_date,
    a.status
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id;

--اي تخصص يحقق اعلى دخل للمستشفى
SELECT 
    d.specialization,
    SUM(b.amount) AS Total_Revenue,
    COUNT(a.appointment_id) AS Number_of_Appointments
FROM billing b
JOIN treatments t ON b.treatment_id = t.treatment_id
JOIN appointments a ON t.appointment_id = a.appointment_id
JOIN doctors d ON a.doctor_id = d.doctor_id
GROUP BY d.specialization
ORDER BY Total_Revenue DESC;

--المرضى الاكثر مجيئا للمستشفى
SELECT 
    p.first_name + ' ' + p.last_name AS Patient_Name,
    COUNT(a.appointment_id) AS Visit_Count
FROM patients p
JOIN appointments a ON p.patient_id = a.patient_id
GROUP BY p.patient_id, p.first_name, p.last_name
HAVING COUNT(a.appointment_id) > 1
ORDER BY Visit_Count DESC;

--طرق الدفع
SELECT 
    payment_method,
    COUNT(*) AS Usage_Count,
    AVG(amount) AS Average_Bill_Value
FROM billing
GROUP BY payment_method;

--توزيع الدكاترة حسب الخبرة


SELECT specialization, AVG(years_experience) AS Avg_Experience
FROM doctors
GROUP BY specialization


--كفاءة المواعيد

SELECT status, COUNT(*) AS Status_Count
FROM appointments
GROUP BY status;

--تحليل الايرادات

SELECT d.specialization, SUM(b.amount) AS Total_Revenue
FROM billing b
JOIN treatments t ON b.treatment_id = t.treatment_id
JOIN appointments a ON t.appointment_id = a.appointment_id
JOIN doctors d ON a.doctor_id = d.doctor_id
GROUP BY d.specialization
ORDER BY Total_Revenue DESC;
