SELECT
    [Date]
      ,[Unit]
       ,[Bleed_off_No_01]
      ,[Total_Bleed_off_No_01]
      ,[Bleed_off_No_02]
      ,[Total_Bleed_off_No_02]
      ,[Bleed_off_No_03]
      ,[Total_Bleed_off_No_03]
      ,[Bleed_off_No_04]
      ,[Total_Bleed_off_No_04]
      ,(Total_Bleed_off_No_01 + Total_Bleed_off_No_02 + Total_Bleed_off_No_03 + Total_Bleed_off_No_04) as[Total_Line7_8_9]



FROM (
    SELECT
        [ID],
        [Date],
        [Unit],
        [Bleed_off_No_01]
      ,[Bleed_off_No_02]
      ,[Bleed_off_No_03]
      ,[Bleed_off_No_04]
	    , case when (LEAD([Bleed_off_No_01]) over (order by [Date]) - [Bleed_off_No_01])*0.001 is null then 0 else (LEAD([Bleed_off_No_01]) over (order by [Date]) - [Bleed_off_No_01])*0.001 END as [Total_Bleed_off_No_01]
      , case when (LEAD([Bleed_off_No_02]) over (order by [Date]) - [Bleed_off_No_02])*0.001 is null then 0 else (LEAD([Bleed_off_No_02]) over (order by [Date]) - [Bleed_off_No_02])*0.001 END as [Total_Bleed_off_No_02]
      , case when (LEAD([Bleed_off_No_03]) over (order by [Date]) - [Bleed_off_No_03])*0.001 is null then 0 else (LEAD([Bleed_off_No_03]) over (order by [Date]) - [Bleed_off_No_03])*0.001 END as [Total_Bleed_off_No_03]
      , case when (LEAD([Bleed_off_No_04]) over (order by [Date]) - [Bleed_off_No_04])*0.001 is null then 0 else (LEAD([Bleed_off_No_04]) over (order by [Date]) - [Bleed_off_No_04])*0.001 END as [Total_Bleed_off_No_04]

    FROM [ISMPALI].[dbo].[ut_sus_rw_data_water_usage_for_bleed_off_p4]
   -- where [[RawData_Electric_Usage_MDB1]].[Date] between :Start and :Finish
) AS Subquery;
