DECLARE @StartTime DATETIME = '2024-06-12 00:00:00.000';
DECLARE @FinishTime DATETIME = '2024-06-13 00:00:00.000';

WITH SubqueryUpdate AS (
    SELECT
        [Date],
        [Unit],
        [Meter_CO2],
        [Fill_Up_CO2],
        [Pressure],
        CASE WHEN [Meter_CO2] - LEAD([Meter_CO2]) OVER (ORDER BY [Date]) + [Fill_Up_CO2] IS NULL THEN 0 ELSE [Meter_CO2] - LEAD([Meter_CO2]) OVER (ORDER BY [Date]) + [Fill_Up_CO2] END AS [CO2_usage],
        ROW_NUMBER() OVER (ORDER BY [Date]) AS RowNum
    FROM [ISMPALI].[dbo].[ut_sus_rw_data_co2_usage]
    WHERE [Date] BETWEEN @StartTime AND @FinishTime
)
UPDATE [ISMPALI].[dbo].[ut_sus_rpt_co2_usage]
SET 
    [CO2_Remaining] = SubqueryUpdate.[Meter_CO2],
    [Fill_Up_CO2] = SubqueryUpdate.[Fill_Up_CO2],
    [CO2_usage] = SubqueryUpdate.[CO2_usage],
    [Pressure] = SubqueryUpdate.[Pressure]
FROM SubqueryUpdate
WHERE 
    [ut_sus_rpt_co2_usage].[Date] = @FinishTime
    AND [ut_sus_rpt_co2_usage].[Approve] = 0
    AND SubqueryUpdate.RowNum = 2; 
