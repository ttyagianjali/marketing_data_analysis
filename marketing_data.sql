CREATE DATABASE maven_marketing_data;

USE maven_marketing_data;

CREATE TABLE marketing_data (
    id INT,
    year_birth INT,
    education VARCHAR(50),
    marital_status VARCHAR(50),
    income INT,
    kidhome INT,
    teenhome INT,
    dt_customer DATE,
    recency INT,
    mnt_wines INT,
    mnt_fruits INT,
    mnt_meat_products INT,
    mnt_fish_products INT,
    mnt_sweet_products INT,
    mnt_gold_prods INT,
    num_deals_purchases INT,
    num_web_purchases INT,
    num_catalog_purchases INT,
    num_store_purchases INT,
    num_web_visits_month INT,
    accepted_cmp3 INT,
    accepted_cmp4 INT,
    accepted_cmp5 INT,
    accepted_cmp1 INT,
    accepted_cmp2 INT,
    response INT,
    complain INT,
    country VARCHAR(50)
);

DROP TABLE IF EXISTS marketing_data;

CREATE TABLE marketing_data (
    id INT,
    year_birth INT,
    education VARCHAR(50),
    marital_status VARCHAR(50),
    income INT,
    kidhome INT,
    teenhome INT,
    dt_customer DATE,
    recency INT,
    mnt_wines INT,
    mnt_fruits INT,
    mnt_meat_products INT,
    mnt_fish_products INT,
    mnt_sweet_products INT,
    mnt_gold_prods INT,
    num_deals_purchases INT,
    num_web_purchases INT,
    num_catalog_purchases INT,
    num_store_purchases INT,
    num_web_visits_month INT,
    accepted_cmp3 INT,
    accepted_cmp4 INT,
    accepted_cmp5 INT,
    accepted_cmp1 INT,
    accepted_cmp2 INT,
    response INT,
    complain INT,
    country VARCHAR(50)
);


DROP TABLE IF EXISTS marketing_data;

SELECT * FROM marketing_data LIMIT 10;

SELECT kidhome + teenhome AS minor_children
FROM marketing_data;

ALTER TABLE marketing_data 
ADD COLUMN minor_children INT;

UPDATE marketing_data 
SET minor_children = kidhome + teenhome;

ALTER TABLE marketing_data 
DROP COLUMN kidhome;

ALTER TABLE marketing_data 
DROP COLUMN teenhome;

ALTER TABLE marketing_data 
RENAME COLUMN mntwines TO wines_amount;

ALTER TABLE marketing_data 
RENAME COLUMN mntfruits TO fruits_amount;

ALTER TABLE marketing_data 
RENAME COLUMN mntmeatproducts TO meat_products_amount;

ALTER TABLE marketing_data 
RENAME COLUMN mntfishproducts TO fish_products_amount;

ALTER TABLE marketing_data 
RENAME COLUMN mntgoldprods TO gold_amount;

ALTER TABLE marketing_data 
RENAME COLUMN mntsweetproducts TO sweets_amount;

ALTER TABLE marketing_data 
RENAME COLUMN numdealspurchases TO sales_deals;

ALTER TABLE marketing_data 
RENAME COLUMN numwebpurchases TO sales_website;

ALTER TABLE marketing_data 
RENAME COLUMN numcatalogpurchases TO sales_catalog;

ALTER TABLE marketing_data 
RENAME COLUMN numstorepurchases TO sales_store;

ALTER TABLE marketing_data 
RENAME COLUMN numwebvisitsmonth TO website_visits;

ALTER TABLE marketing_data 
RENAME COLUMN response TO acceptedcmp6;

ALTER TABLE marketing_data 
RENAME COLUMN dt_customer TO customer_signup_dt;

ALTER TABLE marketing_data 
RENAME COLUMN recency TO last_purchase_days;

SELECT * 
FROM marketing_data 
WHERE id IS NULL;

SELECT * 
FROM marketing_data 
WHERE year_birth IS NULL;

SELECT * 
FROM marketing_data 
WHERE education IS NULL;


-- 24 rows have null incomes

SELECT COUNT(*) 
FROM marketing_data 
WHERE income IS NULL;


SELECT * 
FROM marketing_data 
WHERE customer_signup_dt  IS NULL;


-- total rows = 2240

SELECT COUNT(*)
FROM marketing_data;



-- added a new column: age

