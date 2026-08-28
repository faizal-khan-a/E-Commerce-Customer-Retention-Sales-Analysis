/*
============================================================
E-COMMERCE CUSTOMER RETENTION & SALES ANALYSIS
FINAL PORTFOLIO SQL SCRIPT
Dataset: Olist Brazilian E-Commerce Public Dataset
Database: ecommerce_analysis
============================================================

Sections:
1. Staging tables and data loading
2. Data validation
3. Core business KPIs
4. Customer retention
5. Monthly sales
6. Product/category analysis
7. Seller/geographic analysis
8. Payment analysis
9. RFM analysis
10. Final RFM summary for Power BI

Note:
- Change the CSV paths if your files are stored elsewhere.
- Product revenue = SUM(order_items.price); freight is separate.
- The RFM analysis date is fixed at 2018-10-18 to reproduce the
  validated project results.
*/

USE ecommerce_analysis;

-- =========================================================
-- 1. STAGING TABLES
-- =========================================================

DROP TABLE IF EXISTS products_staging;
CREATE TABLE products_staging (
    product_id VARCHAR(50),
    product_category_name VARCHAR(150),
    product_name_lenght VARCHAR(50),
    product_description_lenght VARCHAR(50),
    product_photos_qty VARCHAR(50),
    product_weight_g VARCHAR(50),
    product_length_cm VARCHAR(50),
    product_height_cm VARCHAR(50),
    product_width_cm VARCHAR(50)
);

DROP TABLE IF EXISTS customers_staging;
CREATE TABLE customers_staging (
    customer_id VARCHAR(50),
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix VARCHAR(20),
    customer_city VARCHAR(100),
    customer_state VARCHAR(10)
);

DROP TABLE IF EXISTS orders_staging;
CREATE TABLE orders_staging (
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    order_status VARCHAR(30),
    order_purchase_timestamp VARCHAR(50),
    order_approved_at VARCHAR(50),
    order_delivered_carrier_date VARCHAR(50),
    order_delivered_customer_date VARCHAR(50),
    order_estimated_delivery_date VARCHAR(50)
);

DROP TABLE IF EXISTS order_items_staging;
CREATE TABLE order_items_staging (
    order_id VARCHAR(50),
    order_item_id VARCHAR(20),
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date VARCHAR(50),
    price VARCHAR(50),
    freight_value VARCHAR(50)
);

DROP TABLE IF EXISTS payments_staging;
CREATE TABLE payments_staging (
    order_id VARCHAR(50),
    payment_sequential VARCHAR(20),
    payment_type VARCHAR(50),
    payment_installments VARCHAR(20),
    payment_value VARCHAR(50)
);

DROP TABLE IF EXISTS reviews_staging;
CREATE TABLE reviews_staging (
    review_id VARCHAR(50),
    order_id VARCHAR(50),
    review_score VARCHAR(20),
    review_comment_title VARCHAR(500),
    review_comment_message TEXT,
    review_creation_date VARCHAR(50),
    review_answer_timestamp VARCHAR(50)
);

DROP TABLE IF EXISTS sellers_staging;
CREATE TABLE sellers_staging (
    seller_id VARCHAR(50),
    seller_zip_code_prefix VARCHAR(20),
    seller_city VARCHAR(100),
    seller_state VARCHAR(10)
);

DROP TABLE IF EXISTS geolocation_staging;
CREATE TABLE geolocation_staging (
    geolocation_zip_code_prefix VARCHAR(20),
    geolocation_lat VARCHAR(50),
    geolocation_lng VARCHAR(50),
    geolocation_city VARCHAR(100),
    geolocation_state VARCHAR(10)
);

DROP TABLE IF EXISTS category_translation_staging;
CREATE TABLE category_translation_staging (
    product_category_name VARCHAR(150),
    product_category_name_english VARCHAR(150)
);

