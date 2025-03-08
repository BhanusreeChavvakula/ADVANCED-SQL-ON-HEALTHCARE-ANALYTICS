# ADVANCED-SQL-ON-HEALTHCARE-ANALYTICS



## Overview
This project analyzes patient health data to identify risk factors for chronic kidney disease (CKD) and predict the likelihood of CKD progression. The dataset includes health metrics for 1,000 patients, such as age, BMI, cholesterol levels, and CKD status. The analysis was performed using **MySQL** for querying the data and **Power BI** for visualization.

---

## Key Features
- **Risk Score Calculation**: Identifies patients at high risk of CKD based on age, BMI, cholesterol, and comorbidities.
- **CKD Event Rate Over Time**: Tracks the trend in CKD events over the years.
- **Top Risk Factors**: Highlights the most common risk factors (e.g., diabetes, hypertension, obesity).
- **Correlation Heatmap**: Visualizes the correlation between risk factors (e.g., BMI vs. Cholesterol).

---

## Dataset
The dataset contains the following key columns:
- **Demographics**: Sex, AgeBaseline  
- **Medical History**: HistoryDiabetes, HistoryHTN, HistoryObesity, HistoryCHD, HistoryVascular  
- **Health Metrics**: CholesterolBaseline, eGFRBaseline, sBPBaseline, dBPBaseline, BMIBaseline  
- **Outcome**: EventCKD35 (0 = No CKD, 1 = CKD)

---

## Tools Used
- **MySQL**: For querying and analyzing the data.
- **Power BI**: For creating visualizations and dashboards.
- **Excel**: For additional data cleaning and visualization.

---

## Insights
1. **High-Risk Patients**: 30% of patients are at high risk of CKD due to factors like high cholesterol, obesity, and hypertension.
2. **CKD Event Rate**: The CKD event rate increased by 15% over the past 5 years, especially among older patients.
3. **Top Risk Factors**: Hypertension and obesity are the most common risk factors among high-risk patients.
4. **Correlation**: High BMI and cholesterol levels are strongly correlated with CKD progression.

---

## Recommendations
- **Targeted Screening**: Implement screening programs for high-risk patients.
- **Educational Campaigns**: Raise awareness about the link between obesity and CKD.
- **Close Monitoring**: Monitor patients with multiple comorbidities more closely to prevent CKD progression.

---

## How to Use This Project
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/health-analytics-dashboard.git
