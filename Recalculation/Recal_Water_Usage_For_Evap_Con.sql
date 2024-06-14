DECLARE @StartTime DATETIME = '2024-06-12 00:00:00.000';--keyin
DECLARE @FinishTime DATETIME = '2024-06-13 00:00:00.000';
-- DECLARE @FinishTime DATETIME = CAST(GETDATE() AS DATE); 
-- DECLARE @StartTime DATETIME = DATEADD(DAY, -1, @FinishTime);
WITH SubqueryUpdate AS (
    SELECT
    [Date]
    ,[Unit]
    ,[Evap_Con_01_per_Day]
      ,[Evap_Con_02_per_Day]
      ,[Evap_Con_03_per_Day]
      ,[Evap_Con_04_per_Day]
      ,(Evap_Con_01_per_Day + Evap_Con_02_per_Day + Evap_Con_03_per_Day + Evap_Con_04_per_Day) as[Total_Line5_6]
      ,[Total_Line7_8_9]
             , ROW_NUMBER() OVER (ORDER BY [Date]) AS RowNum


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
   
        WHERE [Date] BETWEEN @StartTime AND @FinishTime
    ) AS Subquery
)
UPDATE [ISMPALI].[dbo].[ut_sus_rpt_water_usage_for_evap_con]
SET 


    [Evap_Con_01_per_Day]= SubqueryUpdate.[Evap_Con_01_per_Day]
      ,[Evap_Con_02_per_Day]= SubqueryUpdate.[Evap_Con_02_per_Day]
      ,[Evap_Con_03_per_Day]= SubqueryUpdate.[Evap_Con_03_per_Day]
      ,[Evap_Con_04_per_Day]= SubqueryUpdate.[Evap_Con_04_per_Day]
      ,[Total_Line5_6]= SubqueryUpdate.[Total_Line5_6]
      ,[Total_Line7_8_9]= SubqueryUpdate.[Total_Line7_8_9]


FROM SubqueryUpdate
WHERE 
    [ut_sus_rpt_water_usage_for_evap_con].[Date] = @StartTime
    AND [ut_sus_rpt_water_usage_for_evap_con].[Approve] = 0
    AND SubqueryUpdate.RowNum = 1; 
