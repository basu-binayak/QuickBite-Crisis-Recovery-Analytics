
## 📊 Fact Table Grain Definitions — QuickBite Analytics

---

### 1️⃣ **fact_orders**

**Grain:**
➡️ **One row per customer order**

**Definition:**
Each record represents a  **single order placed by a customer** , regardless of the number of items in that order.

**Key Identifiers:**

* `order_id` (primary grain key)

**What this table answers:**

* How many orders were placed?
* What was the total order value?
* Was the order cancelled?
* COD vs prepaid trends
* Order-level revenue and churn behavior

**Why this grain matters:**
It is the **central transactional fact** and the anchor for joining most other fact tables.

### 2️⃣ **fact_order_items**

**Grain:**
➡️ **One row per item per order**

**Definition:**
Each record represents  **one menu item within an order** .
An order with multiple items will have multiple rows.

**Key Identifiers:**

* `order_id`
* `menu_item_id`

**What this table answers:**

* Item-level revenue
* Popular dishes and categories
* Quantity sold per item
* Item-level discount impact

**Why this grain matters:**
It enables **detailed product and cuisine analysis** that cannot be done at order level.

### 3️⃣ **fact_delivery_performance**

**Grain:**
➡️ **One row per order delivery**

**Definition:**
Each record captures the  **delivery performance metrics for a single order** , including actual vs expected delivery time.

**Key Identifiers:**

* `order_id`

**What this table answers:**

* SLA adherence
* Delivery delays
* Impact of distance on delivery time
* Operational performance during crisis vs recovery

**Why this grain matters:**
Delivery performance is evaluated  **per order** , not per item or customer.

### 4️⃣ **fact_ratings**

**Grain:**
➡️ **One row per order review**

**Definition:**
Each record represents a  **customer’s rating and review for a completed order** .

**Key Identifiers:**

* `order_id`
* `customer_id`

**What this table answers:**

* Customer satisfaction trends
* Rating drops during crisis periods
* Sentiment vs delivery performance
* Trust recovery signals

**Why this grain matters:**
Ratings are  **transaction-linked feedback** , making order the correct atomic level.

---

## 🧠 Grain Consistency Summary

| Fact Table                    | Grain                      |
| ----------------------------- | -------------------------- |
| `fact_orders`               | One row per order          |
| `fact_order_items`          | One row per item per order |
| `fact_delivery_performance` | One row per order          |
| `fact_ratings`              | One row per order review   |

---

## 🎯 Modeling Note

> “All QuickBite fact tables are designed at the  **lowest meaningful transactional grain** , ensuring accurate aggregations, flexible joins, and no double counting when modeling KPIs in the Gold layer.”

---
