# marketing_data_analysis

Marketing Campaign & Customer Purchase Analysis

# 1. Project Overview

This project analyzes customer purchasing behavior and marketing campaign performance using Python, SQL, and Statistical Modeling.

The goal was to understand what drives online purchases, evaluate marketing campaign effectiveness, and identify customer characteristics associated with higher engagement and spending.
<img width="1167" height="614" alt="capture 2" src="https://github.com/user-attachments/assets/77cf0ed5-e1d8-4e0c-8ad8-578fa2b133df" />

![Capture](https://github.com/user-attachments/assets/7e8e939b-bd63-4e2c-ad5a-585a973d9c1a)


# 2. Dataset Summary
	•	Dataset: Maven Marketing Dataset
	•	Records: 2,233 customers
	•	Domain: Retail Marketing Analytics

Key Variables
	•	Customer demographics (Age, Education, Marital Status, Country)
	•	Income level
	•	Product spending categories
	•	Online, catalog, and store purchases
	•	Website visits
	•	Marketing campaign responses
	•	Customer household structure


# 3. Data Cleaning & Preparation (SQL)
<img width="1121" height="782" alt="Screenshot 2026-03-27 at 8 32 56 PM" src="https://github.com/user-attachments/assets/45182ba4-a80b-48b7-b240-327ef761ff9e" />


Major preprocessing steps:

✅ Created structured marketing database
✅ Combined kidhome + teenhome → minor_children
✅ Removed unrealistic age outliers (>95 years)
✅ Imputed missing income values using education-level averages
✅ Standardized marital status categories
✅ Renamed columns for analytics usability
✅ Created new analytical features:
	•	Age
	•	Total Spend
	•	Campaign Success Indicator


# 4. Feature Engineering (Python)

<img width="1152" height="875" alt="Screenshot 2026-03-27 at 8 32 05 PM" src="https://github.com/user-attachments/assets/eab73cac-5c9a-4593-80a8-963b25ebfd91" />


Using Pandas:
	•	Converted categorical variables using one-hot encoding
	•	Standardized column naming conventions
	•	Built analytical dataset for regression modeling
	•	Calculated correlation between age and spending

Finding:
Age and spending show a weak positive relationship (r = 0.11).


# 5. Statistical Modeling — OLS Regression

Objective

Identify factors influencing online purchases (website sales).

Model Performance
	•	R² = 0.42
	•	Model statistically significant (p < 0.001)
	•	Explains ~42% of variation in online purchasing behavior.

Significant Drivers of Online Purchases

✔ Income
✔ Deal purchases
✔ Store purchases
✔ Website visits
✔ Age
✔ Total spending

Non-Significant Factors
	•	Education level (Basic)
	•	Country (Germany)
	•	Catalog purchases
	•	Number of children (weak effect)

Insight:
Customer engagement behaviors matter more than demographics alone.


# 6. SQL Business Analysis & Insights

👥 Customer Behavior Insights
	•	Older customers place more online orders.
	•	Customers with fewer children purchase online more frequently.
	•	Higher education levels correlate with increased website usage.
	•	Divorced and widowed customers show slightly higher online activity.


💰 Income & Spending Insights
	•	Large income inequality exists across customer groups.
	•	Some mid-income groups demonstrate the highest online ordering activity.
	•	Spending as a percentage of income varies widely between customers.


📈 Marketing Campaign Performance

Six marketing campaigns were evaluated.

Overall campaign participation:
➡️ 27.14% success rate

Key Finding
	•	Campaign 6 significantly outperformed previous campaigns.
	•	Earlier campaigns achieved roughly half the success rate.

# Business Insight:
Later campaign strategies were better aligned with customer behavior.


# 7. Key Business Conclusions
	•	Online purchasing is primarily driven by customer engagement, not demographics.
	•	Website interaction strongly predicts conversion.
	•	Marketing strategies improved over time but overall response rates remain moderate.
	•	Customer segmentation can significantly improve targeting efficiency.


# 8. Skills Demonstrated
	•	SQL Data Cleaning & Transformation
	•	Feature Engineering
	•	Statistical Modeling (OLS Regression)
	•	Customer Segmentation
	•	Marketing Analytics
	•	Business Insight Communication
	•	Python (Pandas, Statsmodels)


# 9. Project Outcome

This project demonstrates how combining SQL analytics, Python preprocessing, and regression modeling can uncover actionable marketing insights and identify drivers of digital customer behavior.
