DECLARE @StartTime DATETIME = '2024-06-12 00:00:00.000';
DECLARE @FinishTime DATETIME = '2024-06-13 00:00:00.000';

WITH SubqueryUpdate AS (
    SELECT
        [Date],
        [MDB2],
        [Cold_Water_Pump],
        [Waste_Water_Treatment],
        [Softwater_Pump],
        [Water_Treatment],
        [Lighting_Receptacial_Water_Tank],
        [Softener],
        [Lighting_Receptacial_Solid_West],
        [WWTP_Plant4],
        ROW_NUMBER() OVER (ORDER BY [Date]) AS RowNum
    FROM (
        SELECT
            [Date],
            [Unit],
            [MDB2_kW_Hr],
            [Cold_Water_Pump_kW_Hr],
            [Waste_Water_Treatment_kW_Hr],
            [Softwater_Pump_kW_Hr],
            [Water_Treatment_kW_Hr],
            [Lighting_Receptacial_Water_Tank_kW_Hr],
            [Softener_kW_Hr],
            [Lighting_Receptacial_Solid_West_kW_Hr],
            [WWTP_Plant4_kW_Hr],
            CASE WHEN LAG([MDB2_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [MDB2_kW_Hr] - LAG([MDB2_kW_Hr]) OVER (ORDER BY [Date]) END AS [MDB2],
            CASE WHEN LAG([Cold_Water_Pump_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Cold_Water_Pump_kW_Hr] - LAG([Cold_Water_Pump_kW_Hr]) OVER (ORDER BY [Date]) END AS [Cold_Water_Pump],
            CASE WHEN LAG([Waste_Water_Treatment_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Waste_Water_Treatment_kW_Hr] - LAG([Waste_Water_Treatment_kW_Hr]) OVER (ORDER BY [Date]) END AS [Waste_Water_Treatment],
            CASE WHEN LAG([Softwater_Pump_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Softwater_Pump_kW_Hr] - LAG([Softwater_Pump_kW_Hr]) OVER (ORDER BY [Date]) END AS [Softwater_Pump],
            CASE WHEN LAG([Water_Treatment_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Water_Treatment_kW_Hr] - LAG([Water_Treatment_kW_Hr]) OVER (ORDER BY [Date]) END AS [Water_Treatment],
            CASE WHEN LAG([Lighting_Receptacial_Water_Tank_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Lighting_Receptacial_Water_Tank_kW_Hr] - LAG([Lighting_Receptacial_Water_Tank_kW_Hr]) OVER (ORDER BY [Date]) END AS [Lighting_Receptacial_Water_Tank],
            CASE WHEN LAG([Softener_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Softener_kW_Hr] - LAG([Softener_kW_Hr]) OVER (ORDER BY [Date]) END AS [Softener],
            CASE WHEN LAG([Lighting_Receptacial_Solid_West_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [Lighting_Receptacial_Solid_West_kW_Hr] - LAG([Lighting_Receptacial_Solid_West_kW_Hr]) OVER (ORDER BY [Date]) END AS [Lighting_Receptacial_Solid_West],
            CASE WHEN LAG([WWTP_Plant4_kW_Hr]) OVER (ORDER BY [Date]) IS NULL THEN 0 ELSE [WWTP_Plant4_kW_Hr] - LAG([WWTP_Plant4_kW_Hr]) OVER (ORDER BY [Date]) END AS [WWTP_Plant4]
        FROM [ISMPALI].[dbo].[ut_sus_rw_data_electric_usage_mdb2]
        WHERE [Date] BETWEEN @StartTime AND @FinishTime
    ) AS Subquery
)
UPDATE [ISMPALI].[dbo].[ut_sus_rpt_electric_usage_mdb2]
SET 
    [MDB2] = SubqueryUpdate.[MDB2],
    [Cold_Water_Pump] = SubqueryUpdate.[Cold_Water_Pump],
    [Waste_Water_Treatment] = SubqueryUpdate.[Waste_Water_Treatment],
    [Softwater_Pump] = SubqueryUpdate.[Softwater_Pump],
    [Water_Treatment] = SubqueryUpdate.[Water_Treatment],
    [Lighting_Receptacial_Water_Tank] = SubqueryUpdate.[Lighting_Receptacial_Water_Tank],
    [Softener] = SubqueryUpdate.[Softener],
    [Lighting_Receptacial_Solid_West] = SubqueryUpdate.[Lighting_Receptacial_Solid_West],
    [WWTP_Plant4] = SubqueryUpdate.[WWTP_Plant4]
FROM SubqueryUpdate
WHERE 
    [ut_sus_rpt_electric_usage_mdb2].[Date] = @FinishTime
    AND [ut_sus_rpt_electric_usage_mdb2].[Approve] = 0
    AND SubqueryUpdate.RowNum = 2; -- Update only the second row from the subquery
