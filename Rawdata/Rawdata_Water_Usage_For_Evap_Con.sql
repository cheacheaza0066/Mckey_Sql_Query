SELECT
    [Date]
      ,[Unit]
       ,[Evap_Con_01]
      ,[Evap_Con_01_per_Day]
      ,[Evap_Con_02]
      ,[Evap_Con_02_per_Day]
      ,[Evap_Con_03]
      ,[Evap_Con_03_per_Day]
      ,[Evap_Con_04]
      ,[Evap_Con_04_per_Day]
      ,(Evap_Con_01_per_Day + Evap_Con_02_per_Day + Evap_Con_03_per_Day + Evap_Con_04_per_Day) as[Total_Line5_6]
      ,[Evap_Line7_8_9]
      ,[Total_Line7_8_9]
FROM (
    SELECT
        [ID],
        [Date],
        [Unit],
        [Evap_Con_01]
      ,[Evap_Con_02]
      ,[Evap_Con_03]
      ,[Evap_Con_04]
      ,[Evap_Line7_8_9]

	    , case when (LEAD([Evap_Con_01]) over (order by [Date]) - [Evap_Con_01])*0.01 is null then 0 else (LEAD([Evap_Con_01]) over (order by [Date]) - [Evap_Con_01])*0.01 END as [Evap_Con_01_per_Day]
	    , case when (LEAD([Evap_Con_02]) over (order by [Date]) - [Evap_Con_02])*0.01 is null then 0 else (LEAD([Evap_Con_02]) over (order by [Date]) - [Evap_Con_02])*0.01 END as [Evap_Con_02_per_Day]
	    , case when (LEAD([Evap_Con_03]) over (order by [Date]) - [Evap_Con_03])*0.01 is null then 0 else (LEAD([Evap_Con_03]) over (order by [Date]) - [Evap_Con_03])*0.01 END as [Evap_Con_03_per_Day]
	    , case when (LEAD([Evap_Con_04]) over (order by [Date]) - [Evap_Con_04])*0.01 is null then 0 else (LEAD([Evap_Con_04]) over (order by [Date]) - [Evap_Con_04])*0.01 END as [Evap_Con_04_per_Day]
	    , case when (LEAD([Evap_Line7_8_9]) over (order by [Date]) - [Evap_Line7_8_9])*0.1 is null then 0 else (LEAD([Evap_Line7_8_9]) over (order by [Date]) - [Evap_Line7_8_9])*0.1 END as [Total_Line7_8_9]

    FROM [ISMPALI].[dbo].[ut_sus_rw_data_water_usage_for_evap_con]
   
   -- where [[RawData_Electric_Usage_MDB1]].[Date] between :Start and :Finish
) AS Subquery;
