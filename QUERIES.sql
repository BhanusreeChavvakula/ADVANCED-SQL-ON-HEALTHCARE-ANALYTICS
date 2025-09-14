# Total Number of Patients
SELECT COUNT(*) AS TotalPatients 
FROM PatientHealth;

# Average Age and BMI
SELECT 
    AVG(AgeBaseline) AS AverageAge, 
    AVG(BMIBaseline) AS AverageBMI 
FROM PatientHealth;

#Patients with Hypertension
SELECT COUNT(*) AS PatientsWithHypertension 
FROM PatientHealth 
WHERE HistoryHTN = 1;

#Patients with Diabetes and CKD
SELECT COUNT(*) AS DiabeticCKDPatients 
FROM PatientHealth 
WHERE HistoryDiabetes = 1 AND EventCKD35 = 1;

#CKD Event rate by Gender
SELECT 
    CASE 
        WHEN Sex = 0 THEN 'Male' 
        WHEN Sex = 1 THEN 'Female' 
    END AS Gender,
    COUNT(*) AS TotalPatients,
    SUM(EventCKD35) AS CKDEventCount,
    ROUND((SUM(EventCKD35) / COUNT(*)) * 100, 2) AS CKDEventRate
FROM PatientHealth
GROUP BY Sex;

#Average Cholestrol by CKD STATUS
SELECT 
    CASE 
        WHEN EventCKD35 = 1 THEN 'CKD' 
        ELSE 'No CKD' 
    END AS CKDStatus,
    AVG(CholesterolBaseline) AS AverageCholesterol
FROM PatientHealth
GROUP BY CKDStatus;

#Patients with High Blood Pressure (BP>140)
SELECT COUNT(*) AS HighBPPatients 
FROM PatientHealth 
WHERE sBPBaseline > 140;

#Patients with Multiple Risk Factors
SELECT COUNT(*) AS HighRiskPatients 
FROM PatientHealth 
WHERE HistoryDiabetes = 1 
  AND HistoryHTN = 1 
  AND HistoryObesity = 1;
  
  #Top 5 Patients with Highest Cholesterol
  SELECT 
    AgeBaseline,
    BMIBaseline,
    CholesterolBaseline,
    CASE 
        WHEN EventCKD35 = 1 THEN 'Yes' 
        ELSE 'No' 
    END AS HasCKD
FROM PatientHealth
ORDER BY CholesterolBaseline DESC
LIMIT 5;

#CKD Event Rate Over Time (Trend Analysis)
SELECT 
    TIME_YEAR,
    COUNT(*) AS TotalPatients,
    SUM(EventCKD35) AS CKDEventCount,
    ROUND((SUM(EventCKD35) / COUNT(*)) * 100, 2) AS CKDEventRate
FROM PatientHealth
GROUP BY TIME_YEAR
ORDER BY TIME_YEAR;

#Patients with High Cholesterol and Low eGFR
SELECT 
    AgeBaseline,
    CholesterolBaseline,
    eGFRBaseline,
    CASE 
        WHEN EventCKD35 = 1 THEN 'Yes' 
        ELSE 'No' 
    END AS HasCKD
FROM PatientHealth
WHERE CholesterolBaseline > 200 
  AND eGFRBaseline < 60;
  
  #Risk score Calculation
  SELECT 
    AgeBaseline,
    BMIBaseline,
    CholesterolBaseline,
    CASE 
        WHEN AgeBaseline > 60 AND BMIBaseline > 30 AND CholesterolBaseline > 200 THEN 'High Risk'
        WHEN AgeBaseline > 50 AND BMIBaseline > 25 AND CholesterolBaseline > 180 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS RiskScore
FROM PatientHealth;

# Rolling Average of Cholesterol Over Time
SELECT 
    TIME_YEAR,
    AVG(CholesterolBaseline) OVER (ORDER BY TIME_YEAR ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS RollingAvgCholesterol
FROM PatientHealth
ORDER BY TIME_YEAR;

#Patients with the Highest Number of Comorbidities
WITH ComorbidityCount AS (
    SELECT 
        ROW_NUMBER() OVER () AS PatientID, -- Generate a unique ID for each row
        (HistoryDiabetes + HistoryHTN + HistoryObesity + HistoryCHD + HistoryVascular) AS ComorbidityCount
    FROM PatientHealth
)
SELECT 
    PatientID,
    ComorbidityCount
FROM ComorbidityCount
ORDER BY ComorbidityCount DESC
LIMIT 10;

#CKD Event Prediction Model
SELECT 
    AgeBaseline,
    BMIBaseline,
    CholesterolBaseline,
    eGFRBaseline,
    CASE 
        WHEN (AgeBaseline > 60 AND BMIBaseline > 30 AND CholesterolBaseline > 200 AND eGFRBaseline < 60) THEN 'High Risk of CKD'
        ELSE 'Low Risk of CKD'
    END AS CKD_Prediction
FROM PatientHealth;

#Patients with the Largest Increase in Blood Pressure Over Time
WITH PatientData AS (
    SELECT 
        ROW_NUMBER() OVER () AS PatientID, -- Generate a unique ID for each row
        TIME_YEAR,
        sBPBaseline
    FROM PatientHealth
)
SELECT 
    p1.PatientID,
    p1.sBPBaseline AS InitialBP,
    p2.sBPBaseline AS FinalBP,
    (p2.sBPBaseline - p1.sBPBaseline) AS BPIncrease
FROM PatientData p1
JOIN PatientData p2 ON p1.PatientID = p2.PatientID
WHERE p1.TIME_YEAR = (SELECT MIN(TIME_YEAR) FROM PatientData)
  AND p2.TIME_YEAR = (SELECT MAX(TIME_YEAR) FROM PatientData)
ORDER BY BPIncrease DESC
LIMIT 10;

#Comprehensive Patient Risk Profile
SELECT 
    ROW_NUMBER() OVER () AS PatientID, -- Generate a unique ID for each row
    AgeBaseline,
    BMIBaseline,
    CholesterolBaseline,
    eGFRBaseline,
    HistoryDiabetes,
    HistoryHTN,
    HistoryObesity,
    HistoryCHD,
    HistoryVascular,
    (CASE WHEN AgeBaseline > 60 THEN 1 ELSE 0 END) +
    (CASE WHEN BMIBaseline > 30 THEN 1 ELSE 0 END) +
    (CASE WHEN CholesterolBaseline > 200 THEN 1 ELSE 0 END) +
    (CASE WHEN eGFRBaseline < 60 THEN 1 ELSE 0 END) +
    HistoryDiabetes +
    HistoryHTN +
    HistoryObesity +
    HistoryCHD +
    HistoryVascular AS RiskScore
FROM PatientHealth
ORDER BY RiskScore DESC;


