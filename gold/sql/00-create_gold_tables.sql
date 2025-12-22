
CREATE OR ALTER PROCEDURE gold.create_gold_tables 
AS
BEGIN
    -- dim_customer 
    CREATE TABLE gold.dim_customer AS
    SELECT
        customer_id,
        signup_date,
        city,
        acquisition_channel
    FROM quickbite_lakehouse_shortcut.dbo.[silver.dim_customer];

    -- dim_restaurant 
    CREATE TABLE gold.dim_restaurant AS
    SELECT
        restaurant_id,
        restaurant_name,
        city,
        cuisine_type,
        partner_type,
        avg_prep_time_min,
        is_active
    FROM quickbite_lakehouse_shortcut.dbo.[silver.dim_restaurant];

    -- dim_delivery_partner
    CREATE TABLE gold.dim_delivery_partner AS
    SELECT
        delivery_partner_id,
        partner_name,
        city,
        vehicle_type,
        employment_type,
        avg_rating,
        is_active
    FROM quickbite_lakehouse_shortcut.dbo.[silver.dim_delivery_partner];

    -- dim_menu_item
    CREATE TABLE gold.dim_menu_item AS
    SELECT
        menu_item_id,
        restaurant_id,
        item_name,
        category,
        is_veg,
        price
    FROM quickbite_lakehouse_shortcut.dbo.[silver.dim_menu_item];

    -- dim_date
    CREATE TABLE gold.dim_date AS
    SELECT DISTINCT
        CAST(
            DATEFROMPARTS(
                YEAR(order_timestamp),
                MONTH(order_timestamp),
                DAY(order_timestamp)
            ) AS date
        ) AS order_date,

        YEAR(order_timestamp) AS year,
        MONTH(order_timestamp) AS month_number,

        CAST(DATENAME(MONTH, order_timestamp) AS varchar(15)) AS month_name,
        CAST(LEFT(DATENAME(MONTH, order_timestamp), 3) AS varchar(3)) AS month_name_short,

        DAY(order_timestamp) AS day,

        DATEPART(WEEKDAY, order_timestamp) AS day_of_week,
        CAST(DATENAME(WEEKDAY, order_timestamp) AS varchar(15)) AS day_name,

        DATEPART(WEEK, order_timestamp) AS week_of_year,

        CAST(
            CASE 
                WHEN DATEPART(WEEKDAY, order_timestamp) IN (1,7)
                THEN 'Weekend'
                ELSE 'Weekday'
            END AS varchar(10)
        ) AS weekday_or_weekend,

        CAST(
            CASE
                WHEN MONTH(order_timestamp) BETWEEN 6 AND 9
                THEN 'Monsoon'
                ELSE 'Non-Monsoon'
            END AS varchar(15)
        ) AS monsoon_or_nonmonsoon

    FROM quickbite_lakehouse_shortcut.dbo.[silver.fact_orders];

    -- fact_orders
    CREATE TABLE gold.fact_orders AS
    SELECT
        order_id,
        customer_id,
        restaurant_id,
        delivery_partner_id,
        order_timestamp,
        DATEFROMPARTS(
            DATEPART(YEAR, order_timestamp),
            DATEPART(MONTH, order_timestamp),
            DATEPART(DAY, order_timestamp)
        ) AS order_date,
        TIMEFROMPARTS(
            DATEPART(HOUR, order_timestamp),
            DATEPART(MINUTE, order_timestamp),
            DATEPART(SECOND, order_timestamp),
            0,0
        ) AS order_time,
        subtotal_amount,
        discount_amount,
        delivery_fee,
        total_amount,
        is_cod,
        is_cancelled
    FROM quickbite_lakehouse_shortcut.dbo.[silver.fact_orders];

    --fact_order_items
    CREATE TABLE gold.fact_order_items AS
    SELECT
        order_id,
        item_id,
        menu_item_id,
        restaurant_id,
        quantity,
        unit_price,
        item_discount,
        line_total
    FROM quickbite_lakehouse_shortcut.dbo.[silver.fact_order_items];

    --fact_delivery_performance 
    CREATE TABLE gold.fact_delivery_performance AS
    SELECT
        order_id,
        actual_delivery_time_mins,
        expected_delivery_time_mins,
        distance_km
    FROM quickbite_lakehouse_shortcut.dbo.[silver.fact_delivery_performance]

    --fact_ratings
    CREATE TABLE gold.fact_ratings AS
    SELECT
        order_id,
        customer_id,
        restaurant_id,
        rating,
        review_text,
        review_timestamp,
        sentiment_score
    FROM quickbite_lakehouse_shortcut.dbo.[silver.fact_ratings];
END







