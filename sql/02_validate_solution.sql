-- Final validation of the analytical SQL layer.
SELECT
    COUNT_BIG(*) AS Analytical_View_Row_Count,
    COUNT_BIG(DISTINCT DateID) AS Active_Date_Count,
    CAST(SUM(RecordedTotalAmount) AS decimal(18, 2)) AS Recorded_Revenue,
    CAST(SUM(CalculatedTotalAmount) AS decimal(18, 2)) AS Calculated_Revenue,
    CAST(SUM(ReconciliationDifference) AS decimal(18, 2)) AS Reconciliation_Difference,
    SUM(CASE WHEN IsFinanciallyReconciled = 1 THEN 1 ELSE 0 END) AS Reconciled_Trips,
    SUM(CASE WHEN IsFinanciallyReconciled = 0 THEN 1 ELSE 0 END) AS Exception_Trips
FROM dbo.vw_TripAnalytics;

SELECT
    CASE
        WHEN COUNT_BIG(*) = 10000
         AND CAST(SUM(RecordedTotalAmount) AS decimal(18, 2)) = 285930.00
         AND CAST(SUM(CalculatedTotalAmount) AS decimal(18, 2)) = 286080.00
         AND CAST(SUM(ReconciliationDifference) AS decimal(18, 2)) = -150.00
         AND SUM(CASE WHEN IsFinanciallyReconciled = 1 THEN 1 ELSE 0 END) = 5930
         AND SUM(CASE WHEN IsFinanciallyReconciled = 0 THEN 1 ELSE 0 END) = 4070
        THEN 'PASS'
        ELSE 'FAIL'
    END AS Final_SQL_Validation_Status
FROM dbo.vw_TripAnalytics;