ALTER TABLE marketing_data 
ADD COLUMN age INT;

UPDATE marketing_data
SET age = YEAR(CURDATE())-year_birth;


-- max age = 133 (outlier)

SELECT MAX(age), MIN(age)
FROM marketing_data; 


-- 3 people are older than 95

SELECT COUNT(*)
FROM marketing_data
WHERE age > 95;


-- after deleting the outlier values
-- the max age = 86 and min = 30

DELETE FROM marketing_data
WHERE age > 95;


-- inspecting null incomes now

SELECT education, AVG(age)
FROM marketing_data 
WHERE income IS NULL
GROUP BY education;

SELECT education, age, income
FROM marketing_data;



-- substituting the null incomes using the average incomes 
-- of the respective education groups


UPDATE marketing_data m1
JOIN(
	SELECT education, AVG(income) as income
	FROM marketing_data
	WHERE income IS NOT NULL
	GROUP BY education
) m2
ON m1.education = m2.education 
SET m1.income = m2.income
WHERE m1.income IS NULL;



-- 7 rows deleted with illegible marital status

DELETE FROM marketing_data 
WHERE marital_status = 'YOLO'
	OR marital_status = 'Absurd';



-- converted alone category to single

UPDATE marketing_data
SET marital_status = 'Single'
WHERE marital_status = 'Alone';




-- spending totals across all categories
ALTER TABLE marketing_data 
ADD COLUMN total_spend DECIMAL;

UPDATE marketing_data
SET total_spend = wines_amount + fruits_amount + meat_products_amount + fish_products_amount + sweets_amount + gold_amount;


SELECT 
	SUM(wines_amount),
	SUM(fruits_amount),
	SUM(meat_products_amount),
	SUM(fish_products_amount),
	SUM(sweets_amount),
	(SUM(wines_amount) + SUM(fruits_amount) + SUM(meat_products_amount) + SUM(fish_products_amount) + 
	SUM(sweets_amount)+ SUM(gold_amount)) AS grand_total
FROM marketing_data;



-- calculate total spending percentage as compared to their income for each user

SELECT id, income, age, country, (wines_amount + fruits_amount + meat_products_amount + fish_products_amount + sweets_amount 
	+ gold_amount) AS total_spending, ROUND(100.0 * (wines_amount + fruits_amount + meat_products_amount + fish_products_amount + 
	sweets_amount + gold_amount) / income ,2) AS spending_income_pct 
FROM marketing_data;



-- total campaign turnout percentage of 6 campaigns. Result is 27.14% which is not desirable outcome.

-- Add new column campaign success


ALTER TABLE marketing_data
ADD COLUMN campaign_success VARCHAR(10);

UPDATE marketing_data
SET campaign_success = CASE 
	   WHEN acceptedcmp1 = 1 OR
			acceptedcmp2 = 1 OR 
			acceptedcmp3 = 1 OR
			acceptedcmp4 = 1 OR
			acceptedcmp5 = 1 OR
			acceptedcmp6 = 1
		THEN 'Yes'
		ELSE 'No'
END;


-- Campaign success count of YES/NO
SELECT campaign_success, COUNT(*)
FROM marketing_data
GROUP BY campaign_success;


-- precentage of people who said yes in atleast one out of 6 campaigns

SELECT ROUND(100.0 * SUM(CASE WHEN campaign_success = 'Yes' THEN 1 ELSE 0 END) / COUNT(id) ,2) AS campaign_success_pct
FROM marketing_data;



-- max income = 666,666  min= 1730   avg= 52,228.296

SELECT MAX(income), MIN(income), AVG(income)
FROM marketing_data;


-- there is a wide income gap between min and max income of divorced, single, married, widow, and
-- together. There are some meaningless marital status like yolo, alone, absurd

SELECT marital_status, MAX(income), MIN(income), AVG(income)
FROM marketing_data
GROUP BY marital_status;



-- Average website sales per age groups. Elderly people are more prone to ordering using the website.
-- Average number of online orders for people aged 50 above is 4.5, whereas for 30 to 49 is 3.5
-- Also the average number of online orders is constantly increasing with time

