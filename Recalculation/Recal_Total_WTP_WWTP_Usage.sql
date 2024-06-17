DECLARE @StartTime DATETIME = '2024-06-12 00:00:00.000';--keyin
DECLARE @FinishTime DATETIME = '2024-06-13 00:00:00.000';
-- DECLARE @FinishTime DATETIME = CAST(GETDATE() AS DATE); 
-- DECLARE @StartTime DATETIME = DATEADD(DAY, -1, @FinishTime);

WITH SubqueryUpdate AS (
    SELECT
  [Date]
      , [Unit]
       , [Deep_well]
      , [Portable_water]
            , [Total_water_PWA_supply_usage] -- =Deep_well + Portable_water + (Lead(Water_supply) - Water_supply)
      , [Total_water_Apartmeat_usage]-- formula
      , (Waste_water_DAF+Waste_water_BGR1+Waste_water_BGR2) as [Total_waste_water]--formula

      , (CTW_Tank_01 + CTW_Tank_02 + CTW_Tank_03 +STL_Tank_01+STL_Tank_02+STL_Tank_03+STL_Tank_04) as[Total_in_tank]
     
      , [Total_Water_Reuse]--formula
       , ROW_NUMBER() OVER (ORDER BY [Date]) AS RowNum



FROM (select
    [Date]
      , [Unit]
      , [CTW_Tank_01]
      , [CTW_Tank_02]
      , [CTW_Tank_03]
      , [STL_Tank_01]
      , [STL_Tank_02]
      , [STL_Tank_03]
      , [STL_Tank_04]
      , [Deep_well]
      , [Portable_water]
      , [Water_supply]
      , [Water_supply_Apartmeat]
      , [Influent_Flow_Meter_DAF]
      , [Influent_Flow_Meter_BGR1]
      , [Influent_Flow_Meter_BGR2]
      , [Flow_Meter_Water_Reuse]

	  , case when ([Deep_well] + [Portable_water]) +  (LEAD([Water_supply]) over (order by [Date]) - [Water_supply])  is null then 0 else ([Deep_well] + [Portable_water]) +  (LEAD([Water_supply]) over (order by [Date]) - [Water_supply])  END as [Total_water_PWA_supply_usage]

	  , case when LEAD([Water_supply_Apartmeat]) over (order by [Date]) - [Water_supply_Apartmeat] is null then 0 else LEAD([Water_supply_Apartmeat]) over (order by [Date]) - [Water_supply_Apartmeat] END as [Total_water_Apartmeat_usage]


	  , case when 
    (([CTW_Tank_01] + [CTW_Tank_02]+[CTW_Tank_03]) +  
    (LEAD([CTW_Tank_01]) over (order by [Date]) + 
    (LEAD([CTW_Tank_02]) over (order by [Date]))+
    (LEAD([CTW_Tank_03]) over (order by [Date])))+
    (([Deep_well] + [Portable_water]) +  (LEAD([Water_supply]) over (order by [Date]) - [Water_supply]) -
    LEAD([Water_supply_Apartmeat]) over (order by [Date]) - [Water_supply_Apartmeat]
    )
    )  is null then 0 
    else (([CTW_Tank_01] + [CTW_Tank_02]+[CTW_Tank_03]) +  
    (LEAD([CTW_Tank_01]) over (order by [Date]) + 
    (LEAD([CTW_Tank_02]) over (order by [Date]))+
    (LEAD([CTW_Tank_03]) over (order by [Date])))+
    (([Deep_well] + [Portable_water]) +  (LEAD([Water_supply]) over (order by [Date]) - [Water_supply]) -
    LEAD([Water_supply_Apartmeat]) over (order by [Date]) - [Water_supply_Apartmeat]
    )
    )   END as [Actual_water_usage]


    , case when LEAD([Influent_Flow_Meter_DAF]) over (order by [Date]) - [Influent_Flow_Meter_DAF] is null then 0 else LEAD([Influent_Flow_Meter_DAF]) over (order by [Date]) - [Influent_Flow_Meter_DAF] END as [Waste_water_DAF]
    , case when LEAD([Influent_Flow_Meter_BGR1]) over (order by [Date]) - [Influent_Flow_Meter_BGR1] is null then 0 else LEAD([Influent_Flow_Meter_BGR1]) over (order by [Date]) - [Influent_Flow_Meter_BGR1] END as [Waste_water_BGR1]
    , case when LEAD([Influent_Flow_Meter_BGR2]) over (order by [Date]) - [Influent_Flow_Meter_BGR2] is null then 0 else LEAD([Influent_Flow_Meter_BGR2]) over (order by [Date]) - [Influent_Flow_Meter_BGR2] END as [Waste_water_BGR2]

    , case when LEAD([Flow_Meter_Water_Reuse]) over (order by [Date]) - [Flow_Meter_Water_Reuse] is null then 0 else LEAD([Flow_Meter_Water_Reuse]) over (order by [Date]) - [Flow_Meter_Water_Reuse] END as [Total_Water_Reuse]


  FROM [ISMPALI].[dbo].[ut_sus_rw_data_total_wtp_wwtp_usage]
        WHERE [Date] BETWEEN @StartTime AND @FinishTime
    ) AS Subquery
)
UPDATE [ISMPALI].[dbo].[ut_sus_rpt_total_wtp_wwtp_usage]
SET 


    [Deep_well]= SubqueryUpdate.[Deep_well]
      ,[Portable_water]= SubqueryUpdate.[Portable_water]
      ,[Total_water_PWA_supply_usage]= SubqueryUpdate.[Total_water_PWA_supply_usage]
      ,[Total_water_Apartmeat_usage]= SubqueryUpdate.[Total_water_Apartmeat_usage]
      ,[Total_waste_water]= SubqueryUpdate.[Total_waste_water]
      ,[Total_in_tank]= SubqueryUpdate.[Total_in_tank]
      ,[Total_water_Reuse]= SubqueryUpdate.[Total_water_Reuse]


FROM SubqueryUpdate
WHERE 
    [ut_sus_rpt_total_wtp_wwtp_usage].[Date] = @StartTime
    AND [ut_sus_rpt_total_wtp_wwtp_usage].[Approve] = 0
    AND SubqueryUpdate.RowNum = 1; 
