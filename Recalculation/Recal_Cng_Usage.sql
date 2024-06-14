DECLARE @StartTime DATETIME = '2024-06-13 00:00:00.000';--keyin user
DECLARE @FinishTime DATETIME = '2024-06-14 00:00:00.000';
-- DECLARE @FinishTime DATETIME = CAST(GETDATE() AS DATE); 
-- DECLARE @StartTime DATETIME = DATEADD(DAY, -1, @FinishTime);
WITH
    SubqueryUpdate
    AS
    (
        SELECT
            [Date],
            [Unit],
            (RUN_A_Usage + RUN_B_Usage) AS Total_CNG_usage,
            (RUN_A_Usage + RUN_B_Usage) * (27 + 14.696) * (60 + 460) / (14.73 * (9 * (25 + 273.15) / 5)) AS [SCM_CNG_usage],
            [Hot_oil_01_Usage],
            [Hot_oil_02_Usage],
            [Hot_oil_03_Usage],
            [Hot_oil_04_Usage],
            [Hot_oil_05_Usage],
            [Boiler_01_Usage],
            [Boiler_02_Usage],
            [Boiler_03_Usage],
            [Boiler_04_Usage],
            ((Hot_oil_01_Usage + Hot_oil_02_Usage) + (Boiler_01_Usage + Boiler_02_Usage)) AS Hot_oil_Boiler_01_02,
            ((([Hot_oil_01_Usage] + [Hot_oil_02_Usage]) + ([Hot_oil_03_Usage] + [Hot_oil_04_Usage] + [Hot_oil_05_Usage]) + ([Boiler_01_Usage] + [Boiler_02_Usage]) + ([Boiler_03_Usage] + [Boiler_04_Usage])) * (27 + 14.696) * (60 + 460) / (14.73 * (9 * (25 + 273.15) / 5))) AS [SCM_Hot_oil_Boiler_Usage_01_02],
            ((Hot_oil_03_Usage + Hot_oil_04_Usage + Hot_oil_05_Usage) + (Boiler_03_Usage + Boiler_04_Usage)) AS [Total_Hot_Oil_Boiler_Usage_03_04_05],
            (((Hot_oil_03_Usage + Hot_oil_04_Usage + Hot_oil_05_Usage) + (Boiler_03_Usage + Boiler_04_Usage)) * (27 + 14.696) * (60 + 460) / (14.73 * (9 * (25 + 273.15) / 5))) AS [SCM_Hot_oil_Boiler_Usage_03_04_05]
           , ROW_NUMBER() OVER (ORDER BY [Date]) AS RowNum

        FROM (
        SELECT
                [Date],
                [Unit],
                [RUN_A_Meters],
                [RUN_B_Meters],
                [Hot_oil_01_Meters],
                [Hot_oil_02_Meters],
                [Hot_oil_03_Meters],
                [Hot_oil_04_Meters],
                [Hot_oil_05_Meters],
                [Boiler_01_Meters],
                [Boiler_02_Meters],
                [Boiler_03_Meters],
                [Boiler_04_Meters], 
             case when LEAD([RUN_A_Meters]) over (order by [Date]) - [RUN_A_Meters] is null then 0 else LEAD([RUN_A_Meters]) over (order by [Date]) - [RUN_A_Meters] END as [RUN_A_Usage]
	 	, case when LEAD([RUN_B_Meters]) over (order by [Date]) - [RUN_B_Meters] is null then 0 else LEAD([RUN_B_Meters]) over (order by [Date]) - [RUN_B_Meters] END as [RUN_B_Usage]

	 	, case when LEAD([Hot_oil_01_Meters]) over (order by [Date]) - [Hot_oil_01_Meters] is null then 0 else LEAD([Hot_oil_01_Meters]) over (order by [Date]) - [Hot_oil_01_Meters] END as [Hot_oil_01_Usage]
    , case when LEAD([Hot_oil_02_Meters]) over (order by [Date]) - [Hot_oil_02_Meters] is null then 0 else LEAD([Hot_oil_02_Meters]) over (order by [Date]) - [Hot_oil_02_Meters] END as [Hot_oil_02_Usage]
    , case when LEAD([Hot_oil_03_Meters]) over (order by [Date]) - [Hot_oil_03_Meters] is null then 0 else LEAD([Hot_oil_03_Meters]) over (order by [Date]) - [Hot_oil_03_Meters] END as [Hot_oil_03_Usage]
    , case when LEAD([Hot_oil_04_Meters]) over (order by [Date]) - [Hot_oil_04_Meters] is null then 0 else LEAD([Hot_oil_04_Meters]) over (order by [Date]) - [Hot_oil_04_Meters] END as [Hot_oil_04_Usage]
    , case when LEAD([Hot_oil_05_Meters]) over (order by [Date]) - [Hot_oil_05_Meters] is null then 0 else LEAD([Hot_oil_05_Meters]) over (order by [Date]) - [Hot_oil_05_Meters] END as [Hot_oil_05_Usage]

    , case when LEAD([Boiler_01_Meters]) over (order by [Date]) - [Boiler_01_Meters] is null then 0 else LEAD([Boiler_01_Meters]) over (order by [Date]) - [Boiler_01_Meters] END as [Boiler_01_Usage]
    , case when LEAD([Boiler_02_Meters]) over (order by [Date]) - [Boiler_02_Meters] is null then 0 else LEAD([Boiler_02_Meters]) over (order by [Date]) - [Boiler_02_Meters] END as [Boiler_02_Usage]
    , case when LEAD([Boiler_03_Meters]) over (order by [Date]) - [Boiler_03_Meters] is null then 0 else LEAD([Boiler_03_Meters]) over (order by [Date]) - [Boiler_03_Meters] END as [Boiler_03_Usage]
    , case when LEAD([Boiler_04_Meters]) over (order by [Date]) - [Boiler_04_Meters] is null then 0 else LEAD([Boiler_04_Meters]) over (order by [Date]) - [Boiler_04_Meters] END as [Boiler_04_Usage]

            FROM [ISMPALI].[dbo].[ut_sus_rw_data_cng_usage]
            WHERE [Date] BETWEEN @StartTime AND @FinishTime
    ) AS Subquery
    )
