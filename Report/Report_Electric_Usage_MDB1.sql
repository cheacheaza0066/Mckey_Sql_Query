INSERT INTO [ISMPALI].[dbo].[ut_sus_rpt_electric_usage_mdb1]
    (
    [Date]
    ,[Unit]
    ,[PEA_Meter]
    ,[MDB1]
    ,[Essential_Load]
    ,[MC_Line1_Fryer]
    ,[MC_Line2_Fryer]
    ,[Cooking_Oil_Pump]
    ,[Air_Compressor_2_3]
    ,[Steam_Boiler]
    ,[Hot_Oil]
    ,[QA_Test_Kitchen]
    ,[Water_Pump]
    ,[Receptical]
    ,[CNG_Station]
    ,[Oven_IQF_Line1]
    ,[Oven_IQF_Line2]
    ,[Hydralics]
    ,[ELEVATION]
    ,[Air_Compressor_1]
    ,[Lighting_Factory]
    ,[Jocky_Pump]
    ,[Work_Shop_Sprae_Part]
    ,[Office_Plant3]
    )
SELECT
    [Date]
    ,[Unit]
    ,[PEA_Meter]
    ,[MDB1]
    ,[Essential_Load]
    ,[MC_Line1_Fryer]
    ,[MC_Line2_Fryer]
    ,[Cooking_Oil_Pump]
    ,[Air_Compressor_2_3]
    ,[Steam_Boiler]
    ,[Hot_Oil]
    ,[QA_Test_Kitchen]
    ,[Water_Pump]
    ,[Receptical]
    ,[CNG_Station]
    ,[Oven_IQF_Line1]
    ,[Oven_IQF_Line2]
    ,[Hydralics]
    ,[ELEVATION]
    ,[Air_Compressor_1]
    ,[Lighting_Factory]
    ,[Jocky_Pump]
    ,[Work_Shop_Sprae_Part]
    ,[Office_Plant3]
