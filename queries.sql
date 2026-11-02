-- ============================================================================
-- SUPPLY CHAIN & DELIVERY PERFORMANCE SQL QUERIES
-- Dialect: SQLite / PostgreSQL Compatible
-- ============================================================================

-- 1. VENDOR SCORECARD & ON-TIME IN-FULL (OTIF) RANKING
-- Uses Common Table Expressions (CTEs) and DENSE_RANK() Window Function
WITH VendorMetrics AS (
    SELECT 
        v.vendor_id,
        v.vendor_name,
        v.transport_mode,
        COUNT(s.shipment_id) AS total_shipments,
        ROUND(AVG(JULIANDAY(s.actual_delivery_date) - JULIANDAY(s.order_date)), 2) AS avg_lead_time_days,
        ROUND(AVG(JULIANDAY(s.actual_delivery_date) - JULIANDAY(s.promised_delivery_date)), 2) AS avg_delay_days,
        SUM(CASE WHEN s.actual_delivery_date <= s.promised_delivery_date THEN 1 ELSE 0 END) AS on_time_deliveries,
        ROUND(AVG(s.shipping_cost), 2) AS avg_shipping_cost
    FROM shipments s
    JOIN vendors v ON s.vendor_id = v.vendor_id
    GROUP BY v.vendor_id, v.vendor_name, v.transport_mode
)
SELECT 
    vendor_name,
    transport_mode,
    total_shipments,
    avg_lead_time_days,
    avg_delay_days,
    ROUND((CAST(on_time_deliveries AS FLOAT) / total_shipments) * 100, 2) AS on_time_rate_pct,
    avg_shipping_cost,
    DENSE_RANK() OVER (ORDER BY (CAST(on_time_deliveries AS FLOAT) / total_shipments) DESC) AS reliability_rank
FROM VendorMetrics
ORDER BY reliability_rank ASC;


-- 2. REGIONAL WAREHOUSE BOTTLENECK ANALYSIS
-- Isolates whether delays occur during warehouse fulfillment or carrier transit
SELECT 
    w.region,
    w.warehouse_name,
    COUNT(s.shipment_id) AS shipment_volume,
    ROUND(AVG(JULIANDAY(s.dispatch_date) - JULIANDAY(s.order_date)), 2) AS avg_warehouse_processing_days,
    ROUND(AVG(JULIANDAY(s.actual_delivery_date) - JULIANDAY(s.dispatch_date)), 2) AS avg_carrier_transit_days,
    SUM(CASE WHEN (JULIANDAY(s.dispatch_date) - JULIANDAY(s.order_date)) > 2 THEN 1 ELSE 0 END) AS SLA_breach_count,
    ROUND(SUM(CASE WHEN (JULIANDAY(s.dispatch_date) - JULIANDAY(s.order_date)) > 2 THEN 1.0 ELSE 0.0 END) / COUNT(s.shipment_id) * 100, 2) AS warehouse_sla_breach_pct
FROM shipments s
JOIN warehouses w ON s.warehouse_id = w.warehouse_id
GROUP BY w.region, w.warehouse_name
ORDER BY warehouse_sla_breach_pct DESC;


-- 3. MONTH-OVER-MONTH (MoM) LATE DELIVERY TREND & ROLLING COST
-- Uses LAG() and Window Frame clauses for time-series operational tracking
WITH MonthlyPerformance AS (
    SELECT 
        STRFTIME('%Y-%m', order_date) AS order_month,
        COUNT(shipment_id) AS total_orders,
        SUM(CASE WHEN actual_delivery_date > promised_delivery_date THEN 1 ELSE 0 END) AS late_orders,
        ROUND(SUM(shipping_cost), 2) AS monthly_freight_spend
    FROM shipments
    GROUP BY STRFTIME('%Y-%m', order_date)
)
SELECT 
    order_month,
    total_orders,
    late_orders,
    ROUND((CAST(late_orders AS FLOAT) / total_orders) * 100, 2) AS late_delivery_pct,
    LAG(ROUND((CAST(late_orders AS FLOAT) / total_orders) * 100, 2), 1) OVER (ORDER BY order_month) AS prev_month_late_pct,
    monthly_freight_spend,
    ROUND(SUM(monthly_freight_spend) OVER (ORDER BY order_month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS rolling_3m_freight_spend
FROM MonthlyPerformance
ORDER BY order_month;