SELECT 
	CASE 
		WHEN age >= 30 and age <40 THEN '(30-39)'
		WHEN age >= 40 and age <50 THEN '(40-49)' 
		WHEN age >= 50 and age <60 THEN '(50-59)'
		WHEN age >= 60 and age <70 THEN '(60-69)'
		WHEN age >= 70 and age <80 THEN '(70-79)'
		WHEN age >= 80 and age <90 THEN '(80-89)'
		END  AS age_groups,
	ROUND(AVG(sales_website) ,1)
FROM marketing_data
GROUP BY age_groups 
ORDER BY age_groups ;



/* Average website sales per age income groups. People who earn less tend to order using the website more 
Precisely, people who earn between 110k and 120k place on average 20 orders online. Which is roughly 5 times more
than people coming at second place in terms ordering online.        */


SELECT 
	CASE 
		WHEN income < 10000 THEN 'less than 10k'
		WHEN income >= 10000 AND income < 20000 THEN 'between 10k and 20k' 
		WHEN income >= 20000 AND income < 30000 THEN 'between 20k and 30k' 
		WHEN income >= 30000 AND income < 40000 THEN 'between 30k and 40k' 
		WHEN income >= 40000 AND income < 50000 THEN 'between 40k and 50k' 
		WHEN income >= 50000 AND income < 60000 THEN 'between 50k and 60k' 
		WHEN income >= 60000 AND income < 70000 THEN 'between 60k and 70k'
		WHEN income >= 70000 AND income < 80000 THEN 'between 70k and 80k'
		WHEN income >= 80000 AND income < 90000 THEN 'between 80k and 90k'
		WHEN income >= 90000 AND income < 100000 THEN 'between 90k and 100k'
		WHEN income >= 100000 AND income < 110000 THEN 'between 100k and 110k'
		WHEN income >= 110000 AND income < 120000 THEN 'between 110k and 120k'
		WHEN income >= 120000 AND income < 130000 THEN 'between 120k and 130k'
		WHEN income >= 130000 AND income < 140000 THEN 'between 130k and 140k'
		WHEN income >= 140000 AND income < 150000 THEN 'between 140k and 150k'
		WHEN income >= 150000 AND income < 160000 THEN 'between 150k and 160k'
		WHEN income >= 160000 AND income < 170000 THEN 'between 160k and 170k'
		WHEN income >= 170000 AND income < 180000 THEN 'between 170k and 180k'
		WHEN income >= 180000 AND income < 190000 THEN 'between 180k and 190k'
		WHEN income >= 190000 AND income < 200000 THEN 'between 190k and 200k'
		WHEN income >= 200000 AND income < 210000 THEN 'between 200k and 210k'
		WHEN income >= 210000 AND income < 220000 THEN 'between 210k and 220k'
		WHEN income >= 220000 AND income < 230000 THEN 'between 220k and 230k'
		WHEN income >= 230000 AND income < 240000 THEN 'between 230k and 240k'
		WHEN income >= 240000 AND income < 250000 THEN 'between 240k and 250k'
		WHEN income >= 250000 AND income < 260000 THEN 'between 250k and 260k'
		WHEN income >= 260000 AND income < 270000 THEN 'between 260k and 270k'
		WHEN income >= 270000 AND income < 280000 THEN 'between 270k and 280k'
		WHEN income >= 280000 AND income < 290000 THEN 'between 280k and 290k'
		WHEN income >= 290000 AND income <= 300000 THEN 'between 290k and 300k'
		END  AS income_brackets,
	ROUND(AVG(sales_website) ,1) AS average_online_orders
FROM marketing_data
GROUP BY income_brackets  
ORDER BY average_online_orders DESC;



-- Average online orders per education. People who have education level of graduation and above
-- orders 2 times using the website as compares people who have basic education

SELECT education, ROUND(AVG(sales_website) ,1) AS average_online_orders
FROM marketing_data
GROUP BY education
ORDER BY average_online_orders;


-- People who have been separated from their spouse(divorce/wodow) order a little more from website as compared to 
-- single or couple
SELECT marital_status , ROUND(AVG(sales_website) ,1) AS average_online_orders
FROM marketing_data
GROUP BY marital_status
ORDER BY average_online_orders;

-- All the country's avg online orders number is roughly 4 except Mexico which is 6

SELECT country , ROUND(AVG(sales_website) ,1) AS average_online_orders
FROM marketing_data
GROUP BY country
ORDER BY average_online_orders;

