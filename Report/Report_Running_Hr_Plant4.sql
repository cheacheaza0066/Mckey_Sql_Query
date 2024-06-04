INSERT INTO [ISMPALI].[dbo].[ut_sus_rpt_running_hr_plant4]
    (
    [Date]
    ,[Unit]
    ,[Compressor_01_Cold_Str]
    ,[Compressor_02_IQF7]
    ,[Compressor_03_IQF8]
    ,[Compressor_04_IQF9]
    ,[Compressor_05_AirCon]
    ,[Compressor_06_AirCon]
    ,[Compressor_07_AirCon]
    ,[Compressor_08_Spare]
    ,[Compressor_09_Office]
    )
SELECT
    [Date]
    , [Unit]
  , [Compressor_01_Cold_Str]
      , [Compressor_02_IQF7]
      , [Compressor_03_IQF8]
      , [Compressor_04_IQF9]
      , [Compressor_05_AirCon]
      , [Compressor_06_AirCon]
      , [Compressor_07_AirCon]
      , [Compressor_08_Spare]
      , [Compressor_09_Office]
FROM (
    SELECT
        [Date],
        [Unit],
        [Comp_Starter_SC01],
        [Comp_Starter_SC02],
        [Comp_Starter_SC03],
        [Comp_Starter_SC04],
        [Comp_Starter_SC05],
        [Comp_Starter_SC06],
        [Comp_Starter_SC07],
        [Comp_Starter_SC08],
        [Comp_Starter_SC09],
        CASE WHEN LAG([Comp_Starter_SC01]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Comp_Starter_SC01] - LAG([Comp_Starter_SC01]) OVER (ORDER BY [Date]) END AS [Compressor_01_Cold_Str],
        CASE WHEN LAG([Comp_Starter_SC02]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Comp_Starter_SC02] - LAG([Comp_Starter_SC02]) OVER (ORDER BY [Date]) END AS [Compressor_02_IQF7],
        CASE WHEN LAG([Comp_Starter_SC03]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Comp_Starter_SC03] - LAG([Comp_Starter_SC03]) OVER (ORDER BY [Date]) END AS [Compressor_03_IQF8],
        CASE WHEN LAG([Comp_Starter_SC04]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Comp_Starter_SC04] - LAG([Comp_Starter_SC04]) OVER (ORDER BY [Date]) END AS [Compressor_04_IQF9],
        CASE WHEN LAG([Comp_Starter_SC05]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Comp_Starter_SC05] - LAG([Comp_Starter_SC05]) OVER (ORDER BY [Date]) END AS [Compressor_05_AirCon],
        CASE WHEN LAG([Comp_Starter_SC06]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Comp_Starter_SC06] - LAG([Comp_Starter_SC06]) OVER (ORDER BY [Date]) END AS [Compressor_06_AirCon],
        CASE WHEN LAG([Comp_Starter_SC07]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Comp_Starter_SC07] - LAG([Comp_Starter_SC07]) OVER (ORDER BY [Date]) END AS [Compressor_07_AirCon],
        CASE WHEN LAG([Comp_Starter_SC08]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Comp_Starter_SC08] - LAG([Comp_Starter_SC08]) OVER (ORDER BY [Date]) END AS [Compressor_08_Spare],
        CASE WHEN LAG([Comp_Starter_SC09]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Comp_Starter_SC09] - LAG([Comp_Starter_SC09]) OVER (ORDER BY [Date]) END AS [Compressor_09_Office]
    FROM [ISMPALI].[dbo].[ut_sus_rw_data_running_hr_plant4]
        WHERE [Date] BETWEEN CONVERT(date, GETDATE() - 1 ) AND CONVERT(date, GETDATE() )


) AS Subquery
WHERE NOT EXISTS (
    SELECT 1
FROM [ISMPALI].[dbo].[ut_sus_rpt_running_hr_plant4]
WHERE [ut_sus_rpt_running_hr_plant4].[Date] = Subquery.[Date]
);
