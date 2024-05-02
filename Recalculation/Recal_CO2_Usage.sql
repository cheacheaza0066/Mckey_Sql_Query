DECLARE @StartTime DATETIME = '2024-03-12 00:00:00.000';
DECLARE @FinishTime DATETIME = '2024-05-12 00:00:00.000';

UPDATE [Test].[dbo].[Report_CO2_Usage]
SET 
         [CO2_Remaining] = SubqueryUpdate.[Meter_CO2]
        ,[Fill_Up_CO2] = SubqueryUpdate.[Fill_Up_CO2]
        ,[CO2_usage] = SubqueryUpdate.[CO2_usage]
        ,[Pressure] = SubqueryUpdate.[Pressure]
FROM (
    SELECT
      [Date]
      ,[Meter_CO2]
      ,[Fill_Up_CO2]
	  ,[CO2_usage]
      ,[Pressure]
FROM (
    SELECT
	[Date]
       ,[Meter_CO2]
      ,[Fill_Up_CO2]
      ,[Pressure],
        CASE WHEN [Meter_CO2] - LEAD([Meter_CO2]) OVER (ORDER BY [Date]) + [Fill_Up_CO2] IS NULL THEN 0 ELSE [Meter_CO2] - LEAD([Meter_CO2]) OVER (ORDER BY [Date]) + [Fill_Up_CO2] END AS [CO2_usage]
        FROM [Test].[dbo].[RawData_CO2_Usage]
        WHERE [Date] BETWEEN @StartTime AND @FinishTime
    ) AS Subquery
) AS SubqueryUpdate
WHERE
    [Test].[dbo].[Report_CO2_Usage].[Date] = SubqueryUpdate.[Date]
    AND [Test].[dbo].[Report_CO2_Usage].Approve = 0;