-- People who have more children order less online compared to people with 0 children order more using website
SELECT minor_children , ROUND(AVG(sales_website) ,1) AS average_online_orders
FROM marketing_data
GROUP BY minor_children 
ORDER BY average_online_orders;


-- campaign was the most successful with 332 yeses. The first 5 campaigns had half or less than half as compared to campaign 6.
SELECT SUM(acceptedcmp1) AS campaign_1,
	SUM(acceptedcmp2) AS campaign_2,
	SUM(acceptedcmp3) AS campaign_3,
	SUM(acceptedcmp4) AS campaign_4,
	SUM(acceptedcmp5) AS campaign_5,
	SUM(acceptedcmp6) AS campaign_6
FROM marketing_data;



/*    success rate campaign 1= 6.4, 2= 1.34, 3=7.3, 4=7.48, 5=7.21, 6=14.87     */

WITH success_rate AS (
	SELECT 
		Count(id) AS total_users,
		SUM(acceptedcmp1) AS campaign_1,
		SUM(acceptedcmp2) AS campaign_2,
		SUM(acceptedcmp3) AS campaign_3,
		SUM(acceptedcmp4) AS campaign_4,
		SUM(acceptedcmp5) AS campaign_5,
		SUM(acceptedcmp6) AS campaign_6
	FROM marketing_data
)
SELECT
	ROUND(100.0 *  (campaign_1 / total_users) ,2) AS campaign_1_success_rt,
	ROUND(100.0 *  (campaign_2 / total_users) ,2) AS campaign_2_success_rt,
	ROUND(100.0 *  (campaign_3 / total_users) ,2) AS campaign_3_success_rt,
	ROUND(100.0 *  (campaign_4 / total_users) ,2) AS campaign_4_success_rt,
	ROUND(100.0 *  (campaign_5 / total_users) ,2) AS campaign_5_success_rt,
	ROUND(100.0 *  (campaign_6 / total_users) ,2) AS campaign_6_success_rt
FROM success_rate;



-- Profiling customer
/* An average person in this dataset has gained educational level of graducation and above. Average age is 57 years. 28% people don't have 
 * children. And 50% have only one child. Average person earns $52,228.3 and Average spending is 605.38.     */


-- 1124= 1 child + 421 = 2 children + 53 = 3 children + 635 = 0 child

-- total spend when they have children 1598 people spend 650406. -- total spend when they don't have children 653 people spend 701409

SELECT COUNT(id), AVG(income), SUM(total_spend)
FROM marketing_data
WHERE minor_children <> 0;


SELECT COUNT(id), AVG(income), AVG(total_spend)
FROM marketing_data;

SELECT AVG(age)
FROM marketing_data;



/* wines  = 678,683 and meat_products = 372,668 are top two most profitable products. Sweets and fruits are underperforming 
with close to 60k in sales.    */
SELECT SUM(wines_amount) AS wines_total,
	SUM(fruits_amount) AS fruits_total,
	SUM(meat_products_amount) AS meat_products_total,
	SUM(fish_products_amount) AS fish_products_total,
	SUM(sweets_amount) AS sweets_total,
	SUM(gold_amount) AS gold_total
FROM marketing_data;

	

-- delats = 5191 and catalog = 5939 are underperforming with sales almost half as compared to website and store.
SELECT SUM(sales_deals) AS deals_total,
	   SUM(sales_website) AS website_total,
	   SUM(sales_catalog) AS catalog_total,
	   SUM(sales_store) AS store_total
FROM marketing_data;



-- campaign 6 success analysis

SELECT AVG(age), AVG(income), AVG(minor_children), AVG(total_spend)
FROM marketing_data
WHERE acceptedcmp6 =1;



-- high value customers

SELECT CASE 
			WHEN total_spend <= 400 THEN 'low_spenders'
			WHEN total_spend > 400 AND total_spend <= 1000 THEN 'mid_spenders'
			WHEN total_spend > 500 THEN 'high_spenders'
			END AS spend_bucket, AVG(age), AVG(income), COUNT(id)
FROM marketing_data
GROUP BY spend_bucket;



-- since website and store are most sales drivers so we will analyze factors that affect it

SELECT AVG(age), AVG(income), AVG(minor_children)
FROM marketing_data
WHERE sales_store = 1;

SELECT AVG(age), AVG(income), AVG(minor_children)
FROM marketing_data
WHERE sales_website  = 1;



SELECT * FROM marketing_data; 




























































