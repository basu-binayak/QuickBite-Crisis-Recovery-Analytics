# 🍔 `<a href="https://codebasics.io/challenges/codebasics-resume-project-challenge/23">`QuickBite Crisis Recovery Analytics `</a>`

## 📌 Project Overview

**QuickBite Express is a Bengaluru-based food delivery startup that faced a major crisis in June 2025 due to food safety violations at partner restaurants and a week-long delivery outage during the monsoon season.** This incident triggered customer backlash, order decline, trust erosion, rising acquisition costs, and loss of restaurant partners.

This repository presents an **end-to-end analytics case study** designed to support **crisis recovery and turnaround strategy**. Using **Microsoft Fabric** and a **Medallion Architecture (Bronze–Silver–Gold)** approach, the project delivers actionable insights across customer behavior, delivery operations, restaurant partnerships, campaigns, and sentiment.

---

## ✅ Understanding of the Problem Statement

QuickBite Express, an online food delivery startup, faced a **compound crisis** in June 2025 due to:

1. **Trust erosion**

   - Viral food safety incidents at partner restaurants
   - Drop in customer ratings and reviews

2. **Operational failure**

   - Week-long delivery outage during monsoons
   - Increased cancellations and SLA breaches

3. **Competitive pressure**

   - Customers and restaurants moving to competitors
   - Increased customer acquisition costs

The leadership is **not asking for raw metrics** — they want **decision-driven insights** to guide a **recovery strategy**.

The core business questions revolve around:

- **Who to win back**
- **What changed in customer behavior**
- **Where operations failed**
- **How to rebuild trust**
- **Which partners are worth retaining**
- **How sentiment is evolving post-crisis**

---

## 🎯 Business Objectives

The analysis addresses the following management questions:

1. **Customer Segmentation** – Identify recoverable customers vs those requiring new acquisition strategies.
2. **Order Patterns** – Analyze order trends across pre-crisis, crisis, and recovery phases.
3. **Delivery Performance** – Evaluate delivery times, cancellations, and SLA compliance.
4. **Campaign Opportunities** – Recommend targeted initiatives to rebuild trust and loyalty.
5. **Restaurant Partnerships** – Identify high-value restaurant partners for long-term retention.
6. **Feedback & Sentiment** – Monitor ratings, reviews, and sentiment to guide recovery actions.

---

## 🏗️ Architecture & Tech Stack

### Platform

- **Microsoft Fabric**

  - Lakehouse
  - Dataflow Gen2
  - Fabric Warehouse
  - Pipelines

### Architecture Pattern

- **Medallion Architecture**

  - **Bronze Layer** – Raw data ingestion
  - **Silver Layer** – Cleaned and standardized data
  - **Gold Layer** – Business-ready analytical tables

---

## 🥉 Bronze Layer – Raw Data (Lakehouse)

**Purpose**:

- Store raw, immutable data exactly as received
- Act as the single source of truth

**Implementation**:

- Data ingested into Fabric Lakehouse
- Stored as files and converted into Delta tables
- No transformations or business logic applied

---

## 🥈 Silver Layer – Cleaned Data (Lakehouse)

**Tool Used**:

- Dataflow Gen2

**Key Transformations**:

- Schema standardization and data type correction
- Null and duplicate handling
- Timestamp normalization
- Derived attributes such as:

  - Order phase (Pre-Crisis / Crisis / Recovery)
  - SLA compliance flags
  - Active/inactive status indicators

**Outcome**:

- Analytics-ready Delta tables stored in the Lakehouse

---

## 🥇 Gold Layer – Business Metrics (Warehouse)

**Tool Used**:

- T-SQL in Fabric Warehouse

**Purpose**:

- Create aggregated, insight-focused tables
- Support dashboards and stakeholder reporting

**Examples**:

- Customer recovery segments
- Order trend summaries
- Delivery SLA metrics
- Restaurant value scores
- Sentiment and rating trends

---

## 🔄 Pipeline Orchestration

Microsoft Fabric Pipelines are used to automate the end-to-end data flow:

1. **Bronze → Silver**

   - Trigger Dataflow Gen2 for cleaning and transformation

2. **Silver → Gold**

   - Execute T-SQL scripts to build analytical tables

3. **Validation & Monitoring**

   - Row count checks
   - Data freshness validation
   - Failure monitoring

This ensures reliable, repeatable, and scalable data processing.

---

## 🗂️ Data Model & Metadata

### Fact Tables

#### fact_orders

Tracks customer orders including financials, timestamps, and cancellation status.

- order_id
- customer_id
- restaurant_id
- delivery_partner_id
- order_timestamp
- subtotal_amount
- discount_amount
- delivery_fee
- total_amount
- is_cod
- is_cancelled

#### fact_order_items

Tracks individual items within each order.

- order_id
- menu_item_id
- restaurant_id
- quantity
- unit_price
- item_discount
- line_total

