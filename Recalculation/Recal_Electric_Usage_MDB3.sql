DECLARE @StartTime DATETIME = '2024-06-12 00:00:00.000';
DECLARE @FinishTime DATETIME = '2024-06-13 00:00:00.000';--keyin


WITH SubqueryUpdate AS (
    SELECT
        [Date],
        [Unit],
        [MDB3],
        [Comp_Starter_SC01],
        [Comp_Starter_SC03],
        [Comp_Starter_SC06],
        [Comp_Starter_SC09],
        [Auxiliary_MDB3],
        ROW_NUMBER() OVER (ORDER BY [Date]) AS RowNum
    FROM (
        SELECT
            [ID],
            [Date],
            [Unit],
            CASE WHEN LAG([MDB3_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [MDB3_kW_Hr] - LAG([MDB3_kW_Hr]) OVER (ORDER BY [Date]) END AS [MDB3],
            CASE WHEN LAG([Comp_Starter_SC01_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Comp_Starter_SC01_kW_Hr] - LAG([Comp_Starter_SC01_kW_Hr]) OVER (ORDER BY [Date]) END AS [Comp_Starter_SC01],
            CASE WHEN LAG([Comp_Starter_SC03_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Comp_Starter_SC03_kW_Hr] - LAG([Comp_Starter_SC03_kW_Hr]) OVER (ORDER BY [Date]) END AS [Comp_Starter_SC03],
            CASE WHEN LAG([Comp_Starter_SC06_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Comp_Starter_SC06_kW_Hr] - LAG([Comp_Starter_SC06_kW_Hr]) OVER (ORDER BY [Date]) END AS [Comp_Starter_SC06],
            CASE WHEN LAG([Comp_Starter_SC09_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Comp_Starter_SC09_kW_Hr] - LAG([Comp_Starter_SC09_kW_Hr]) OVER (ORDER BY [Date]) END AS [Comp_Starter_SC09],
            CASE WHEN LAG([Auxiliary_MDB3_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Auxiliary_MDB3_kW_Hr] - LAG([Auxiliary_MDB3_kW_Hr]) OVER (ORDER BY [Date]) END AS [Auxiliary_MDB3]
        FROM [ISMPALI].[dbo].[ut_sus_rw_data_electric_usage_mdb3]
        WHERE [Date] BETWEEN @StartTime AND @FinishTime
    ) AS Subquery
)
UPDATE [ISMPALI].[dbo].[ut_sus_rpt_electric_usage_mdb3]
SET 
    [MDB3] = SubqueryUpdate.[MDB3],
    [Comp_Starter_SC01] = SubqueryUpdate.[Comp_Starter_SC01],
    [Comp_Starter_SC03] = SubqueryUpdate.[Comp_Starter_SC03],
    [Comp_Starter_SC06] = SubqueryUpdate.[Comp_Starter_SC06],
    [Comp_Starter_SC09] = SubqueryUpdate.[Comp_Starter_SC09],
    [Auxiliary_MDB3] = SubqueryUpdate.[Auxiliary_MDB3]
FROM SubqueryUpdate
WHERE
    [ut_sus_rpt_electric_usage_mdb3].[Date] = @FinishTime
    AND [ut_sus_rpt_electric_usage_mdb3].Approve = 0
    AND SubqueryUpdate.RowNum = 2; 
