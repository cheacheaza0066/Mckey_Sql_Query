INSERT INTO [Sustainability].[dbo].[Report_Electric_Usage_MDB2]
    (
    [Date]
    ,[Unit]
    ,[MDB2]
    ,[Cold_Water_Pump]
    ,[Waste_Water_Treatment]
    ,[Softwater_Pump]
    ,[Water_Treatment]
    ,[Lighting_Receptacial_Water_Tank]
    ,[Softener]
    ,[Lighting_Receptacial_Solid_West]
    ,[WWTP_Plant4]
    )
SELECT
    [Date]
    , [Unit]
    , [MDB2]
      , [Cold_Water_Pump]
      , [Waste_Water_Treatment]
      , [Softwater_Pump]
      , [Water_Treatment]
      , [Lighting_Receptacial_Water_Tank]
      , [Softener]
      , [Lighting_Receptacial_Solid_West]
      , [WWTP_Plant4]
FROM (
    SELECT
        [Date],
        [Unit],
        [MDB2_kW_Hr]
      ,[Cold_Water_Pump_kW_Hr]
      ,[Waste_Water_Treatment_kW_Hr]
      ,[Softwater_Pump_kW_Hr]
      ,[Water_Treatment_kW_Hr]
      ,[Lighting_Receptacial_Water_Tank_kW_Hr]
      ,[Softener_kW_Hr]
      ,[Lighting_Receptacial_Solid_West_kW_Hr]
      ,[WWTP_Plant4_kW_Hr],
        CASE WHEN LAG([MDB2_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [MDB2_kW_Hr] - LAG([MDB2_kW_Hr]) OVER (ORDER BY [Date]) END AS [MDB2],
        CASE WHEN LAG([Cold_Water_Pump_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Cold_Water_Pump_kW_Hr] - LAG([Cold_Water_Pump_kW_Hr]) OVER (ORDER BY [Date]) END AS [Cold_Water_Pump],
        CASE WHEN LAG([Waste_Water_Treatment_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Waste_Water_Treatment_kW_Hr] - LAG([Waste_Water_Treatment_kW_Hr]) OVER (ORDER BY [Date]) END AS [Waste_Water_Treatment],
        CASE WHEN LAG([Softwater_Pump_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Softwater_Pump_kW_Hr] - LAG([Softwater_Pump_kW_Hr]) OVER (ORDER BY [Date]) END AS [Softwater_Pump],
        CASE WHEN LAG([Water_Treatment_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Water_Treatment_kW_Hr] - LAG([Water_Treatment_kW_Hr]) OVER (ORDER BY [Date]) END AS [Water_Treatment],
        CASE WHEN LAG([Lighting_Receptacial_Water_Tank_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Lighting_Receptacial_Water_Tank_kW_Hr] - LAG([Lighting_Receptacial_Water_Tank_kW_Hr]) OVER (ORDER BY [Date]) END AS [Lighting_Receptacial_Water_Tank],
        CASE WHEN LAG([Softener_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Softener_kW_Hr] - LAG([Softener_kW_Hr]) OVER (ORDER BY [Date]) END AS [Softener],
        CASE WHEN LAG([Lighting_Receptacial_Solid_West_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Lighting_Receptacial_Solid_West_kW_Hr] - LAG([Lighting_Receptacial_Solid_West_kW_Hr]) OVER (ORDER BY [Date]) END AS [Lighting_Receptacial_Solid_West],
        CASE WHEN LAG([WWTP_Plant4_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [WWTP_Plant4_kW_Hr] - LAG([WWTP_Plant4_kW_Hr]) OVER (ORDER BY [Date]) END AS [WWTP_Plant4]
       
    FROM [Sustainability].[dbo].[RawData_Electric_Usage_MDB2]
) AS Subquery
WHERE NOT EXISTS (
    SELECT 1
FROM [Sustainability].[dbo].[Report_Electric_Usage_MDB2]
WHERE [Report_Electric_Usage_MDB2].[Date] = Subquery.[Date]
);
