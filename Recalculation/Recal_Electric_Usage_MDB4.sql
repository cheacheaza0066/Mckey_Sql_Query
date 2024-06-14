DECLARE @StartTime DATETIME = '2024-06-12 00:00:00.000';
DECLARE @FinishTime DATETIME = '2024-06-13 00:00:00.000';--keyin


WITH SubqueryUpdate AS (
    SELECT
        [Date],
        [Unit],
        [MDB4],
        [Comp_Starter_SC02],
        [Comp_Starter_SC04],
        [Comp_Starter_SC05],
        [Comp_Starter_SC07],
        [Comp_Starter_SC08],
        [Auxiliary_MDB4],
        ROW_NUMBER() OVER (ORDER BY [Date]) AS RowNum
    FROM (
        SELECT
            [ID],
            [Date],
            [Unit],
            [MDB4_kW_Hr],
            [Comp_Starter_SC02_kW_Hr],
            [Comp_Starter_SC04_kW_Hr],
            [Comp_Starter_SC05_kW_Hr],
            [Comp_Starter_SC07_kW_Hr],
            [Comp_Starter_SC08_kW_Hr],
            [Auxiliary_MDB4_kW_Hr],
            CASE WHEN LAG([MDB4_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [MDB4_kW_Hr] - LAG([MDB4_kW_Hr]) OVER (ORDER BY [Date]) END AS [MDB4],
            CASE WHEN LAG([Comp_Starter_SC02_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Comp_Starter_SC02_kW_Hr] - LAG([Comp_Starter_SC02_kW_Hr]) OVER (ORDER BY [Date]) END AS [Comp_Starter_SC02],
            CASE WHEN LAG([Comp_Starter_SC04_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Comp_Starter_SC04_kW_Hr] - LAG([Comp_Starter_SC04_kW_Hr]) OVER (ORDER BY [Date]) END AS [Comp_Starter_SC04],
            CASE WHEN LAG([Comp_Starter_SC05_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Comp_Starter_SC05_kW_Hr] - LAG([Comp_Starter_SC05_kW_Hr]) OVER (ORDER BY [Date]) END AS [Comp_Starter_SC05],
            CASE WHEN LAG([Comp_Starter_SC07_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Comp_Starter_SC07_kW_Hr] - LAG([Comp_Starter_SC07_kW_Hr]) OVER (ORDER BY [Date]) END AS [Comp_Starter_SC07],
            CASE WHEN LAG([Comp_Starter_SC08_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Comp_Starter_SC08_kW_Hr] - LAG([Comp_Starter_SC08_kW_Hr]) OVER (ORDER BY [Date]) END AS [Comp_Starter_SC08],
            CASE WHEN LAG([Auxiliary_MDB4_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Auxiliary_MDB4_kW_Hr] - LAG([Auxiliary_MDB4_kW_Hr]) OVER (ORDER BY [Date]) END AS [Auxiliary_MDB4]
        FROM [ISMPALI].[dbo].[ut_sus_rw_data_electric_usage_mdb3]
        WHERE [Date] BETWEEN @StartTime AND @FinishTime
    ) AS Subquery
)
UPDATE [ISMPALI].[dbo].[ut_sus_rpt_electric_usage_mdb4]
SET 
    [MDB4] = SubqueryUpdate.[MDB4],
    [Comp_Starter_SC02] = SubqueryUpdate.[Comp_Starter_SC02],
    [Comp_Starter_SC04] = SubqueryUpdate.[Comp_Starter_SC04],
    [Comp_Starter_SC05] = SubqueryUpdate.[Comp_Starter_SC05],
    [Comp_Starter_SC07] = SubqueryUpdate.[Comp_Starter_SC07],
    [Comp_Starter_SC08] = SubqueryUpdate.[Comp_Starter_SC08],
    [Auxiliary_MDB4] = SubqueryUpdate.[Auxiliary_MDB4]
FROM SubqueryUpdate
WHERE
    [ut_sus_rpt_electric_usage_mdb4].[Date] = @FinishTime
    AND [ut_sus_rpt_electric_usage_mdb4].Approve = 0
    AND SubqueryUpdate.RowNum = 2; -- Update only the second row from the subquery
