INSERT INTO [Test].[dbo].[Report_CO2_Usage]
    (
    [Date],
    [Unit]
    ,[CO2_Remaining]
    ,[Fill_Up_CO2]
    ,[CO2_usage]
    ,[Pressure]
    )
SELECT
       [Date]
      ,[Unit]
      ,[Meter_CO2]
      ,[Fill_Up_CO2]
	  ,[CO2_usage]
      ,[Pressure]
FROM (
    SELECT
       [Date]
      ,[Unit]
      ,[Meter_CO2]
      ,[Fill_Up_CO2]
      ,[Pressure],
        CASE WHEN [Meter_CO2] - LEAD([Meter_CO2]) OVER (ORDER BY [Date]) + [Fill_Up_CO2] IS NULL THEN 0 ELSE [Meter_CO2] - LEAD([Meter_CO2]) OVER (ORDER BY [Date]) + [Fill_Up_CO2] END AS [CO2_usage]
        FROM [Test].[dbo].[RawData_CO2_Usage]
) AS Subquery
WHERE NOT EXISTS (
    SELECT 1
FROM [Test].[dbo].[Report_CO2_Usage]
WHERE [Test].[dbo].[Report_CO2_Usage].[Date] = Subquery.[Date]
);