#### fact_ratings

Stores ratings and reviews provided by customers.

- order_id
- customer_id
- restaurant_id
- rating
- review_text
- review_timestamp
- sentiment_score

#### fact_delivery_performance

Tracks delivery efficiency and SLA performance.

- order_id
- actual_delivery_time_mins
- expected_delivery_time_mins
- distance_km

---

### Dimension Tables

#### dim_customer

Customer onboarding and acquisition details.

- customer_id
- signup_date
- city
- acquisition_channel

#### dim_restaurant

Restaurant profile and partnership details.

- restaurant_id
- restaurant_name
- city
- cuisine_type
- partner_type
- avg_prep_time
- is_active

#### dim_delivery_partner

Delivery partner information.

- delivery_partner_id
- partner_name
- city
- vehicle_type
- employment
- avg_rating
- is_active

#### dim_menu_item

Menu item details offered by restaurants.

- menu_item_id
- restaurant_id
- item_name
- category
- is_veg
- price

---

## 📊 Analytical Approach

- Customer segmentation and churn analysis
- Order trend comparison across crisis phases
- Delivery delay, cancellation, and SLA analysis
- Campaign targeting opportunity identification
- Restaurant partner value and retention analysis
- Ratings and sentiment trend monitoring

---

## 📈 Expected Outcomes

- Identify customer segments with high recovery potential
- Detect operational bottlenecks impacting delivery performance
- Prioritize high-value restaurant partnerships
- Track trust recovery using ratings and sentiment
- Enable leadership to make data-backed turnaround decisions

---

## 📁 Repository Folder Structure

```text
QuickBite-Crisis-Recovery-Analytics/
│
├── bronze/
│   ├── raw_data/
│   │   ├── orders/
│   │   ├── order_items/
│   │   ├── ratings/
│   │   ├── delivery_performance/
│   │   └── reference_dimensions/
│   └── README.md
│
├── silver/
│   └── README.md
│
├── gold/
│   ├── sql/
│   │   ├── customer_segmentation.sql
│   │   ├── order_trends.sql
│   │   ├── delivery_sla_metrics.sql
│   │   ├── restaurant_value_scoring.sql
│   │   └── sentiment_analysis.sql
│   └── README.md
│
├── pipelines/
│   ├── bronze_to_silver.pipeline.json
│   ├── silver_to_gold.pipeline.json
│   └── end_to_end.pipeline.json
│
├── dashboards/
│   ├── powerbi/
│   │   └── quickbite_recovery_dashboard.pbix
│   └── screenshots/
│
├── docs/
│   ├── data_model.png
│   ├── architecture_diagram.png
│   └── business_kpi_definitions.md
│
├── README.md
└── .gitignore
```

### Folder Structure Explanation

- **bronze/**
  Contains raw ingested datasets stored in the Fabric Lakehouse with no transformations applied.
- **silver/**
  Holds Dataflow Gen2 definitions used for cleaning, standardizing, and enriching data.
- **gold/**
  Contains T-SQL scripts that generate business-ready analytical tables in the Fabric Warehouse.
- **pipelines/**
  Fabric Pipeline definitions orchestrating Bronze → Silver → Gold data movement.
- **dashboards/**
  Power BI dashboards and supporting visuals built on Gold layer tables.
- **docs/**
  Architecture diagrams, data models, and KPI documentation.

---

## 🚀 Repository Usage Instructions

1. **Understand the Architecture**

   - Review the Medallion Architecture sections to understand data flow.

2. **Bronze Layer**

   - Raw datasets are stored in the Lakehouse without modification.

3. **Silver Layer**

   - Open Dataflow Gen2 to review cleaning and transformation logic.

4. **Gold Layer**

   - Execute T-SQL scripts in the Warehouse to generate analytical tables.

5. **Pipelines**

   - Run Fabric Pipelines to orchestrate Bronze → Silver → Gold processing.

6. **Analysis & BI**

   - Use Gold tables for dashboards, reporting, or further analysis.

---

## ⬇️ How to Download and Use This Repository

### Option 1: Clone the Repository

```bash
git clone https://github.com/basu-binayak/QuickBite-Crisis-Recovery-Analytics.git
```

### Option 2: Download as ZIP

1. Click the **Code** button on this repository
2. Select **Download ZIP**
3. Extract the files to your local system

### Getting Started

1. Review the **README.md** for architecture and workflow details
2. Upload raw datasets to the **Bronze Lakehouse**
3. Run **Dataflow Gen2** for Silver layer transformations
4. Execute **T-SQL scripts** in the Warehouse to create Gold tables
5. Use Gold tables for dashboards, reporting, or further analysis

---

## 📜 License

This project is licensed under the **MIT License**.

You are free to:

- Use, copy, and modify the code
- Distribute and reuse the project for personal or commercial purposes

Attribution is appreciated but not required.
See the `LICENSE` file in this repository for full details.

---
