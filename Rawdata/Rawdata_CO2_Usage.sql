SELECT
       [Date]
      ,[Unit]
      ,[Meter_CO2]
      ,[Fill_Up_CO2]
      ,[Pressure]
      ,[Line5]
      ,[Line6]
      ,[Description]
FROM (
    SELECT
       [Date]
      ,[Unit]
      ,[Meter_CO2]
      ,[Fill_Up_CO2]
      ,[Pressure]
      ,[Line5]
      ,[Line6]
      ,[Description]
        CASE WHEN [Meter_CO2] - LEAD([Meter_CO2]) OVER (ORDER BY [Date]) + [Fill_Up_CO2] IS NULL THEN 0 ELSE [Meter_CO2] - LEAD([Meter_CO2]) OVER (ORDER BY [Date]) + [Fill_Up_CO2] END AS [CO2_usage]
       
    FROM [Test].[dbo].[RawData_CO2_Usage]l
   -- where [Rawdata_Running_Hr_Plant3].[Date] between :Start and :Finish
) AS Subquery
