SELECT TOP (1000)
     [Date]
      , [Unit]
      , [CTW_Tank_01]
      , [CTW_Tank_02]
      , [CTW_Tank_03]
      , [STL_Tank_01]
      , [STL_Tank_02]
      , [STL_Tank_03]
      , [STL_Tank_04]
      , (CTW_Tank_01 + CTW_Tank_02 + CTW_Tank_03 +STL_Tank_01+STL_Tank_02+STL_Tank_03+STL_Tank_04) as[Total_in_tank]
      , [Deep_well]
      , [Portable_water]
      , [Water_supply]
      , [Total_water_PWA_supply_usage] -- =Deep_well + Portable_water + (Lead(Water_supply) - Water_supply)


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

	  , case when ([Deep_well] + [Portable_water]) +  (LEAD([Water_supply]) over (order by [Date]) - [Water_supply])  is null then 0 
       
       else ([Deep_well] + [Portable_water]) +  (LEAD([Water_supply]) over (order by [Date]) - [Water_supply])  END as [Total_water_PWA_supply_usage]


     from [ISMPALI].[dbo].[ut_sus_rw_data_total_wtp_wwtp_usage]) 
       -- where [[ut_sus_rw_data_co2_usage]].[Date] between :Start and :Finish

  as Subquery