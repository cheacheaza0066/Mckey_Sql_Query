DECLARE @StartTime DATETIME = '2024-06-12 00:00:00.000';
DECLARE @FinishTime DATETIME = '2024-06-13 00:00:00.000';--keyin

WITH SubqueryUpdate AS (
    SELECT
        [Date]
     ,[Solar_Plant3]
      ,[Solar_Plant4]
      ,[Solar_Car_Park],
        ROW_NUMBER() OVER (ORDER BY [Date]) AS RowNum
    FROM (
        SELECT
            [ID],
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
)
UPDATE [ISMPALI].[dbo].[ut_sus_rpt_solar_cell]
SET 
    [Solar_Plant3]= SubqueryUpdate.[Solar_Plant3]
      ,[Solar_Plant4]= SubqueryUpdate.[Solar_Plant4]
      ,[Solar_Car_Park]= SubqueryUpdate.[Solar_Car_Park]
FROM SubqueryUpdate
WHERE
    [ut_sus_rpt_solar_cell].[Date] = @FinishTime
    AND [ut_sus_rpt_solar_cell].Approve = 0
    AND SubqueryUpdate.RowNum = 2; 