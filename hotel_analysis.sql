-- Hotel Booking Analysis | Personal Portfolio Project
-- Synthetic data created for portfolio practice.

-- 1. Total bookings and revenue
SELECT COUNT(*) AS total_bookings,
       SUM(revenue_eur) AS total_revenue
FROM hotel_bookings;

-- 2. Cancellation rate by market segment
SELECT market_segment,
       COUNT(*) AS bookings,
       ROUND(100.0 * AVG(is_cancelled), 2) AS cancellation_rate_pct
FROM hotel_bookings
GROUP BY market_segment
ORDER BY cancellation_rate_pct DESC;

-- 3. Revenue by country
SELECT country,
       COUNT(*) AS bookings,
       ROUND(SUM(revenue_eur), 2) AS revenue
FROM hotel_bookings
GROUP BY country
ORDER BY revenue DESC;

-- 4. Average daily rate by room type
SELECT room_type,
       ROUND(AVG(adr_eur), 2) AS average_adr
FROM hotel_bookings
GROUP BY room_type
ORDER BY average_adr DESC;

-- 5. Booking behaviour by lead time
SELECT
  CASE
    WHEN lead_time_days <= 7 THEN '0-7 days'
    WHEN lead_time_days <= 30 THEN '8-30 days'
    WHEN lead_time_days <= 90 THEN '31-90 days'
    ELSE '90+ days'
  END AS lead_time_group,
  COUNT(*) AS bookings,
  ROUND(AVG(is_cancelled) * 100, 2) AS cancellation_rate_pct,
  ROUND(SUM(revenue_eur), 2) AS revenue
FROM hotel_bookings
GROUP BY lead_time_group
ORDER BY bookings DESC;