INSERT INTO [ISMPALI].[dbo].[ut_sus_rpt_co2_usage]
    (
     [Date]
      ,[Unit]
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
      ,[Pressure]

	  ,case when [Meter_CO2] - LEAD([Meter_CO2]) over (order by [Date]) + [Fill_Up_CO2]  is null then 0 else [Meter_CO2] - LEAD([Meter_CO2]) over (order by [Date]) + [Fill_Up_CO2]  END as [CO2_usage]


    FROM [ISMPALI].[dbo].[ut_sus_rw_data_co2_usage]
        WHERE [Date] BETWEEN CONVERT(date, GETDATE() - 1 ) AND CONVERT(date, GETDATE() )

) AS Subquery
WHERE NOT EXISTS (
    SELECT 1
FROM [ISMPALI].[dbo].[ut_sus_rpt_co2_usage]
WHERE [ut_sus_rpt_co2_usage].[Date] = Subquery.[Date]
);