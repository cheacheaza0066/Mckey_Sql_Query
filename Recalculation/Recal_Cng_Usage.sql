DECLARE @StartTime DATETIME = '2024-06-12 00:00:00.000';
DECLARE @FinishTime DATETIME = '2024-06-13 00:00:00.000';

WITH SubqueryUpdate AS (
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
            CASE WHEN LEAD([RUN_A_Meters]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE LEAD([RUN_A_Meters]) OVER (ORDER BY [Date]) - [RUN_A_Meters] END AS [RUN_A_Usage],
            CASE WHEN LEAD([RUN_B_Meters]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE LEAD([RUN_B_Meters]) OVER (ORDER BY [Date]) - [RUN_B_Meters] END AS [RUN_B_Usage],
            CASE WHEN LEAD([Hot_oil_01_Meters]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE LEAD([Hot_oil_01_Meters]) OVER (ORDER BY [Date]) - [Hot_oil_01_Meters] END AS [Hot_oil_01_Usage],
            CASE WHEN LEAD([Hot_oil_02_Meters]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE LEAD([Hot_oil_02_Meters]) OVER (ORDER BY [Date]) - [Hot_oil_02_Meters] END AS [Hot_oil_02_Usage],
            CASE WHEN LEAD([Hot_oil_03_Meters]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE LEAD([Hot_oil_03_Meters]) OVER (ORDER BY [Date]) - [Hot_oil_03_Meters] END AS [Hot_oil_03_Usage],
            CASE WHEN LEAD([Hot_oil_04_Meters]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE LEAD([Hot_oil_04_Meters]) OVER (ORDER BY [Date]) - [Hot_oil_04_Meters] END AS [Hot_oil_04_Usage],
            CASE WHEN LEAD([Hot_oil_05_Meters]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE LEAD([Hot_oil_05_Meters]) OVER (ORDER BY [Date]) - [Hot_oil_05_Meters] END AS [Hot_oil_05_Usage],
            CASE WHEN LEAD([Boiler_01_Meters]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE LEAD([Boiler_01_Meters]) OVER (ORDER BY [Date]) - [Boiler_01_Meters] END AS [Boiler_01_Usage],
            CASE WHEN LEAD([Boiler_02_Meters]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE LEAD([Boiler_02_Meters]) OVER (ORDER BY [Date]) - [Boiler_02_Meters] END AS [Boiler_02_Usage],
            CASE WHEN LEAD([Boiler_03_Meters]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE LEAD([Boiler_03_Meters]) OVER (ORDER BY [Date]) - [Boiler_03_Meters] END AS [Boiler_03_Usage],
            CASE WHEN LEAD([Boiler_04_Meters]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE LEAD([Boiler_04_Meters]) OVER (ORDER BY [Date]) - [Boiler_04_Meters] END AS [Boiler_04_Usage]
        FROM [ISMPALI].[dbo].[ut_sus_rw_data_cng_usage]
        WHERE [Date] BETWEEN @StartTime AND @FinishTime
    ) AS Subquery
)
UPDATE [ISMPALI].[dbo].[ut_sus_rpt_cng_usage]
SET 


    [Total_CNG_usage]= SubqueryUpdate.[Meter_CO2]
      ,[SCM_CNG_usage]= SubqueryUpdate.[Meter_CO2]
      ,[Hot_oil_01_Usage]= SubqueryUpdate.[Meter_CO2]
      ,[Hot_oil_02_Usage]= SubqueryUpdate.[Meter_CO2]
      ,[Hot_oil_03_Usage]= SubqueryUpdate.[Meter_CO2]
      ,[Hot_oil_04_Usage]= SubqueryUpdate.[Meter_CO2]
      ,[Hot_oil_05_Usage]= SubqueryUpdate.[Meter_CO2]
      ,[Boiler_01_Usage]= SubqueryUpdate.[Meter_CO2]
      ,[Boiler_02_Usage]= SubqueryUpdate.[Meter_CO2]
      ,[Boiler_03_Usage]= SubqueryUpdate.[Meter_CO2]
      ,[Boiler_04_Usage]= SubqueryUpdate.[Meter_CO2]
      ,[Hot_oil_Boiler_01_02] = SubqueryUpdate.[Meter_CO2]
      ,[SCM_Hot_oil_Boiler_Usage_01_02]= SubqueryUpdate.[Meter_CO2]
      ,[Total_Hot_Oil_Boiler_Usage_03_04_05]= SubqueryUpdate.[Meter_CO2]
      ,[SCM_Hot_oil_Boiler_Usage_03_04_05]= SubqueryUpdate.[Meter_CO2]


FROM SubqueryUpdate
WHERE 
    [ut_sus_rpt_cng_usage].[Date] = @FinishTime
    AND [ut_sus_rpt_cng_usage].[Approve] = 0
    AND SubqueryUpdate.RowNum = 2; 
