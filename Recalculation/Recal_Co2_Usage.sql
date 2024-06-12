DECLARE @StartTime DATETIME = '2024-04-16 00:00:00.000';
DECLARE @FinishTime DATETIME = '2024-04-18 00:00:00.000';

UPDATE [ISMPALI].[dbo].[ut_sus_rpt_co2_usage]
SET 
   [CO2_Remaining]= SubqueryUpdate.[Meter_CO2]
      ,[Fill_Up_CO2]= SubqueryUpdate.[Fill_Up_CO2]
      ,[CO2_usage]= SubqueryUpdate.[CO2_usage]
      ,[Pressure]= SubqueryUpdate.[Pressure]

    
FROM (
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
        WHERE [Date] BETWEEN @StartTime AND @FinishTime
    ) AS Subquery
) AS SubqueryUpdate
WHERE
    [ut_sus_rpt_co2_usage].[Date] = SubqueryUpdate.[Date]

    AND [ut_sus_rpt_co2_usage].Approve = 0;
