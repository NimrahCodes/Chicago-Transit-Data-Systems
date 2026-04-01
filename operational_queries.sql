/* DATA SYSTEMS CASE STUDY: 24M+ ROW PROCESSING
   Focus: Identifying service gaps and optimising query performance.
*/
-- 1. DATA INTEGRITY: Identifying missing sensor assets
SELECT asset_id, count(*) as ping_count
FROM cta_telemetry_logs
WHERE status IS NULL
GROUP BY asset_id
HAVING count(*) > 100
ORDER BY ping_count DESC;

-- 2. PERFORMANCE: Using Indexing logic for Time-Series Analysis
-- This query identifies peak-load anomalies across 24M records
SELECT 
    date_trunc('hour', timestamp) AS event_hour,
    avg(load_factor) OVER (PARTITION BY route_id ORDER BY timestamp) as moving_avg
FROM cta_telemetry_logs
WHERE timestamp > '2025-01-01'
LIMIT 1000;

-- 3. AGGREGATION: Segmenting 24M rows into actionable insights
-- Essential for backend reporting at scale
SELECT route_id, sum(passenger_count) as total_volume
FROM cta_telemetry_logs
WHERE passenger_count > 0
GROUP BY route_id;
