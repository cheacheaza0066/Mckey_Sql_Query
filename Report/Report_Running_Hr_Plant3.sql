INSERT INTO [ISMPALI].[dbo].[Report_Running_Hr_Plant3]
    (
    [Date],
    [Unit],
    [Compressor_01_IQF5],
    [Compressor_02_IQF5],
    [Compressor_03_IQF6],
    [Compressor_04_Cold_Str],
    [Compressor_05_Roomtemp],
    [Compressor_06_Roomtemp],
    [Compressor_07_Spare],
    [Compressor_08_Office],
    [Compressor_09_Office]
    )
SELECT
    [Date],
    [Unit],
    [Compressor_01_IQF5],
    [Compressor_02_IQF5],
    [Compressor_03_IQF6],
    [Compressor_04_Cold_Str],
    [Compressor_05_Roomtemp],
    [Compressor_06_Roomtemp],
    [Compressor_07_Spare],
    [Compressor_08_Office],
    [Compressor_09_Office]
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
        CASE WHEN LAG([Comp_Starter_SC01]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Comp_Starter_SC01] - LAG([Comp_Starter_SC01]) OVER (ORDER BY [Date]) END AS [Compressor_01_IQF5],
        CASE WHEN LAG([Comp_Starter_SC02]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Comp_Starter_SC02] - LAG([Comp_Starter_SC02]) OVER (ORDER BY [Date]) END AS [Compressor_02_IQF5],
        CASE WHEN LAG([Comp_Starter_SC03]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Comp_Starter_SC03] - LAG([Comp_Starter_SC03]) OVER (ORDER BY [Date]) END AS [Compressor_03_IQF6],
        CASE WHEN LAG([Comp_Starter_SC04]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Comp_Starter_SC04] - LAG([Comp_Starter_SC04]) OVER (ORDER BY [Date]) END AS [Compressor_04_Cold_Str],
        CASE WHEN LAG([Comp_Starter_SC05]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Comp_Starter_SC05] - LAG([Comp_Starter_SC05]) OVER (ORDER BY [Date]) END AS [Compressor_05_Roomtemp],
        CASE WHEN LAG([Comp_Starter_SC06]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Comp_Starter_SC06] - LAG([Comp_Starter_SC06]) OVER (ORDER BY [Date]) END AS [Compressor_06_Roomtemp],
        CASE WHEN LAG([Comp_Starter_SC07]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Comp_Starter_SC07] - LAG([Comp_Starter_SC07]) OVER (ORDER BY [Date]) END AS [Compressor_07_Spare],
        CASE WHEN LAG([Comp_Starter_SC08]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Comp_Starter_SC08] - LAG([Comp_Starter_SC08]) OVER (ORDER BY [Date]) END AS [Compressor_08_Office],
        CASE WHEN LAG([Comp_Starter_SC09]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Comp_Starter_SC09] - LAG([Comp_Starter_SC09]) OVER (ORDER BY [Date]) END AS [Compressor_09_Office]
    FROM [ISMPALI].[dbo].[Rawdata_Running_Hr_Plant3]
) AS Subquery
WHERE NOT EXISTS (
    SELECT 1
FROM [ISMPALI].[dbo].[Report_Running_Hr_Plant3]
WHERE [Report_Running_Hr_Plant3].[Date] = Subquery.[Date]
);
