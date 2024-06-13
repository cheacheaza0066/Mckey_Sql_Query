SELECT TOP (1000) 
	   [Date]
      ,[Unit]
      ,[Meter_CO2]
      ,[Fill_Up_CO2]
      ,[CO2_usage]
      ,[Pressure]
      ,[Line5]
      ,[Line6]
      ,[Description]
  FROM (select 
       [Date]
      ,[Unit]
      ,[Meter_CO2]
      ,[Fill_Up_CO2]
      ,[Pressure]
      ,[Line5]
      ,[Line6]
      ,[Description]
	  ,case when [Meter_CO2] - LEAD([Meter_CO2]) over (order by [Date]) + [Fill_Up_CO2]  is null then 0 else [Meter_CO2] - LEAD([Meter_CO2]) over (order by [Date]) + [Fill_Up_CO2]  END as [CO2_usage]


	from [ISMPALI].[dbo].[ut_sus_rw_data_co2_usage]) 
       -- where [[ut_sus_rw_data_co2_usage]].[Date] between :Start and :Finish

  as Subquery