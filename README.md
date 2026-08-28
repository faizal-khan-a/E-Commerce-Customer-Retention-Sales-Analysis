# E-Commerce Customer Retention & Sales Analysis

## 📊 Project Overview

This project analyzes e-commerce sales, customer purchasing behavior, product performance, payment methods, seller performance, and customer retention using the Olist Brazilian E-Commerce dataset.

The project follows an end-to-end data analytics workflow:

**Raw Data → SQL Analysis → RFM Customer Segmentation → Power BI Dashboard → Business Insights**

SQL was used for data analysis and transformation, RFM methodology was used for customer segmentation, and Power BI was used to create an interactive business intelligence dashboard.

---

## 🎯 Business Problem

The business generates a large number of orders, but a large proportion of customers make only one purchase.

The analysis aims to understand:

- Overall sales and revenue performance
- Monthly revenue trends
- Customer purchasing behavior
- One-time vs repeat customers
- Customer retention opportunities
- High-value customer segments
- Top-performing product categories
- Geographic sales performance
- Seller performance
- Payment-method behavior

### Main Business Question

> How can the e-commerce business use customer and sales data to improve revenue performance, increase repeat purchases, and strengthen customer retention?

---

## 🎯 Project Objectives

### Sales Analysis
- Calculate total revenue and orders
- Analyze monthly revenue trends
- Calculate Average Order Value
- Identify top-performing product categories

### Customer Analysis
- Calculate total customers
- Identify one-time and repeat customers
- Calculate repeat customer rate
- Analyze customers by geographic location

### Customer Retention
- Perform RFM analysis
- Segment customers based on purchasing behavior
- Identify Champions, Loyal, Potential, and At Risk/Lost customers
- Analyze revenue contribution by customer segment

### Product & Seller Analysis
- Identify top-performing product categories
- Analyze product sales volume
- Identify top seller cities
- Compare category and geographic performance

### Business Intelligence
- Build an interactive Power BI dashboard
- Create KPI cards and analytical visuals
- Add interactive slicers
- Present actionable business insights

---

# 🗂️ Dataset

## Olist Brazilian E-Commerce Dataset

The project uses the Olist Brazilian E-Commerce dataset containing information about Brazilian e-commerce transactions.

### Main Tables

| Table | Description |
|---|---|
| Customers | Customer information and location |
| Orders | Order details and timestamps |
| Order Items | Products purchased in each order |
| Products | Product information |
| Payments | Payment transactions and payment values |
| Reviews | Customer review information |
| Sellers | Seller information and location |
| Categories | Product category information |
| Geolocation | Brazilian geographic information |

### Approximate Dataset Size

- **99K+ customers/orders**
- **112K+ order items**
- **32K+ products**
- **103K+ payment records**
- **99K+ reviews**
- **3K+ sellers**
- **1M+ geolocation records**

---

# 🧹 Data Cleaning & Preparation

The raw datasets were loaded into MySQL staging tables and validated before analysis.

### Preparation activities

- Loaded CSV datasets into MySQL
- Created staging tables
- Validated row counts
- Checked duplicate records
- Checked orphan relationships
- Validated numeric fields
- Prepared date fields
- Joined related tables
- Created customer-level analysis
- Created RFM scores
- Created customer segments
- Prepared data for Power BI

---

# 🗄️ SQL Analysis

MySQL was used for the main analytical calculations.

### Key SQL Analysis

- Total revenue
- Total orders
- Total customers
- Total items sold
- Total freight
- Average Order Value
- Monthly revenue
- Product category revenue
- Customer geographic analysis
- Seller-city revenue
- Payment-method analysis
- One-time vs repeat customers
- Repeat customer rate
- RFM customer segmentation
- Revenue contribution by customer segment

---

# 📌 Validated Business Metrics

| Metric | Result |
|---|---:|
| Total Orders | **99,441** |
| Total Unique Customers | **96,096** |
| Total Items Sold | **112,650** |
| Product Revenue | **₹13.59M** |
| Average Order Value | **₹136.68** |
| One-Time Customers | **93,099** |
| Repeat Customers | **2,997** |
| Repeat Customer Rate | **3.12%** |
| RFM Customers | **95,420** |

> Note: Power BI displays some values in rounded formats such as 14M, 99K, 96K, and 113K.

---

# 👥 Customer Retention Analysis

Customers were classified based on the number of orders associated with their `customer_unique_id`.

### Customer Results

| Customer Type | Customers |
|---|---:|
| One-Time Customers | **93,099** |
| Repeat Customers | **2,997** |
| Repeat Customer Rate | **3.12%** |

### Key Finding

Only **3.12% of customers are repeat customers**, while approximately **96.88% are one-time customers**.

This highlights customer retention as the biggest growth opportunity in the analysis.

---

# 📈 RFM Customer Segmentation

RFM analysis was used to understand customer value and purchasing behavior.

### RFM Components

**Recency**  
How recently the customer purchased.

**Frequency**  
How often the customer purchased.

**Monetary**  
How much the customer spent.

Customers were scored using Recency, Frequency, and Monetary values and then grouped into four business segments.

### RFM Segment Results

