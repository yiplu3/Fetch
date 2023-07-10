-- 1. What are the top 5 brands by receipts scanned for most recent month?
-- recent months: 6 months?? no last month
-- 2. How does the ranking of the top 5 brands by receipts scanned for the recent month compare to the ranking for the previous month?
WITH recent_month AS (
  SELECT 
	brand_id, 
	COUNT(*) AS receipts_scanned
  FROM receipts
  WHERE dateScanned >= DATE_TRUNC('month', current_date)
  GROUP BY brand_id
  ORDER BY receipts_scanned DESC
  LIMIT 5
), previous_month AS (
  SELECT 
	brand_id, 
	COUNT(*) AS receipts_scanned
  FROM receipts
  WHERE dateScanned >= DATE_TRUNC('month', current_date - INTERVAL '1 month')
    AND dateScanned < DATE_TRUNC('month', current_date)
  GROUP BY brand_id
  ORDER BY receipts_scanned DESC
  --LIMIT 5
)

SELECT recent_month.brand_id, recent_month.receipts_scanned AS recent_month_scanned,
       previous_month.receipts_scanned AS previous_month_scanned,
       RANK() OVER (ORDER BY recent_month.receipts_scanned DESC) AS recent_month_rank,
       RANK() OVER (ORDER BY previous_month.receipts_scanned DESC) AS previous_month_rank
FROM recent_month
LEFT JOIN previous_month
ON recent_month.brand_id = previous_month.brand_id;
-- for q1 and q2, use WITH clause set up two tmp, 
-- since
-- rank over() for ranking

-- 3. When considering average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
-- 4. When considering total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
SELECT 
	r.rewardsReceiptStatus,
	AVG(r.totalSpent) AS average_spend,
	SUM(r.purchasedItemCount) AS total_items
FROM Receipts r
WHERE r.rewardsReceiptStatus IN ('Accepted','Rejected') 
GROUP BY r.rewardsReceiptStatus
--combine q3,q4, The result will include two rows, 
--one for 'Accepted' and one for 'Rejected', 
--along with the corresponding average spend and total items purchased.

-- 5. Which brand has the most spend among users who were created within the past 6 months?
-- 6. Which brand has the most transactions among users who were created within the past 6 months?
SELECT 
	b.name AS brand_name, 
	SUM(r.totalSpend) AS total_spend,
	COUNT(*) AS total_transactions
FROM Brand b
JOIN rewardsReceiptStatus reward 
	ON b.barcode = reward.barcode
JOIN Receipts r
	ON r.Receipts_id = reward.Receipts_id
JOIN Users u
	ON r.userId = u.User_Id
WHERE u.createdDate >= current date - interval '6 months'
GROUP BY b.name
ORDER BY total_spend DESC, total_transactions DESC
LIMIT 1;
-- also can use WITH clause: 
-- WITH recent_users AS (
--     SELECT _id
--     FROM users
--     WHERE createdDate >= CURRENT_DATE - INTERVAL '6 months'
-- )






