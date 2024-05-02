SELECT
    [Date]
      ,[Unit]
       ,[MDB3_kW_Hr]
      ,[MDB3]
      ,[Comp_Starter_SC01_kW_Hr]
      ,[Comp_Starter_SC01]
      ,[Comp_Starter_SC03_kW_Hr]
      ,[Comp_Starter_SC03]
      ,[Comp_Starter_SC06_kW_Hr]
      ,[Comp_Starter_SC06]
      ,[Comp_Starter_SC09_kW_Hr]
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
   -- where [[RawData_Electric_Usage_MDB1]].[Date] between :Start and :Finish
) AS Subquery;
