INSERT INTO [ISMPALI].[dbo].[ut_sus_rpt_chille_water_usage]
    (
    [Date]
    ,[Unit]
    ,[Usage_Chilled_water_Line5_6]
      ,[Usage_Chilled_water_Line7_8_9]
      ,[Water_Glazing_Line7_8_9_per_Day]
    )
SELECT
    [Date]
    ,[Unit]
    ,[Usage_Chilled_water_Line5_6]
      ,[Usage_Chilled_water_Line7_8_9]
      ,[Water_Glazing_Line7_8_9_per_Day]

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
        WHERE [Date] BETWEEN CONVERT(date, GETDATE() - 1 ) AND CONVERT(date, GETDATE() )

) AS Subquery
WHERE NOT EXISTS (
    SELECT 1
FROM [ISMPALI].[dbo].[ut_sus_rpt_chille_water_usage]
WHERE [ut_sus_rpt_chille_water_usage].[Date] = Subquery.[Date]
);
