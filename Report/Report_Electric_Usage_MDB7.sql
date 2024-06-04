INSERT INTO [ISMPALI].[dbo].[ut_sus_rpt_electric_usage_mdb7]
    (
    [Date]
    ,[Unit]
      ,[MDB7]
      ,[SC_14_High_Stage_AC]
      ,[SC_15_IQF]
      ,[SC_12_Booster_IQF_4]
      ,[SC_13_Booster_IQF_5]
      ,[SC_18_Office_Air]
      ,[Auxiliary]
    )
SELECT
    [Date]
    ,[Unit]
     ,[MDB7]
      ,[SC_14_High_Stage_AC]
      ,[SC_15_IQF]
      ,[SC_12_Booster_IQF_4]
      ,[SC_13_Booster_IQF_5]
      ,[SC_18_Office_Air]
      ,[Auxiliary]
FROM (
    SELECT
        [ID],
        [Date],
        [Unit],
       [MDB7_kW_Hr]
      ,[SC_14_High_Stage_AC_kW_Hr]
      ,[SC_15_IQF_kW_Hr]
      ,[SC_12_Booster_IQF_4_kW_Hr]
      ,[SC_13_Booster_IQF_5_kW_Hr]
      ,[SC_18_Office_Air_kW_Hr]
      ,[Auxiliary_kW_Hr],

	      CASE WHEN LAG([MDB7_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [MDB7_kW_Hr] - LAG([MDB7_kW_Hr]) OVER (ORDER BY [Date]) END AS [MDB7],
        CASE WHEN LAG([SC_14_High_Stage_AC_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [SC_14_High_Stage_AC_kW_Hr] - LAG([SC_14_High_Stage_AC_kW_Hr]) OVER (ORDER BY [Date]) END AS [SC_14_High_Stage_AC],

        CASE WHEN LAG([SC_15_IQF_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [SC_15_IQF_kW_Hr] - LAG([SC_15_IQF_kW_Hr]) OVER (ORDER BY [Date]) END AS [SC_15_IQF],
        CASE WHEN LAG([SC_12_Booster_IQF_4_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [SC_12_Booster_IQF_4_kW_Hr] - LAG([SC_12_Booster_IQF_4_kW_Hr]) OVER (ORDER BY [Date]) END AS [SC_12_Booster_IQF_4],
        CASE WHEN LAG([SC_13_Booster_IQF_5_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [SC_13_Booster_IQF_5_kW_Hr] - LAG([SC_13_Booster_IQF_5_kW_Hr]) OVER (ORDER BY [Date]) END AS [SC_13_Booster_IQF_5],
        CASE WHEN LAG([SC_18_Office_Air_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [SC_18_Office_Air_kW_Hr] - LAG([SC_18_Office_Air_kW_Hr]) OVER (ORDER BY [Date]) END AS [SC_18_Office_Air],
        CASE WHEN LAG([Auxiliary_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Auxiliary_kW_Hr] - LAG([Auxiliary_kW_Hr]) OVER (ORDER BY [Date]) END AS [Auxiliary]


    FROM [ISMPALI].[dbo].[ut_sus_rw_data_electric_usage_mdb7]
        WHERE [Date] BETWEEN CONVERT(date, GETDATE() - 1 ) AND CONVERT(date, GETDATE() )


) AS Subquery
WHERE NOT EXISTS (
    SELECT 1
FROM [ISMPALI].[dbo].[ut_sus_rpt_electric_usage_mdb7]
WHERE [ut_sus_rpt_electric_usage_mdb7].[Date] = Subquery.[Date]
);
