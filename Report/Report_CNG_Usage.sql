INSERT INTO [ISMPALI].[dbo].[ut_sus_rpt_cng_usage]
    (
     [Date]
      ,[Unit]
      ,[Total_CNG_usage]
      ,[SCM_CNG_usage]
      ,[Hot_oil_01_Usage]
      ,[Hot_oil_02_Usage]
      ,[Hot_oil_03_Usage]
      ,[Hot_oil_04_Usage]
      ,[Hot_oil_05_Usage]
      ,[Boiler_01_Usage]
      ,[Boiler_02_Usage]
      ,[Boiler_03_Usage]
      ,[Boiler_04_Usage]
      ,[Hot_oil_Boiler_01_02] --Total_Hot_oil_01_02 + Total_Boiler_01_02
      ,[SCM_Hot_oil_Boiler_Usage_01_02]
      ,[Total_Hot_Oil_Boiler_Usage_03_04_05]
      ,[SCM_Hot_oil_Boiler_Usage_03_04_05]
      
    )
SELECT
     [Date]
      , [Unit]
      , (RUN_A_Usage + RUN_B_Usage) AS Total_CNG_usage
        , (RUN_A_Usage + RUN_B_Usage) * (27 + 14.696) * (60 + 460) / (14.73 * (9 * (25 + 273.15) / 5)) AS [SCM_CNG_usage]
      , [Hot_oil_01_Usage] 
      , [Hot_oil_02_Usage] 
      , [Hot_oil_03_Usage] 
      , [Hot_oil_04_Usage] 
      , [Hot_oil_05_Usage] 
      , [Boiler_01_Usage]
      , [Boiler_02_Usage]
      , [Boiler_03_Usage]
      , [Boiler_04_Usage]
      , ((Hot_oil_01_Usage + Hot_oil_02_Usage)+(Boiler_01_Usage + Boiler_02_Usage))  as Hot_oil_Boiler_01_02
      , ((([Hot_oil_01_Usage] + [Hot_oil_02_Usage]) + ([Hot_oil_03_Usage] + [Hot_oil_04_Usage] + [Hot_oil_05_Usage]) + ([Boiler_01_Usage] + [Boiler_02_Usage]) + ([Boiler_03_Usage] + [Boiler_04_Usage])) * (27 + 14.696) * (60 + 460) / (14.73 * (9 * (25 + 273.15) / 5))) AS [SCM_Hot_oil_Boiler_Usage_01_02]


, ((Hot_oil_03_Usage + Hot_oil_04_Usage + Hot_oil_05_Usage)+(Boiler_03_Usage + Boiler_04_Usage)) as [Total_Hot_Oil_Boiler_Usage_03_04_05]

, (((Hot_oil_03_Usage + Hot_oil_04_Usage + Hot_oil_05_Usage) + (Boiler_03_Usage + Boiler_04_Usage)) * (27 + 14.696) * (60 + 460) / (14.73 * (9 * (25 + 273.15) / 5))) as SCM_Hot_oil_Boiler_Usage_03_04_05

FROM (
    SELECT
       [Date]
      , [Unit]
      , [RUN_A_Meters] 
      , [RUN_B_Meters]
      , [Hot_oil_01_Meters]
      , [Hot_oil_02_Meters]
      , [Hot_oil_03_Meters]
      , [Hot_oil_04_Meters]
      , [Hot_oil_05_Meters]
      , [Boiler_01_Meters]
      , [Boiler_02_Meters]
      , [Boiler_03_Meters]
      , [Boiler_04_Meters]
	  , case when LEAD([RUN_A_Meters]) over (order by [Date]) - [RUN_A_Meters] is null then 0 else LEAD([RUN_A_Meters]) over (order by [Date]) - [RUN_A_Meters] END as [RUN_A_Usage]
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



  from [ISMPALI].[dbo].[ut_sus_rw_data_cng_usage]
        WHERE [Date] BETWEEN CONVERT(date, GETDATE() - 1 ) AND CONVERT(date, GETDATE() )

) AS Subquery
WHERE NOT EXISTS (
    SELECT 1
FROM [ISMPALI].[dbo].[ut_sus_rpt_cng_usage]
WHERE [ut_sus_rpt_cng_usage].[Date] = Subquery.[Date]
);
