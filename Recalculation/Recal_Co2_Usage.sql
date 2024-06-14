DECLARE @StartTime DATETIME = '2024-06-13 00:00:00.000';--keyin user
DECLARE @FinishTime DATETIME = '2024-06-14 00:00:00.000'; 

-- DECLARE @FinishTime DATETIME = CAST(GETDATE() AS DATE); 
-- DECLARE @StartTime DATETIME = DATEADD(DAY, -1, @FinishTime);

WITH SubqueryUpdate AS (
    SELECT
        [Date],
        [Unit],
        [Meter_CO2],
        [Fill_Up_CO2],
        [CO2_usage],
        [Pressure],
        ROW_NUMBER() OVER (ORDER BY [Date]) AS RowNum
    FROM (
        SELECT
            [Date],
            [Unit],
            [Meter_CO2],
            [Fill_Up_CO2],
            [Pressure],
            
           	  case when [Meter_CO2] - LEAD([Meter_CO2]) over (order by [Date]) + [Fill_Up_CO2]  is null then 0 else [Meter_CO2] - LEAD([Meter_CO2]) over (order by [Date]) + [Fill_Up_CO2]  END as [CO2_usage]


        FROM [ISMPALI].[dbo].[ut_sus_rw_data_co2_usage]
        WHERE [Date] BETWEEN @StartTime AND @FinishTime
    ) AS Subquery
)
UPDATE [ISMPALI].[dbo].[ut_sus_rpt_co2_usage]
SET 
    [CO2_Remaining] = SubqueryUpdate.[Meter_CO2],
    [Fill_Up_CO2] = SubqueryUpdate.[Fill_Up_CO2],
    [CO2_usage] = SubqueryUpdate.[CO2_usage],
    [Pressure] = SubqueryUpdate.[Pressure]
FROM SubqueryUpdate
WHERE 
    [ut_sus_rpt_co2_usage].[Date] = @StartTime--keyin user
    AND [ut_sus_rpt_co2_usage].[Approve] = 0
    AND SubqueryUpdate.RowNum = 1;
