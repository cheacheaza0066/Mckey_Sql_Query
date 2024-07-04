DECLARE @StartDate DATETIME = '2024-06-12 07:00:00.000';
DECLARE @EndDate DATETIME = '2024-07-12 07:00:00.000';

SELECT 
    (SELECT CAST(Sum(wtp.Total_water_PWA_supply_usage) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_total_wtp_wwtp_usage] as wtp
     WHERE Date between @StartDate and @EndDate) as Total_Water_usage,
   -- 'M³/Month' as Total_Water_usage_Unit,

	(SELECT CAST(Sum(wtp.Total_water_PWA_supply_usage) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_total_wtp_wwtp_usage] as wtp
     WHERE Date between @StartDate and @EndDate) as Total_Water_Treatment_volumn,

	 (SELECT CAST(Sum(wtp.Total_waste_water) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_total_wtp_wwtp_usage] as wtp
     WHERE Date between @StartDate and @EndDate) as Total_Waste_Water_volumn,

	  (SELECT CAST(Sum(mdb1.PEA_Meter) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_electric_usage_mdb1] as mdb1
     WHERE Date between @StartDate and @EndDate) as Total_PEA_Meter,

    
    (SELECT CAST(Sum(cng.[SCM_CNG_usage]) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_cng_usage] as cng
     WHERE Date between @StartDate and @EndDate) as CNG_Usage_Run_A_Run_B_Meter,
	 
	 (SELECT CAST(Sum(co2.[CO2_usage]) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_co2_usage] as co2
     WHERE Date between @StartDate and @EndDate) as CO2_usage