-- =========================================================
-- 2. LOAD CSV DATA
-- =========================================================
-- If LOCAL INFILE is disabled, enable it in your MySQL
-- connection/configuration before running these statements.

LOAD DATA LOCAL INFILE 'C:/Users/Aliya khan/Desktop/project 4/olist_customers_dataset.csv'
INTO TABLE customers_staging
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/Aliya khan/Desktop/project 4/olist_orders_dataset.csv'
INTO TABLE orders_staging
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/Aliya khan/Desktop/project 4/olist_order_items_dataset.csv'
INTO TABLE order_items_staging
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/Aliya khan/Desktop/project 4/olist_products_dataset.csv'
INTO TABLE products_staging
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/Aliya khan/Desktop/project 4/olist_order_payments_dataset.csv'
INTO TABLE payments_staging
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/Aliya khan/Desktop/project 4/olist_order_reviews_dataset.csv'
INTO TABLE reviews_staging
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/Aliya khan/Desktop/project 4/olist_sellers_dataset.csv'
INTO TABLE sellers_staging
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/Aliya khan/Desktop/project 4/olist_geolocation_dataset.csv'
INTO TABLE geolocation_staging
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Users/Aliya khan/Desktop/project 4/product_category_name_translation.csv'
INTO TABLE category_translation_staging
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- =========================================================
-- 3. DATA VALIDATION
-- =========================================================

SELECT 'Customers' AS table_name, COUNT(*) AS row_count FROM customers_staging
UNION ALL SELECT 'Orders', COUNT(*) FROM orders_staging
UNION ALL SELECT 'Order Items', COUNT(*) FROM order_items_staging
UNION ALL SELECT 'Products', COUNT(*) FROM products_staging
UNION ALL SELECT 'Payments', COUNT(*) FROM payments_staging
UNION ALL SELECT 'Reviews', COUNT(*) FROM reviews_staging
UNION ALL SELECT 'Sellers', COUNT(*) FROM sellers_staging
UNION ALL SELECT 'Geolocation', COUNT(*) FROM geolocation_staging
UNION ALL SELECT 'Category Translation', COUNT(*) FROM category_translation_staging;

-- Duplicate checks
SELECT customer_id, COUNT(*) AS duplicate_count
FROM customers_staging GROUP BY customer_id HAVING COUNT(*) > 1;

SELECT order_id, COUNT(*) AS duplicate_count
FROM orders_staging GROUP BY order_id HAVING COUNT(*) > 1;

SELECT order_id, order_item_id, COUNT(*) AS duplicate_count
FROM order_items_staging
GROUP BY order_id, order_item_id HAVING COUNT(*) > 1;

SELECT product_id, COUNT(*) AS duplicate_count
FROM products_staging GROUP BY product_id HAVING COUNT(*) > 1;

SELECT seller_id, COUNT(*) AS duplicate_count
FROM sellers_staging GROUP BY seller_id HAVING COUNT(*) > 1;

SELECT order_id, payment_sequential, COUNT(*) AS duplicate_count
FROM payments_staging
GROUP BY order_id, payment_sequential HAVING COUNT(*) > 1;

SELECT review_id, COUNT(*) AS duplicate_count
FROM reviews_staging GROUP BY review_id HAVING COUNT(*) > 1;

-- Orphan relationship checks
SELECT COUNT(*) AS orphan_orders
FROM orders_staging o
LEFT JOIN customers_staging c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT COUNT(*) AS orphan_order_items
FROM order_items_staging oi
LEFT JOIN orders_staging o ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

SELECT COUNT(*) AS orphan_products
FROM order_items_staging oi
LEFT JOIN products_staging p ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

SELECT COUNT(*) AS orphan_sellers
FROM order_items_staging oi
LEFT JOIN sellers_staging s ON oi.seller_id = s.seller_id
WHERE s.seller_id IS NULL;

SELECT COUNT(*) AS orphan_payments
FROM payments_staging p
LEFT JOIN orders_staging o ON p.order_id = o.order_id
WHERE o.order_id IS NULL;

