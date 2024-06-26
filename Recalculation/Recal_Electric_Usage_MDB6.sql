DECLARE @StartTime DATETIME = '2024-06-12 00:00:00.000';
DECLARE @FinishTime DATETIME = '2024-06-13 00:00:00.000';--keyin

WITH SubqueryUpdate AS (
    SELECT
        [Date],
        [Unit],
        [MDB6],
        [SC_10_Cold_Storage],
        [SC_16_High_Stage_AC],
        [SC_17_Swing_Standby],
        [SC_11_Booster_IQF3],
        [Auxiliary],
        ROW_NUMBER() OVER (ORDER BY [Date]) AS RowNum
    FROM (
        SELECT
            [ID],
            [Date],
            [Unit],
            [MDB6_kW_Hr],
            [SC_10_Cold_Storage_kW_Hr],
            [SC_16_High_Stage_AC_kW_Hr],
            [SC_17_Swing_Standby_kW_Hr],
            [SC_11_Booster_IQF3_kW_Hr],
            [Auxiliary_kW_Hr],
            CASE WHEN LAG([MDB6_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [MDB6_kW_Hr] - LAG([MDB6_kW_Hr]) OVER (ORDER BY [Date]) END AS [MDB6],
            CASE WHEN LAG([SC_10_Cold_Storage_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [SC_10_Cold_Storage_kW_Hr] - LAG([SC_10_Cold_Storage_kW_Hr]) OVER (ORDER BY [Date]) END AS [SC_10_Cold_Storage],
            CASE WHEN LAG([SC_16_High_Stage_AC_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [SC_16_High_Stage_AC_kW_Hr] - LAG([SC_16_High_Stage_AC_kW_Hr]) OVER (ORDER BY [Date]) END AS [SC_16_High_Stage_AC],
            CASE WHEN LAG([SC_17_Swing_Standby_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [SC_17_Swing_Standby_kW_Hr] - LAG([SC_17_Swing_Standby_kW_Hr]) OVER (ORDER BY [Date]) END AS [SC_17_Swing_Standby],
            CASE WHEN LAG([SC_11_Booster_IQF3_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [SC_11_Booster_IQF3_kW_Hr] - LAG([SC_11_Booster_IQF3_kW_Hr]) OVER (ORDER BY [Date]) END AS [SC_11_Booster_IQF3],
            CASE WHEN LAG([Auxiliary_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Auxiliary_kW_Hr] - LAG([Auxiliary_kW_Hr]) OVER (ORDER BY [Date]) END AS [Auxiliary]
        FROM [ISMPALI].[dbo].[ut_sus_rw_data_electric_usage_mdb6]
        WHERE [Date] BETWEEN @StartTime AND @FinishTime
    ) AS Subquery
)
UPDATE [ISMPALI].[dbo].[ut_sus_rpt_electric_usage_mdb6]
SET 
    [MDB6] = SubqueryUpdate.[MDB6],
    [SC_10_Cold_Storage] = SubqueryUpdate.[SC_10_Cold_Storage],
    [SC_16_High_Stage_AC] = SubqueryUpdate.[SC_16_High_Stage_AC],
    [SC_17_Swing_Standby] = SubqueryUpdate.[SC_17_Swing_Standby],
    [SC_11_Booster_IQF3] = SubqueryUpdate.[SC_11_Booster_IQF3],
    [Auxiliary] = SubqueryUpdate.[Auxiliary]
FROM SubqueryUpdate
WHERE
    [ut_sus_rpt_electric_usage_mdb6].[Date] = @FinishTime
    AND [ut_sus_rpt_electric_usage_mdb6].Approve = 0
    AND SubqueryUpdate.RowNum = 2; -- Update only the second row from the subquery
