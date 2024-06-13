DECLARE @StartTime DATETIME = '2024-04-16 00:00:00.000';
DECLARE @FinishTime DATETIME = '2024-04-18 00:00:00.000';

WITH SubqueryUpdate AS (
    SELECT
        [Date],
        [Compressor_01_IQF5],
        [Compressor_02_IQF5],
        [Compressor_03_IQF6],
        [Compressor_04_Cold_Str],
        [Compressor_05_Roomtemp],
        [Compressor_06_Roomtemp],
        [Compressor_07_Spare],
        [Compressor_08_Office],
        [Compressor_09_Office],
        ROW_NUMBER() OVER (ORDER BY [Date]) AS RowNum
    FROM (
        SELECT
            [ID],
            [Date],
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
        FROM [ISMPALI].[dbo].[ut_sus_rw_data_running_hr_plant3]
        WHERE [Date] BETWEEN @StartTime AND @FinishTime
    ) AS Subquery
)
UPDATE [ISMPALI].[dbo].[ut_sus_rpt_running_hr_plant3]
SET 
    [Compressor_01_IQF5] = SubqueryUpdate.[Compressor_01_IQF5],
    [Compressor_02_IQF5] = SubqueryUpdate.[Compressor_02_IQF5],
    [Compressor_03_IQF6] = SubqueryUpdate.[Compressor_03_IQF6],
    [Compressor_04_Cold_Str] = SubqueryUpdate.[Compressor_04_Cold_Str],
    [Compressor_05_Roomtemp] = SubqueryUpdate.[Compressor_05_Roomtemp],
    [Compressor_06_Roomtemp] = SubqueryUpdate.[Compressor_06_Roomtemp],
    [Compressor_07_Spare] = SubqueryUpdate.[Compressor_07_Spare],
    [Compressor_08_Office] = SubqueryUpdate.[Compressor_08_Office],
    [Compressor_09_Office] = SubqueryUpdate.[Compressor_09_Office]
FROM SubqueryUpdate
WHERE
    [ut_sus_rpt_running_hr_plant3].[Date] = @FinishTime
    AND [ut_sus_rpt_running_hr_plant3].Approve = 0
    AND SubqueryUpdate.RowNum = 2; 