# 🛒 Customer Shopping Behavior Analysis

## 📌 Project Overview
This end-to-end data analytics project analyzes customer shopping behavior using transactional data from **3,900 purchases** across multiple retail categories. The goal is to uncover actionable insights into spending patterns, customer segments, product preferences, discount sensitivity, and subscription behavior to guide strategic business decisions.

---

## 📂 Dataset Summary
- **Total Records:** 3,900 rows and 18 columns
- **Key Features:**
  - **Customer Demographics:** `Customer ID`, `Age`, `Gender`, `Location`, `Subscription Status`
  - **Purchase Details:** `Item Purchased`, `Category` (*Clothing, Accessories, Footwear, Outerwear*), `Purchase Amount (USD)`, `Season`, `Size`, `Color`
  - **Shopping Behavior:** `Discount Applied`, `Promo Code Used`, `Previous Purchases`, `Frequency of Purchases`, `Review Rating`, `Payment Method`, `Shipping Type`
- **Missing Data:** 37 missing values in the `Review Rating` column (imputed during preprocessing)

---

## 🛠️ Tech Stack & Tools
- **Python (`pandas`, `numpy`, `sqlalchemy`, `psycopg2`):** Data cleaning, missing-value imputation, feature engineering, and PostgreSQL database ingestion
- **PostgreSQL (pgAdmin 4):** Relational database storage and business analysis using SQL (CTEs, Window Functions, Aggregations)
- **Power BI Desktop:** Interactive dashboard creation and KPI visualization
- **Jupyter Notebook:** Interactive development environment for Python EDA

---

## 🧹 1. Exploratory Data Analysis & Data Cleaning (Python)
1. **Data Loading & Inspection:** Imported `customer_shopping_behavior.csv` using Pandas and examined data types and summary statistics via `df.info()` and `df.describe()`.
2. **Missing Data Handling:** Imputed the 37 missing values in `Review Rating` using the **median rating of each respective product category**.
3. **Column Standardization:** Converted all column names to `snake_case` and renamed `purchase_amount_(usd)` to `purchase_amount` for cleaner SQL querying.
4. **Feature Engineering:**
   - Created `age_group` (*Young Adult, Adult, Middle-aged, Senior*) by binning customer ages into quartiles using `pd.qcut()`.
   - Created `purchase_frequency_days` by mapping text intervals to numerical day counts (*Weekly* = 7, *Fortnightly / Bi-Weekly* = 14, *Monthly* = 30, *Quarterly / Every 3 Months* = 90, *Annually* = 365).
5. **Data Consistency Check:** Verified that `discount_applied` and `promo_code_used` contained identical values across all 3,900 rows and dropped the redundant `promo_code_used` column.
6. **Database Integration:** Connected Python to PostgreSQL using SQLAlchemy and loaded the cleaned DataFrame into the database for SQL analysis.

---

## 🗄️ 2. Data Analysis Using SQL (PostgreSQL)
Structured SQL queries were executed to answer 10 core business questions:

1. **Revenue by Gender:**
   - **Male:** $157,890 | **Female:** $75,191
2. **High-Spending Discount Users:**
   - Identified **839 customers** who applied a discount yet still spent above the overall average purchase amount ($59.76).
3. **Top 5 Products by Average Review Rating:**
   - **Gloves** (3.86), **Sandals** (3.84), **Boots** (3.82), **Hat** (3.80), and **Skirt** (3.78).
4. **Shipping Type Comparison (Standard vs. Express):**
   - **Express Shipping** users spent **$60.48** on average compared to **$58.46** for **Standard Shipping**.
5. **Subscribers vs. Non-Subscribers:**
   - **Subscribers (1,053 customers):** $59.49 avg spend | $62,645 total revenue
   - **Non-Subscribers (2,847 customers):** $59.87 avg spend | $170,436 total revenue
6. **Top 5 Discount-Dependent Products:**
   - **Hat** (50.00%), **Sneakers** (49.66%), **Coat** (49.07%), **Sweater** (48.17%), and **Pants** (47.37%).
7. **Customer Segmentation (by Previous Purchases):**
   - **Loyal:** 3,116 customers | **Returning:** 701 customers | **New:** 83 customers
8. **Top 3 Most Purchased Products per Category:**
   - **Accessories:** Jewelry (171), Sunglasses (161), Belt (161)
   - **Clothing:** Blouse (171), Pants (171), Shirt (169)
   - **Footwear:** Sandals (160), Shoes (150), Sneakers (145)
   - **Outerwear:** Jacket (163), Coat (161)
9. **Repeat Buyers & Subscription Likelihood (>5 Previous Purchases):**
   - **Non-Subscribers:** 2,518 repeat buyers | **Subscribers:** 958 repeat buyers
10. **Revenue Contribution by Age Group:**
    - **Young Adult:** $62,143 | **Middle-aged:** $59,197 | **Adult:** $55,978 | **Senior:** $55,763

---

## 📊 3. Power BI Dashboard
Built an interactive **Customer Behavior Dashboard** in Power BI featuring:
- **KPI Cards:** `3.9K` Total Customers, `$59.76` Average Purchase Amount, and `3.75` Average Review Rating
- **Interactive Slicers:** Filter dynamically by `Subscription Status`, `Gender`, `Category`, and `Shipping Type`
- **Visualizations:**
  - *% of Customers by Subscription Status* (Donut Chart: 27% Subscribed vs. 73% Non-Subscribed)
  - *Revenue by Category* & *Sales by Category* (Column Charts)
  - *Revenue by Age Group* & *Sales by Age Group* (Horizontal Bar Charts)

---

## 💡 Business Recommendations
- **Boost Subscriptions:** Promote exclusive subscriber benefits and target the 2,518 repeat buyers (>5 purchases) who remain unsubscribed.
- **Customer Loyalty Programs:** Reward repeat buyers with tiered perks to transition *Returning* shoppers (701) into the *Loyal* segment.
- **Review Discount Policy:** Audit margins on high-discount products (Hats, Sneakers, Coats) to balance sales volume with profitability.
- **Product Positioning:** Highlight top-rated products (Gloves, Sandals, Boots) and category bestsellers in marketing campaigns.
- **Targeted Marketing:** Focus marketing spend on top revenue-generating age groups (*Young Adult* and *Middle-aged*) and *Express Shipping* shoppers.

---

## 📁 Repository Structure
- `customer_shopping_behavior.csv` — Raw transactional dataset (3,900 records)
- `Customer_Shopping_Behavior_Analysis_jupyter_notebook.ipynb` — Python data cleaning, EDA, and database upload script
- `Customer_Behavior_Sql_Queries.sql` — PostgreSQL queries for business analysis
- `Customer_behavior_Analysis_Using_Power_BI.pbix` — Interactive Power BI dashboard file
- `Customer Shopping Behavior Analysis Report.pdf` — Detailed project documentation and findings report
- `Customer_Behavior_Analysis_ppt.pptx` — Executive presentation slides