SELECT COUNT(*) AS orphan_reviews
FROM reviews_staging r
LEFT JOIN orders_staging o ON r.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Basic numeric/date checks
SELECT COUNT(*) AS invalid_price_rows
FROM order_items_staging
WHERE CAST(price AS DECIMAL(12,2)) < 0;

SELECT COUNT(*) AS invalid_freight_rows
FROM order_items_staging
WHERE CAST(freight_value AS DECIMAL(12,2)) < 0;

SELECT COUNT(*) AS invalid_payment_rows
FROM payments_staging
WHERE CAST(payment_value AS DECIMAL(12,2)) <= 0;

SELECT COUNT(*) AS invalid_installment_rows
FROM payments_staging
WHERE CAST(payment_installments AS UNSIGNED) <= 0;

SELECT COUNT(*) AS invalid_review_scores
FROM reviews_staging
WHERE CAST(review_score AS UNSIGNED) < 1
   OR CAST(review_score AS UNSIGNED) > 5;

SELECT MIN(order_purchase_timestamp) AS earliest_order,
       MAX(order_purchase_timestamp) AS latest_order
FROM orders_staging;

-- =========================================================
-- 4. CORE BUSINESS KPIs
-- =========================================================

SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT c.customer_unique_id) AS total_customers,
    COUNT(DISTINCT oi.order_id) AS orders_with_items,
    COUNT(*) AS total_items_sold,
    ROUND(SUM(CAST(oi.price AS DECIMAL(12,2))), 2) AS total_product_revenue,
    ROUND(SUM(CAST(oi.freight_value AS DECIMAL(12,2))), 2) AS total_freight,
    ROUND(
        SUM(CAST(oi.price AS DECIMAL(12,2))) /
        COUNT(DISTINCT oi.order_id), 2
    ) AS average_order_value
FROM order_items_staging oi
JOIN orders_staging o ON oi.order_id = o.order_id
JOIN customers_staging c ON o.customer_id = c.customer_id;

-- =========================================================
-- 5. CUSTOMER RETENTION
-- =========================================================

WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS order_count
    FROM customers_staging c
    JOIN orders_staging o ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
)
SELECT
    COUNT(*) AS total_customers,
    SUM(order_count = 1) AS one_time_customers,
    SUM(order_count > 1) AS repeat_customers,
    ROUND(SUM(order_count > 1) / COUNT(*) * 100, 2)
        AS repeat_customer_rate_pct
FROM customer_orders;

WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS order_count
    FROM customers_staging c
    JOIN orders_staging o ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
),
customer_revenue AS (
    SELECT
        c.customer_unique_id,
        SUM(CAST(oi.price AS DECIMAL(12,2))) AS revenue
    FROM customers_staging c
    JOIN orders_staging o ON c.customer_id = o.customer_id
    JOIN order_items_staging oi ON o.order_id = oi.order_id
    GROUP BY c.customer_unique_id
)
SELECT
    CASE WHEN co.order_count > 1
         THEN 'Repeat Customer'
         ELSE 'One-Time Customer'
    END AS customer_type,
    COUNT(*) AS customers,
    ROUND(SUM(cr.revenue), 2) AS revenue
FROM customer_orders co
JOIN customer_revenue cr
    ON co.customer_unique_id = cr.customer_unique_id
GROUP BY customer_type;

-- =========================================================
-- 6. MONTHLY REVENUE
-- =========================================================

SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS order_month,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT c.customer_unique_id) AS unique_customers,
    ROUND(SUM(CAST(oi.price AS DECIMAL(12,2))), 2) AS revenue
FROM orders_staging o
JOIN customers_staging c ON o.customer_id = c.customer_id
JOIN order_items_staging oi ON o.order_id = oi.order_id
GROUP BY DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')
ORDER BY order_month;

