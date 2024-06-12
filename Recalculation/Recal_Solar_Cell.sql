DECLARE @StartTime DATETIME = '2024-04-16 00:00:00.000';
DECLARE @FinishTime DATETIME = '2024-04-18 00:00:00.000';

UPDATE [ISMPALI].[dbo].[ut_sus_rpt_solar_cell]
SET 
    [Solar_Plant3]= SubqueryUpdate.[Solar_Plant3]
      ,[Solar_Plant4]= SubqueryUpdate.[Solar_Plant4]
      ,[Solar_Car_Park]= SubqueryUpdate.[Solar_Car_Park]

    
FROM (
    SELECT
        [Date]
     ,[Solar_Plant3]
      ,[Solar_Plant4]
      ,[Solar_Car_Park]
    FROM (
        SELECT
        [Date],
        [Unit]
        ,[Solar_Plant3_kW_Hr]
      ,[Solar_Plant4_kW_Hr]
      ,[Solar_Car_Park_kW_Hr],

        CASE WHEN LAG([Solar_Plant3_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Solar_Plant3_kW_Hr] - LAG([Solar_Plant3_kW_Hr]) OVER (ORDER BY [Date]) END AS [Solar_Plant3],
        CASE WHEN LAG([Solar_Plant4_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Solar_Plant4_kW_Hr] - LAG([Solar_Plant4_kW_Hr]) OVER (ORDER BY [Date]) END AS [Solar_Plant4],
        CASE WHEN LAG([Solar_Car_Park_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Solar_Car_Park_kW_Hr] - LAG([Solar_Car_Park_kW_Hr]) OVER (ORDER BY [Date]) END AS [Solar_Car_Park]

         
         FROM [ISMPALI].[dbo].[ut_sus_rw_data_solar_cell]
        WHERE [Date] BETWEEN @StartTime AND @FinishTime
    ) AS Subquery
) AS SubqueryUpdate
WHERE
    [ut_sus_rpt_solar_cell].[Date] = SubqueryUpdate.[Date]

    AND [ut_sus_rpt_solar_cell].Approve = 0;