FROM (
    SELECT
        [Date],
        [Unit],
        [PEA_Meter],
        [MDB1_kW_Hr],
        [Essential_Load_kW_Hr],
        [MC_Line1_Fryer_kW_Hr],
        [MC_Line2_Fryer_kW_Hr],
        [Cooking_Oil_Pump_kW_Hr],
        [Air_Compressor_2_3_kW_Hr],
        [Steam_Boiler_kW_Hr],
        [Hot_Oil_kW_Hr],
        [QA_Test_Kitchen_kW_Hr],
        [Water_Pump_kW_Hr],
        [Receptical_kW_Hr],
        [CNG_Station_kW_Hr],
        [Oven_IQF_Line1_kW_Hr],
        [Oven_IQF_Line2_kW_Hr],
        [Hydralics_kW_Hr],
        [ELEVATION_kW_Hr],
        [Air_Compressor_1_kW_Hr],
        [Lighting_Factory_kW_Hr],
        [Jocky_Pump_kW_Hr],
        [Work_Shop_Sprae_Part_kW_Hr],
        [Office_Plant3_kW_Hr],
        CASE WHEN LAG([MDB1_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [MDB1_kW_Hr] - LAG([MDB1_kW_Hr]) OVER (ORDER BY [Date]) END AS [MDB1],
        CASE WHEN LAG([Essential_Load_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Essential_Load_kW_Hr] - LAG([Essential_Load_kW_Hr]) OVER (ORDER BY [Date]) END AS [Essential_Load],
        CASE WHEN LAG([MC_Line1_Fryer_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [MC_Line1_Fryer_kW_Hr] - LAG([MC_Line1_Fryer_kW_Hr]) OVER (ORDER BY [Date]) END AS [MC_Line1_Fryer],
        CASE WHEN LAG([MC_Line2_Fryer_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [MC_Line2_Fryer_kW_Hr] - LAG([MC_Line2_Fryer_kW_Hr]) OVER (ORDER BY [Date]) END AS [MC_Line2_Fryer],
        CASE WHEN LAG([Cooking_Oil_Pump_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Cooking_Oil_Pump_kW_Hr] - LAG([Cooking_Oil_Pump_kW_Hr]) OVER (ORDER BY [Date]) END AS [Cooking_Oil_Pump],
        CASE WHEN LAG([Air_Compressor_2_3_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Air_Compressor_2_3_kW_Hr] - LAG([Air_Compressor_2_3_kW_Hr]) OVER (ORDER BY [Date]) END AS [Air_Compressor_2_3],
        CASE WHEN LAG([Steam_Boiler_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Steam_Boiler_kW_Hr] - LAG([Steam_Boiler_kW_Hr]) OVER (ORDER BY [Date]) END AS [Steam_Boiler],
        CASE WHEN LAG([Hot_Oil_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Hot_Oil_kW_Hr] - LAG([Hot_Oil_kW_Hr]) OVER (ORDER BY [Date]) END AS [Hot_Oil],
        CASE WHEN LAG([QA_Test_Kitchen_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [QA_Test_Kitchen_kW_Hr] - LAG([QA_Test_Kitchen_kW_Hr]) OVER (ORDER BY [Date]) END AS [QA_Test_Kitchen],
        CASE WHEN LAG([Water_Pump_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Water_Pump_kW_Hr] - LAG([Water_Pump_kW_Hr]) OVER (ORDER BY [Date]) END AS [Water_Pump],
        CASE WHEN LAG([Receptical_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Receptical_kW_Hr] - LAG([Receptical_kW_Hr]) OVER (ORDER BY [Date]) END AS [Receptical],
        CASE WHEN LAG([CNG_Station_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [CNG_Station_kW_Hr] - LAG([CNG_Station_kW_Hr]) OVER (ORDER BY [Date]) END AS [CNG_Station],
        CASE WHEN LAG([Oven_IQF_Line1_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Oven_IQF_Line1_kW_Hr] - LAG([Oven_IQF_Line1_kW_Hr]) OVER (ORDER BY [Date]) END AS [Oven_IQF_Line1],
        CASE WHEN LAG([Oven_IQF_Line2_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Oven_IQF_Line2_kW_Hr] - LAG([Oven_IQF_Line2_kW_Hr]) OVER (ORDER BY [Date]) END AS [Oven_IQF_Line2],
        CASE WHEN LAG([Hydralics_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Hydralics_kW_Hr] - LAG([Hydralics_kW_Hr]) OVER (ORDER BY [Date]) END AS [Hydralics],
        CASE WHEN LAG([ELEVATION_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [ELEVATION_kW_Hr] - LAG([ELEVATION_kW_Hr]) OVER (ORDER BY [Date]) END AS [ELEVATION],
        CASE WHEN LAG([Air_Compressor_1_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Air_Compressor_1_kW_Hr] - LAG([Air_Compressor_1_kW_Hr]) OVER (ORDER BY [Date]) END AS [Air_Compressor_1],
        CASE WHEN LAG([Lighting_Factory_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Lighting_Factory_kW_Hr] - LAG([Lighting_Factory_kW_Hr]) OVER (ORDER BY [Date]) END AS [Lighting_Factory],
        CASE WHEN LAG([Jocky_Pump_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Jocky_Pump_kW_Hr] - LAG([Jocky_Pump_kW_Hr]) OVER (ORDER BY [Date]) END AS [Jocky_Pump],
        CASE WHEN LAG([Work_Shop_Sprae_Part_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Work_Shop_Sprae_Part_kW_Hr] - LAG([Work_Shop_Sprae_Part_kW_Hr]) OVER (ORDER BY [Date]) END AS [Work_Shop_Sprae_Part],
        CASE WHEN LAG([Office_Plant3_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Office_Plant3_kW_Hr] - LAG([Office_Plant3_kW_Hr]) OVER (ORDER BY [Date]) END AS [Office_Plant3]
    FROM [ISMPALI].[dbo].[ut_sus_rw_data_electric_usage_mdb1]
) AS Subquery
WHERE NOT EXISTS (
    SELECT 1
FROM [ISMPALI].[dbo].[ut_sus_rpt_electric_usage_mdb1]
WHERE [ut_sus_rpt_electric_usage_mdb1].[Date] = Subquery.[Date]
);