-- =========================================================
-- 7. PRODUCT & CATEGORY ANALYSIS
-- =========================================================

SELECT
    COALESCE(ct.product_category_name_english,
             p.product_category_name, 'Unknown') AS product_category,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    COUNT(*) AS items_sold,
    ROUND(SUM(CAST(oi.price AS DECIMAL(12,2))), 2) AS revenue,
    ROUND(AVG(CAST(oi.price AS DECIMAL(12,2))), 2)
        AS average_item_price
FROM order_items_staging oi
JOIN products_staging p ON oi.product_id = p.product_id
LEFT JOIN category_translation_staging ct
    ON p.product_category_name = ct.product_category_name
GROUP BY COALESCE(ct.product_category_name_english,
                  p.product_category_name, 'Unknown')
ORDER BY revenue DESC;

SELECT
    COALESCE(ct.product_category_name_english,
             p.product_category_name, 'Unknown') AS product_category,
    ROUND(SUM(CAST(oi.price AS DECIMAL(12,2))), 2) AS revenue
FROM order_items_staging oi
JOIN products_staging p ON oi.product_id = p.product_id
LEFT JOIN category_translation_staging ct
    ON p.product_category_name = ct.product_category_name
GROUP BY COALESCE(ct.product_category_name_english,
                  p.product_category_name, 'Unknown')
ORDER BY revenue DESC
LIMIT 10;

SELECT
    COALESCE(ct.product_category_name_english,
             p.product_category_name, 'Unknown') AS product_category,
    COUNT(*) AS items_sold
FROM order_items_staging oi
JOIN products_staging p ON oi.product_id = p.product_id
LEFT JOIN category_translation_staging ct
    ON p.product_category_name = ct.product_category_name
GROUP BY COALESCE(ct.product_category_name_english,
                  p.product_category_name, 'Unknown')
ORDER BY items_sold DESC
LIMIT 10;

-- =========================================================
-- 8. SELLER & GEOGRAPHIC ANALYSIS
-- =========================================================

SELECT
    s.seller_city,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    ROUND(SUM(CAST(oi.price AS DECIMAL(12,2))), 2) AS revenue
FROM order_items_staging oi
JOIN sellers_staging s ON oi.seller_id = s.seller_id
GROUP BY s.seller_city
ORDER BY revenue DESC
LIMIT 10;

SELECT
    c.customer_state,
    COUNT(DISTINCT c.customer_unique_id) AS unique_customers,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(CAST(oi.price AS DECIMAL(12,2))), 2) AS revenue
FROM customers_staging c
JOIN orders_staging o ON c.customer_id = o.customer_id
JOIN order_items_staging oi ON o.order_id = oi.order_id
GROUP BY c.customer_state
ORDER BY revenue DESC;

SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(CAST(oi.price AS DECIMAL(12,2))), 2) AS revenue,
    ROUND(
        SUM(CAST(oi.price AS DECIMAL(12,2))) /
        COUNT(DISTINCT o.order_id), 2
    ) AS average_order_value
FROM customers_staging c
JOIN orders_staging o ON c.customer_id = o.customer_id
JOIN order_items_staging oi ON o.order_id = oi.order_id
GROUP BY c.customer_state
ORDER BY average_order_value DESC;

-- =========================================================
-- 9. PAYMENT ANALYSIS
-- =========================================================

SELECT
    payment_type,
    COUNT(*) AS payment_transactions,
    ROUND(SUM(CAST(payment_value AS DECIMAL(12,2))), 2)
        AS payment_value
FROM payments_staging
GROUP BY payment_type
ORDER BY payment_value DESC;

-- =========================================================
-- 10. RFM ANALYSIS
-- =========================================================

/*
Validated RFM population: 95,420 customers.
Overall unique customers: 96,096.

RFM uses customers with matching order-item records.
Analysis date: 2018-10-18.

RFM:
Recency  = days since latest purchase
Frequency = distinct order count
Monetary  = total product/item revenue

Higher R, F and M scores represent stronger customer value.
*/

