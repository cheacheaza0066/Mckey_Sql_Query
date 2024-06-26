INSERT INTO [ISMPALI].[dbo].[ut_sus_rpt_electric_usage_mdb6]
    (
    [Date]
    ,[Unit]
    ,[MDB6]
      ,[SC_10_Cold_Storage]
      ,[SC_16_High_Stage_AC]
      ,[SC_17_Swing_Standby]
      ,[SC_11_Booster_IQF3]
      ,[Auxiliary]
    )
SELECT
    [Date]
    ,[Unit]
    ,[MDB6]
      ,[SC_10_Cold_Storage]
      ,[SC_16_High_Stage_AC]
      ,[SC_17_Swing_Standby]
      ,[SC_11_Booster_IQF3]
      ,[Auxiliary]
FROM (
    SELECT
        [ID],
        [Date],
        [Unit],
          [MDB6_kW_Hr]
      ,[SC_10_Cold_Storage_kW_Hr]
      ,[SC_16_High_Stage_AC_kW_Hr]
      ,[SC_17_Swing_Standby_kW_Hr]
      ,[SC_11_Booster_IQF3_kW_Hr]
      ,[Auxiliary_kW_Hr],

	      CASE WHEN LAG([MDB6_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [MDB6_kW_Hr] - LAG([MDB6_kW_Hr]) OVER (ORDER BY [Date]) END AS [MDB6],
        CASE WHEN LAG([SC_10_Cold_Storage_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [SC_10_Cold_Storage_kW_Hr] - LAG([SC_10_Cold_Storage_kW_Hr]) OVER (ORDER BY [Date]) END AS [SC_10_Cold_Storage],

        CASE WHEN LAG([SC_16_High_Stage_AC_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [SC_16_High_Stage_AC_kW_Hr] - LAG([SC_16_High_Stage_AC_kW_Hr]) OVER (ORDER BY [Date]) END AS [SC_16_High_Stage_AC],
        CASE WHEN LAG([SC_17_Swing_Standby_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [SC_17_Swing_Standby_kW_Hr] - LAG([SC_17_Swing_Standby_kW_Hr]) OVER (ORDER BY [Date]) END AS [SC_17_Swing_Standby],
        CASE WHEN LAG([SC_11_Booster_IQF3_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [SC_11_Booster_IQF3_kW_Hr] - LAG([SC_11_Booster_IQF3_kW_Hr]) OVER (ORDER BY [Date]) END AS [SC_11_Booster_IQF3],
        CASE WHEN LAG([Auxiliary_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Auxiliary_kW_Hr] - LAG([Auxiliary_kW_Hr]) OVER (ORDER BY [Date]) END AS [Auxiliary]


    FROM [ISMPALI].[dbo].[ut_sus_rw_data_electric_usage_mdb6]
        WHERE [Date] BETWEEN CONVERT(date, GETDATE() - 1 ) AND CONVERT(date, GETDATE() )


) AS Subquery
WHERE NOT EXISTS (
    SELECT 1
FROM [ISMPALI].[dbo].[ut_sus_rpt_electric_usage_mdb6]
WHERE [ut_sus_rpt_electric_usage_mdb6].[Date] = Subquery.[Date]
);
