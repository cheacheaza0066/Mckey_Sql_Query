DECLARE @StartTime DATETIME = '2024-06-12 00:00:00.000';--keyin
DECLARE @FinishTime DATETIME = '2024-06-13 00:00:00.000';
-- DECLARE @FinishTime DATETIME = CAST(GETDATE() AS DATE); 
-- DECLARE @StartTime DATETIME = DATEADD(DAY, -1, @FinishTime);

WITH SubqueryUpdate AS (
    SELECT
    [Date]
    ,[Unit]
    ,[Usage_Chilled_water_Line5_6]
      ,[Usage_Chilled_water_Line7_8_9]
      ,[Water_Glazing_Line7_8_9_per_Day]
      ,        ROW_NUMBER() OVER (ORDER BY [Date]) AS RowNum


FROM (
    SELECT
         [ID],
        [Date],
        [Unit],
        [Chilled_water_Line5_6]
      ,[Chilled_water_Line7_8_9]
      ,[Water_Glazing_Line7_8_9]
	    , case when (LEAD([Chilled_water_Line5_6]) over (order by [Date]) - [Chilled_water_Line5_6])*0.01 is null then 0 else (LEAD([Chilled_water_Line5_6]) over (order by [Date]) - [Chilled_water_Line5_6])*0.01 END as [Usage_Chilled_water_Line5_6]
      , case when (LEAD([Chilled_water_Line7_8_9]) over (order by [Date]) - [Chilled_water_Line7_8_9])*0.001 is null then 0 else (LEAD([Chilled_water_Line7_8_9]) over (order by [Date]) - [Chilled_water_Line7_8_9])*0.001 END as [Usage_Chilled_water_Line7_8_9]
      , case when (LEAD([Water_Glazing_Line7_8_9]) over (order by [Date]) - [Water_Glazing_Line7_8_9])*0.01 is null then 0 else (LEAD([Water_Glazing_Line7_8_9]) over (order by [Date]) - [Water_Glazing_Line7_8_9])*0.01 END as [Water_Glazing_Line7_8_9_per_Day]

        FROM [ISMPALI].[dbo].[ut_sus_rw_data_chille_water_usage]
        WHERE [Date] BETWEEN @StartTime AND @FinishTime
    ) AS Subquery
)
UPDATE [ISMPALI].[dbo].[ut_sus_rpt_chille_water_usage]
SET 


    [Usage_Chilled_water_Line5_6]= SubqueryUpdate.[Usage_Chilled_water_Line5_6]
      ,[Usage_Chilled_water_Line7_8_9]= SubqueryUpdate.[Usage_Chilled_water_Line7_8_9]
      ,[Water_Glazing_Line7_8_9_per_Day]= SubqueryUpdate.[Water_Glazing_Line7_8_9_per_Day]


FROM SubqueryUpdate
WHERE 
    [ut_sus_rpt_chille_water_usage].[Date] = @StartTime
    AND [ut_sus_rpt_chille_water_usage].[Approve] = 0
    AND SubqueryUpdate.RowNum = 1; 
