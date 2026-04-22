# 🛒 Customer Shopping Behavior Analysis

> An end-to-end data analytics project analyzing 3,900 retail transactions to uncover spending patterns, customer segments, product preferences, and subscription behavior — built with Python, PostgreSQL, Power BI, and Gamma.

---

## 📌 Overview

This project performs a full analytics pipeline on a real-world retail dataset. Starting from raw transactional data, it covers data cleaning and exploration in Python, structured business querying in PostgreSQL, visual storytelling via an interactive Power BI dashboard, and a final executive-ready report and presentation.

The core objective is to answer key business questions: *Who are the most valuable customers? Which products drive revenue? How do discounts and subscriptions affect buying behavior?*

---

## 📁 Dataset

| Attribute        | Details                                                               |
|-----------------|-----------------------------------------------------------------------|
| **Rows**         | 3,900 transactions                                                    |
| **Columns**      | 18 features                                                           |
| **Source**       | Retail customer transactions dataset                                  |
| **Missing Data** | 37 null values in `review_rating` — imputed using per-category median |

**Feature Groups:**

| Category               | Columns                                                                     |
|------------------------|-----------------------------------------------------------------------------|
| Customer Demographics  | `age`, `gender`, `location`, `subscription_status`                          |
| Purchase Details       | `item_purchased`, `category`, `purchase_amount`, `season`, `size`, `color`  |
| Shopping Behavior      | `discount_applied`, `previous_purchases`, `frequency_of_purchases`, `review_rating`, `shipping_type` |
| Engineered Features    | `age_group` *(binned)*, `purchase_frequency_days`                           |

> `promo_code_used` was dropped after confirming full redundancy with `discount_applied`.

---

## 🛠️ Tools & Technologies

| Category            | Tools Used                            |
|--------------------|---------------------------------------|
| **Language**        | Python 3.x                            |
| **Data Analysis**   | Pandas, NumPy                         |
| **Visualisation**   | Matplotlib, Seaborn                   |
| **Database**        | PostgreSQL                            |
| **SQL Client**      | pgAdmin                               |
| **BI Dashboard**    | Power BI Desktop                      |
| **Presentation**    | Gamma (AI-powered slides)             |
| **Version Control** | Git & GitHub                          |

---

## 🔄 Project Steps

### 1. 🐍 Data Loading & Initial Exploration (Python)
- Imported the dataset using `pandas.read_csv()`
- Inspected structure with `.info()`, `.describe()`, and `.head()`
- Confirmed 3,900 rows × 18 columns with mixed data types

### 2. 🔍 Exploratory Data Analysis (EDA)
- Analysed distributions of purchase amounts, review ratings, and customer age
- Visualised category-wise and gender-wise revenue splits using Seaborn and Matplotlib
- Explored seasonal trends, discount usage patterns, and purchase frequency
- Identified correlations between previous purchases and subscription status

### 3. 🧹 Data Cleaning & Feature Engineering
- **Missing Values:** Imputed 37 null `review_rating` values using the median rating per product category
- **Column Standardisation:** Renamed all columns to `snake_case` for consistency
- **Feature Engineering:**
  - Created `age_group` by binning ages into: `Young Adult`, `Adult`, `Middle-aged`, `Senior`
  - Created `purchase_frequency_days` from purchase frequency data
- **Redundancy Check:** Verified and dropped `promo_code_used` (100% overlap with `discount_applied`)
- **Database Export:** Connected Python to PostgreSQL via `SQLAlchemy` and loaded the cleaned DataFrame directly into the database

### 4. 🗄️ SQL Analysis — Business Questions (PostgreSQL)

All 10 queries are saved in `customer_behavior.sql`. Key analyses performed:

| # | Business Question | SQL Technique |
|---|-------------------|---------------|
| 1 | Revenue by Gender | `GROUP BY` + `SUM()` |
| 2 | High-Spending Discount Users | Subquery with `AVG()` |
| 3 | Top 5 Products by Average Rating | `GROUP BY` + `ORDER BY` + `LIMIT` |
| 4 | Express vs. Standard Shipping Spend | Filtered `AVG()` aggregation |
| 5 | Subscribers vs. Non-Subscribers | Multi-metric `GROUP BY` |
| 6 | Most Discount-Dependent Products | `CASE WHEN` + percentage calculation |
| 7 | Customer Segmentation (New / Returning / Loyal) | CTE + `CASE WHEN` |
| 8 | Top 3 Products per Category | CTE + `ROW_NUMBER()` window function |
| 9 | Repeat Buyers & Subscription Correlation | Filtered `COUNT()` |
| 10 | Revenue by Age Group | `GROUP BY age_group` + `SUM()` |

