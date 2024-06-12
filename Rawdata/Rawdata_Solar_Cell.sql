SELECT
    [Date]
      ,[Unit]
       ,[Solar_Plant3_kW_Hr]
      ,[Solar_Plant3]
      ,[Solar_Plant4_kW_Hr]
      ,[Solar_Plant4]
      ,[Solar_Car_Park_kW_Hr]
      ,[Solar_Car_Park]
FROM (
    SELECT
        [ID],
        [Date],
        [Unit],
        [Solar_Plant3_kW_Hr]
      ,[Solar_Plant4_kW_Hr]
      ,[Solar_Car_Park_kW_Hr],

        CASE WHEN LAG([Solar_Plant3_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Solar_Plant3_kW_Hr] - LAG([Solar_Plant3_kW_Hr]) OVER (ORDER BY [Date]) END AS [Solar_Plant3],
        CASE WHEN LAG([Solar_Plant4_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Solar_Plant4_kW_Hr] - LAG([Solar_Plant4_kW_Hr]) OVER (ORDER BY [Date]) END AS [Solar_Plant4],
        CASE WHEN LAG([Solar_Car_Park_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Solar_Car_Park_kW_Hr] - LAG([Solar_Car_Park_kW_Hr]) OVER (ORDER BY [Date]) END AS [Solar_Car_Park]

    FROM [ISMPALI].[dbo].[ut_sus_rw_data_solar_cell]
   -- where [[RawData_Electric_Usage_MDB1]].[Date] between :Start and :Finish
) AS Subquery;