| Segment | Customers | Avg Recency | Avg Frequency | Avg Monetary | Revenue |
|---|---:|---:|---:|---:|---:|
| Loyal Customers | **43,604** | 252.6 | 1.02 | 165.97 | **₹7.24M** |
| Potential Customers | **34,346** | 323.3 | 1.00 | 74.61 | **₹2.56M** |
| Champions | **12,031** | 216.2 | 1.19 | 299.99 | **₹3.61M** |
| At Risk / Lost | **5,439** | 517.1 | 1.00 | 33.65 | **₹0.18M** |
| **Total** | **95,420** | — | — | — | **₹13.59M** |

### RFM Interpretation

- **Champions:** High-value and highly engaged customers
- **Loyal Customers:** Strong customer relationship and important revenue contribution
- **Potential Customers:** Customers with potential to become repeat buyers
- **At Risk / Lost:** Customers showing low engagement and requiring reactivation

---

# 📊 Power BI Dashboard

The final Power BI report contains four analytical pages.

## Page 1 — Executive Sales Overview

Provides a high-level view of:

- Total Revenue
- Total Orders
- Total Customers
- Average Order Value
- Total Items Sold
- Total Freight
- Repeat Customer Rate
- Customer Retention
- Monthly Revenue
- Top Product Categories
- Seller Performance
- Payment Revenue

---

## Page 2 — Customer & Retention Analysis

Focuses on customer behavior and retention.

Includes:

- Total Customers
- One-Time Customers
- Repeat Customers
- Repeat Customer Rate
- RFM Customer Count
- Customer Distribution by RFM Segment
- Customers by State
- Revenue Contribution by Customer Segment
- State filtering

---

## Page 3 — Product & Sales Performance Analysis

Focuses on product and geographic sales performance.

Includes:

- Total Revenue
- Total Products
- Total Items Sold
- Average Order Value
- Total Orders
- Monthly Revenue Trend
- Top Product Categories
- Revenue by Seller City
- Product Category Performance

---

## Page 4 — Executive Summary

Provides a concise management-level overview of:

- Revenue
- Orders
- Customers
- Average Order Value
- Items Sold
- Repeat Customer Rate
- Monthly Revenue
- Top Categories
- Top Seller Cities
- Customer Retention

---

# 🔑 Key Business Insights

### 1. Customer retention is the biggest opportunity

The repeat customer rate is only **3.12%**, while approximately **96.88% of customers are one-time buyers**.

This indicates significant potential to increase repeat purchases and customer lifetime value.

### 2. Loyal Customers are the largest RFM segment

Approximately **43.6K customers** are classified as Loyal Customers and contribute approximately **₹7.24M** in revenue.

### 3. Potential Customers represent a major conversion opportunity

Approximately **34.3K customers** are classified as Potential Customers.

This segment can be targeted with campaigns designed to encourage a second purchase.

### 4. Champions are valuable customers

Approximately **12K Champions** contribute approximately **₹3.61M** in revenue.

They should be prioritized for loyalty and retention initiatives.

### 5. Health & Beauty is the leading revenue category

Health & Beauty generates approximately **₹1.26M** in revenue.

### 6. São Paulo is a major market

São Paulo is the strongest geographic market shown in the dashboard.

### 7. November 2017 recorded the strongest monthly revenue

Monthly revenue peaked at approximately **₹1.01M** in November 2017.

### 8. Credit card is the dominant payment method by value

Credit card transactions contribute approximately **₹12.54M** in payment value.

---

# 💡 Business Recommendations

## 1. Improve Customer Retention

Introduce:

- Personalized email campaigns
- Second-purchase discounts
- Loyalty programs
- Post-purchase follow-ups
- Personalized product recommendations

## 2. Target Potential Customers

The approximately **34K Potential Customers** should be targeted with personalized promotions designed to generate a second purchase.

## 3. Reward Champions

Provide Champions with:

- Exclusive discounts
- Early product access
- Loyalty rewards
- Personalized recommendations

## 4. Reactivate At-Risk Customers

Use:

- Win-back campaigns
- Limited-time discounts
- Personalized recommendations
- Re-engagement emails

## 5. Increase Cross-Selling

Use high-performing categories to recommend complementary products to customers.

## 6. Leverage Seasonal Demand

Investigate the November sales peak and plan promotional campaigns around high-performing periods.

## 7. Focus on Strong Geographic Markets

Optimize:

- Marketing
- Inventory
- Logistics
- Seller partnerships

in high-performing markets such as São Paulo.

---

# 🛠️ Tools & Technologies

| Tool / Technology | Purpose |
|---|---|
| **MySQL** | Data storage and SQL analysis |
| **SQL** | Data extraction and analytical queries |
| **Python** | Data preparation and analysis |
| **Pandas** | Data manipulation |
| **Power Query** | Data transformation |
| **Power BI** | Dashboard development and visualization |
| **DAX** | Measures and KPI calculations |
| **Excel** | Supporting analysis |
| **GitHub** | Version control and project portfolio |

---

# 📂 Project Structure

```text
E-Commerce-Customer-Retention-Analysis/
│
├── README.md
│
├── SQL/
│   └── Ecommerce_Customer_Retention_Analysis.sql
│
├── PowerBI/
│   └── E-Commerce_Sales_Analytics.pbix
│
├── Documentation/
│   └── E-Commerce_Customer_Sales_Analysis_Documentation.pdf
│
└── Screenshots/
    ├── executive_sales_overview.png
    ├── customer_retention_analysis.png
    ├── product_sales_analysis.png
    └── executive_summary.png
