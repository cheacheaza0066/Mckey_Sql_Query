INSERT INTO [ISMPALI].[dbo].[ut_sus_rpt_electric_usage_mdb5]
    (
    [Date]
    ,[Unit]
    ,[MDB5]
      ,[Hydrolic]
      ,[Aircom]
      ,[Hot_oil_Boiler]
      ,[Oven_1_2_3]
      ,[Utility_Area]
      ,[Lighting]
      ,[Power_outlet_General_load]
      ,[AC_Process_Area]
      ,[Machinine_L1]
      ,[Machinine_L2]
      ,[Machinine_L3]
      ,[Soft_Water_Booster_Pump]
      ,[PSMCC_3]
    )
SELECT
    [Date]
    ,[Unit]
    ,[MDB5]
      ,[Hydrolic]
      ,[Aircom]
      ,[Hot_oil_Boiler]
      ,[Oven_1_2_3]
      ,[Utility_Area]
      ,[Lighting]
      ,[Power_outlet_General_load]
      ,[AC_Process_Area]
      ,[Machinine_L1]
      ,[Machinine_L2]
      ,[Machinine_L3]
      ,[Soft_Water_Booster_Pump]
      ,[PSMCC_3]
FROM (
    SELECT
        [ID],
        [Date],
        [Unit],
        [MDB5_kW_Hr]
      ,[Hydrolic_kW_Hr]
      ,[Aircom_kW_Hr]
      ,[Hot_oil_Boiler_kW_Hr]
      ,[Oven_1_2_3_kW_Hr]
      ,[Utility_Area_kW_Hr]
      ,[Lighting_kW_Hr]
      ,[Power_outlet_General_load_kW_Hr]
      ,[AC_Process_Area_kW_Hr]
      ,[Machinine_L1_kW_Hr]
      ,[Machinine_L2_kW_Hr]
      ,[Machinine_L3_kW_Hr]
      ,[Soft_Water_Booster_Pump_kW_Hr]
      ,[PSMCC_3_kW_Hr],
	   CASE WHEN LAG([MDB5_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [MDB5_kW_Hr] - LAG([MDB5_kW_Hr]) OVER (ORDER BY [Date]) END AS [MDB5],
	      CASE WHEN LAG([Hydrolic_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Hydrolic_kW_Hr] - LAG([Hydrolic_kW_Hr]) OVER (ORDER BY [Date]) END AS [Hydrolic],
	      CASE WHEN LAG([Aircom_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Aircom_kW_Hr] - LAG([Aircom_kW_Hr]) OVER (ORDER BY [Date]) END AS [Aircom],
	      CASE WHEN LAG([Hot_oil_Boiler_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Hot_oil_Boiler_kW_Hr] - LAG([Hot_oil_Boiler_kW_Hr]) OVER (ORDER BY [Date]) END AS [Hot_oil_Boiler],
	      CASE WHEN LAG([Oven_1_2_3_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Oven_1_2_3_kW_Hr] - LAG([Oven_1_2_3_kW_Hr]) OVER (ORDER BY [Date]) END AS [Oven_1_2_3],
	      CASE WHEN LAG([Utility_Area_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Utility_Area_kW_Hr] - LAG([Utility_Area_kW_Hr]) OVER (ORDER BY [Date]) END AS [Utility_Area],
	      CASE WHEN LAG([Lighting_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Lighting_kW_Hr] - LAG([Lighting_kW_Hr]) OVER (ORDER BY [Date]) END AS [Lighting],
	      CASE WHEN LAG([Power_outlet_General_load_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Power_outlet_General_load_kW_Hr] - LAG([Power_outlet_General_load_kW_Hr]) OVER (ORDER BY [Date]) END AS [Power_outlet_General_load],
	      CASE WHEN LAG([AC_Process_Area_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [AC_Process_Area_kW_Hr] - LAG([AC_Process_Area_kW_Hr]) OVER (ORDER BY [Date]) END AS [AC_Process_Area],
	      CASE WHEN LAG([Machinine_L1_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Machinine_L1_kW_Hr] - LAG([Machinine_L1_kW_Hr]) OVER (ORDER BY [Date]) END AS [Machinine_L1],
	      CASE WHEN LAG([Machinine_L2_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Machinine_L2_kW_Hr] - LAG([Machinine_L2_kW_Hr]) OVER (ORDER BY [Date]) END AS [Machinine_L2],
	      CASE WHEN LAG([Machinine_L3_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Machinine_L3_kW_Hr] - LAG([Machinine_L3_kW_Hr]) OVER (ORDER BY [Date]) END AS [Machinine_L3],
	      CASE WHEN LAG([Soft_Water_Booster_Pump_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Soft_Water_Booster_Pump_kW_Hr] - LAG([Soft_Water_Booster_Pump_kW_Hr]) OVER (ORDER BY [Date]) END AS [Soft_Water_Booster_Pump],
	      CASE WHEN LAG([PSMCC_3_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [PSMCC_3_kW_Hr] - LAG([PSMCC_3_kW_Hr]) OVER (ORDER BY [Date]) END AS [PSMCC_3]

    FROM [ISMPALI].[dbo].[ut_sus_rw_data_electric_usage_mdb5]
        WHERE [Date] BETWEEN CONVERT(date, GETDATE() - 1 ) AND CONVERT(date, GETDATE() )

) AS Subquery
WHERE NOT EXISTS (
    SELECT 1
FROM [ISMPALI].[dbo].[ut_sus_rpt_electric_usage_mdb5]
WHERE [ut_sus_rpt_electric_usage_mdb5].[Date] = Subquery.[Date]
);
