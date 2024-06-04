INSERT INTO [ISMPALI].[dbo].[ut_sus_rpt_electric_usage_mdb3]
    (
    [Date]
    ,[Unit]
    ,[MDB3]
    ,[Comp_Starter_SC01]
    ,[Comp_Starter_SC03]
    ,[Comp_Starter_SC06]
    ,[Comp_Starter_SC09]
    )
SELECT
    [Date]
    ,[Unit]
    ,[MDB3]
    ,[Comp_Starter_SC01]
    ,[Comp_Starter_SC03]
    ,[Comp_Starter_SC06]
    ,[Comp_Starter_SC09]
FROM (
    SELECT
        [ID],
        [Date],
        [Unit],
        [MDB3_kW_Hr]
      ,[Comp_Starter_SC01_kW_Hr]
      ,[Comp_Starter_SC03_kW_Hr]
      ,[Comp_Starter_SC06_kW_Hr]
      ,[Comp_Starter_SC09_kW_Hr],
	          CASE WHEN LAG([MDB3_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [MDB3_kW_Hr] - LAG([MDB3_kW_Hr]) OVER (ORDER BY [Date]) END AS [MDB3],

        CASE WHEN LAG([Comp_Starter_SC01_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Comp_Starter_SC01_kW_Hr] - LAG([Comp_Starter_SC01_kW_Hr]) OVER (ORDER BY [Date]) END AS [Comp_Starter_SC01],
        CASE WHEN LAG([Comp_Starter_SC03_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Comp_Starter_SC03_kW_Hr] - LAG([Comp_Starter_SC03_kW_Hr]) OVER (ORDER BY [Date]) END AS [Comp_Starter_SC03],
        CASE WHEN LAG([Comp_Starter_SC06_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Comp_Starter_SC06_kW_Hr] - LAG([Comp_Starter_SC06_kW_Hr]) OVER (ORDER BY [Date]) END AS [Comp_Starter_SC06],
        CASE WHEN LAG([Comp_Starter_SC09_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Comp_Starter_SC09_kW_Hr] - LAG([Comp_Starter_SC09_kW_Hr]) OVER (ORDER BY [Date]) END AS [Comp_Starter_SC09]
    FROM [ISMPALI].[dbo].[ut_sus_rw_data_electric_usage_mdb3]
        WHERE [Date] BETWEEN CONVERT(date, GETDATE() - 1 ) AND CONVERT(date, GETDATE() )

) AS Subquery
WHERE NOT EXISTS (
    SELECT 1
FROM [ISMPALI].[dbo].[ut_sus_rpt_electric_usage_mdb3]
WHERE [ut_sus_rpt_electric_usage_mdb3].[Date] = Subquery.[Date]
);
