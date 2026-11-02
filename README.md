# Data Analysis Portfolio — Glory Ogbuta

Welcome to my Data Analytics Portfolio! This repository contains end-to-end data analysis, SQL database querying projects focused on solving real-world business problems across E-Commerce, Supply Chain Logistics, and Public/Social Research.

## Core Technical Skills
- **Programming & Analytics:** Python (Pandas, NumPy, Scikit-Learn, SciPy)
- **Databases & Querying:** SQL (SQLite, PostgreSQL — CTEs, Window Functions, Joins)
- **Data Visualization & BI:** Matplotlib, Seaborn, Tableau, Power BI, Microsoft Excel
- **Analytical Methods:** RFM Customer Segmentation, K-Means Clustering, Supply Chain SLA Optimization, Exploratory Data Analysis (EDA)

---

##  Featured Projects

### 1. [E-Commerce Customer Segmentation & RFM Analysis](./E-COMMERCE_rfm.IPYNB)
- **Objective:** Segment an e-commerce customer base into actionable behavioral personas to optimize marketing retention spend and reduce churn.
- **Tech Stack:** Python (`pandas`, `scikit-learn`, `matplotlib`, `seaborn`)
- **Key Techniques:** Recency-Frequency-Monetary (RFM) engineering, Log Transformation, StandardScaler, Elbow Method, K-Means Clustering ($k=4$).
- **Business Impact:** Identified 4 distinct buyer cohorts (*Champions*, *At-Risk High-Value*, *Recent Buyers*, *Hibernating*) and formulated targeted win-back strategies to protect high-tier annual revenue.

---

### 2. [Supply Chain & Delivery Bottleneck Analysis (SQL + Python)](./Supply_Chain.ipynb)
- **Companion SQL Script:** [`queries.sql`](./queries.sql) | **Database:** [`supply_chain.db`](./supply_chain.db)
- **Objective:** Investigate fulfillment and transit delays across 4 regional warehouses and 5 third-party logistics (3PL) carriers (5,000+ shipments) to find out why On-Time Delivery (OTD) rates were falling short of the 80% SLA target.
- **Tech Stack:** SQL (CTEs, `DENSE_RANK`, `LAG`, Window Frames) + Python (`sqlite3`, `pandas`, `seaborn`)
- **Business Impact:** 
  1. Uncovered that *Apex Freight* delivered on time only **21% of the time**, recommending volume reallocation to top carriers (*Coastal Transit*, *SwiftHaul*, *PrimeLine*) to lift network OTD by **+14%**.
  2. Proved that top carriers were plateauing at **78% OTD** due to an internal **3-day packing delay** at the *Southern Port Facility* (64.8% SLA breach rate).

---

### 3. [Early Childhood Development Analysis](./Early_Childhood_development.ipynb)
- **Objective:** Exploratory data analysis and statistical investigation into key factors influencing early childhood development outcomes.
- **Tech Stack:** Python (`pandas`, `matplotlib`, `seaborn`)

---

## 📫 Let's Connect!
- **GitHub:** [github.com/Gogbuta](https://github.com/Gogbuta)