DROP TABLE IF EXISTS customer_rfm_final;

CREATE TABLE customer_rfm_final AS
WITH rfm_base AS (
    SELECT
        c.customer_unique_id,
        MAX(o.order_purchase_timestamp) AS last_purchase_date,
        COUNT(DISTINCT o.order_id) AS frequency,
        ROUND(
            SUM(CAST(oi.price AS DECIMAL(12,2))), 2
        ) AS monetary
    FROM customers_staging c
    JOIN orders_staging o ON c.customer_id = o.customer_id
    JOIN order_items_staging oi ON o.order_id = oi.order_id
    GROUP BY c.customer_unique_id
),
rfm_scored AS (
    SELECT
        customer_unique_id,
        DATEDIFF(
            '2018-10-18',
            DATE(last_purchase_date)
        ) AS recency,
        frequency,
        monetary,
        NTILE(5) OVER (
            ORDER BY last_purchase_date ASC
        ) AS r_score,
        NTILE(5) OVER (
            ORDER BY frequency ASC
        ) AS f_score,
        NTILE(5) OVER (
            ORDER BY monetary ASC
        ) AS m_score
    FROM rfm_base
)
SELECT
    customer_unique_id,
    recency,
    frequency,
    monetary,
    r_score,
    f_score,
    m_score,
    r_score + f_score + m_score AS rfm_score,
    CASE
        WHEN r_score + f_score + m_score >= 12
            THEN 'Champions'
        WHEN r_score + f_score + m_score >= 9
            THEN 'Loyal Customers'
        WHEN r_score + f_score + m_score >= 6
            THEN 'Potential Customers'
        ELSE 'At Risk / Lost'
    END AS customer_segment
FROM rfm_scored;

-- =========================================================
-- 11. RFM SUMMARY
-- =========================================================

DROP TABLE IF EXISTS rfm_segment_summary;

CREATE TABLE rfm_segment_summary AS
SELECT
    customer_segment,
    COUNT(*) AS customer_count,
    ROUND(AVG(recency), 1) AS avg_recency,
    ROUND(AVG(frequency), 2) AS avg_frequency,
    ROUND(AVG(monetary), 2) AS avg_monetary,
    ROUND(SUM(monetary), 2) AS total_revenue
FROM customer_rfm_final
GROUP BY customer_segment;

SELECT
    customer_segment,
    customer_count,
    avg_recency,
    avg_frequency,
    avg_monetary,
    total_revenue,
    ROUND(
        total_revenue /
        (SELECT SUM(total_revenue)
         FROM rfm_segment_summary) * 100,
        2
    ) AS revenue_share_pct
FROM rfm_segment_summary
ORDER BY total_revenue DESC;

-- =========================================================
-- 12. FINAL VALIDATION
-- =========================================================

SELECT
    COUNT(*) AS total_rfm_customers,
    ROUND(SUM(monetary), 2) AS total_rfm_revenue
FROM customer_rfm_final;

SELECT
    customer_segment,
    customer_count,
    total_revenue
FROM rfm_segment_summary
ORDER BY total_revenue DESC;

/*
EXPECTED VALIDATED RESULTS

Total unique customers:       96,096
RFM customers:                 95,420
Total orders:                  99,441
Items sold:                   112,650
Product revenue:        13,591,643.70
One-time customers:           93,099
Repeat customers:              2,997
Repeat customer rate:           3.12%

RFM:
Loyal Customers:              43,604
Potential Customers:           34,346
At Risk / Lost:                 5,439
Champions:                     12,031

RFM revenue:
Loyal Customers:        7,236,822.24
Potential Customers:    2,562,660.52
At Risk / Lost:            183,009.74
Champions:               3,609,151.20
Total RFM revenue:      13,591,643.70
*/

-- =========================================================
-- END OF SCRIPT
-- =========================================================