UPDATE [ISMPALI].[dbo].[ut_sus_rpt_cng_usage]
SET 


    [Total_CNG_usage]= SubqueryUpdate.[Total_CNG_usage]
      ,[SCM_CNG_usage]= SubqueryUpdate.[SCM_CNG_usage]
      ,[Hot_oil_01_Usage]= SubqueryUpdate.[Hot_oil_01_Usage]
      ,[Hot_oil_02_Usage]= SubqueryUpdate.[Hot_oil_02_Usage]
      ,[Hot_oil_03_Usage]= SubqueryUpdate.[Hot_oil_03_Usage]
      ,[Hot_oil_04_Usage]= SubqueryUpdate.[Hot_oil_04_Usage]
      ,[Hot_oil_05_Usage]= SubqueryUpdate.[Hot_oil_05_Usage]
      ,[Boiler_01_Usage]= SubqueryUpdate.[Boiler_01_Usage]
      ,[Boiler_02_Usage]= SubqueryUpdate.[Boiler_02_Usage]
      ,[Boiler_03_Usage]= SubqueryUpdate.[Boiler_03_Usage]
      ,[Boiler_04_Usage]= SubqueryUpdate.[Boiler_04_Usage]
      ,[Hot_oil_Boiler_01_02] = SubqueryUpdate.[Hot_oil_Boiler_01_02]
      ,[SCM_Hot_oil_Boiler_Usage_01_02]= SubqueryUpdate.[SCM_Hot_oil_Boiler_Usage_01_02]
      ,[Total_Hot_Oil_Boiler_Usage_03_04_05]= SubqueryUpdate.[Total_Hot_Oil_Boiler_Usage_03_04_05]
      ,[SCM_Hot_oil_Boiler_Usage_03_04_05]= SubqueryUpdate.[SCM_Hot_oil_Boiler_Usage_03_04_05]


FROM SubqueryUpdate
WHERE 
    [ut_sus_rpt_cng_usage].[Date] = @StartTime
    AND [ut_sus_rpt_cng_usage].[Approve] = 0
    AND SubqueryUpdate.RowNum = 1; 