### 5. 📊 Power BI Dashboard
- Connected Power BI directly to the cleaned PostgreSQL dataset
- Built interactive visuals with slicers for `Subscription Status`, `Gender`, `Category`, and `Shipping Type`
- Includes KPI cards, donut chart, horizontal bar charts, and category revenue comparisons

### 6. 📝 Report
- Documented the full methodology, SQL query outputs with result tables, and business recommendations
- Exported as a polished PDF: `Customer_Shopping_Behavior_Analysis.pdf`

### 7. 📽️ Presentation (Gamma)
- Summarised the project into a clean executive slide deck using [Gamma](https://gamma.app)
- Covers: problem statement, key metrics, SQL findings, dashboard walkthrough, and strategic recommendations

---

## 📊 Dashboard Preview

> Power BI file: `customer_behavior_dashboard.pbix`

![Dashboard Preview](assets/dashboard_preview.png)

**Dashboard KPIs at a Glance:**

| Metric | Value |
|--------|-------|
| 👥 Total Customers | 3,900 |
| 💰 Average Purchase Amount | $59.76 |
| ⭐ Average Review Rating | 3.75 / 5.00 |
| 🔔 Subscription Rate | 27% Subscribed / 73% Not Subscribed |

**Visuals included:**
- % of Customers by Subscription Status *(donut chart)*
- Revenue by Category & Sales by Category *(bar charts)*
- Revenue by Age Group & Sales by Age Group *(horizontal bar charts)*
- Interactive slicers: Subscription Status, Gender, Category, Shipping Type

---

## 📈 Key Results & Insights

**💰 Revenue & Spending**
- Male customers generated **$157,890** vs. **$75,191** for female customers
- **839 customers** applied discounts yet still spent above the dataset average of $59.76
- Express shipping users spend slightly more on average (**$60.48**) compared to Standard (**$58.46**)

**⭐ Product Performance**
- Top-rated products: **Gloves (3.86)**, Sandals (3.84), Boots (3.82), Hat (3.80), Skirt (3.78)
- Most discount-dependent products: **Hat (50%)**, Sneakers (49.66%), Coat (49.07%), Sweater (48.17%), Pants (47.37%)
- Top sellers by category: *Accessories → Jewelry (171)*, *Clothing → Blouse & Pants (171 each)*, *Footwear → Sandals (160)*, *Outerwear → Jacket (163)*

**👥 Customer Segments**
- **Loyal customers dominate:** 3,116 out of 3,900 (80%) have 10+ previous purchases
- Only **83 new customers** with a single purchase — indicating strong retention
- Among repeat buyers with 5+ purchases: **2,518 are non-subscribers** vs. only 958 subscribers — a significant upsell opportunity

**📅 Revenue by Age Group**
- **Young Adults** lead revenue at **$62,143**, followed by Middle-aged (**$59,197**), Adult (**$55,978**), and Senior (**$55,763**)
- Balanced revenue across all groups suggests broad demographic appeal

---

## 💡 Business Recommendations

1. **Boost Subscription Conversions** — 73% of customers are unsubscribed, including 2,518 repeat buyers. Targeted subscription promotions could significantly grow recurring revenue.
2. **Formalise a Loyalty Rewards Program** — Retain the 3,116 loyal customers and create incentives to move the 701 returning customers into the loyal tier faster.
3. **Review Discount Strategy** — Products like Hat and Sneakers rely on discounts nearly 50% of the time. Investigate margin impact and test value-led messaging as an alternative.
4. **Promote Top-Rated Products** — Feature Gloves, Sandals, and Boots prominently in marketing materials and homepage sections.
5. **Target Young Adult Segment** — The highest-spending group at $62K; prioritise product launches, campaigns, and loyalty perks for this demographic.

---
