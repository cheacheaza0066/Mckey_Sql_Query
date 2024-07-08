DECLARE @StartDate DATETIME = '2024-04-12 07:00:00.000';
DECLARE @EndDate DATETIME = '2024-07-12 07:00:00.000';

DECLARE @Const_Per_Unit DECIMAL(10, 2);
DECLARE @Cost_FG_KG DECIMAL(10, 2);
DECLARE @Price_Per_Unit DECIMAL(10, 2);
DECLARE @Avg_Usage_Per_Day DECIMAL(10, 2);


SET @Const_Per_Unit = (SELECT TOP 1 Cost_Per_Unit FROM [ut_sus_rw_data_summary_keyinCost] ORDER BY Date DESC);
SET @Cost_FG_KG = (SELECT TOP 1 Cost_FG_KG FROM [ut_sus_rw_data_summary_keyinCost] ORDER BY Date DESC);
SET @Price_Per_Unit = (SELECT TOP 1 Price_Per_Unit FROM [ut_sus_rw_data_summary_keyinCost] ORDER BY Date DESC);
SET @Avg_Usage_Per_Day = (SELECT TOP 1 Avg_Usage_Per_Day FROM [ut_sus_rw_data_summary_keyinCost] ORDER BY Date DESC);

SELECT 

    'Total Water usage' as Description,

    (SELECT CAST(Sum(wtp.Total_water_PWA_supply_usage) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_total_wtp_wwtp_usage] as wtp
     WHERE Date between @StartDate and @EndDate) as PeriodAccount,

    'M3/Month' as Unit_PeriodAccount

  

UNION ALL




SELECT 

    'Water Apartmeat' as Description,

    (SELECT CAST(Sum(wtp.Total_water_Apartmeat_usage) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_total_wtp_wwtp_usage] as wtp
     WHERE Date between @StartDate and @EndDate) as PeriodAccount,

    'M3/Month' as Unit_PeriodAccount


UNION ALL
SELECT 

    'Total PEA Meter' as Description,

    (SELECT CAST(Sum(mdb.PEA_Meter) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_electric_usage_mdb1] as mdb
     WHERE Date between @StartDate and @EndDate) as PeriodAccount,
    'M3/Month' as Unit_PeriodAccount
    
UNION ALL
SELECT 
    'CNG Usage (m³/Day)' as Description,

    (SELECT CAST(Sum(cng.[Total_CNG_usage]) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_cng_usage] as cng
     WHERE Date between @StartDate and @EndDate) as PeriodAccount,

    'M3/Month' as Unit_PeriodAccount


	 UNION ALL
	 
	 SELECT 
    'CNG Usage (SCM)' as Description,

    (SELECT CAST(Sum(cng.[SCM_CNG_usage]) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_cng_usage] as cng
     WHERE Date between @StartDate and @EndDate) as PeriodAccount,

    'M3/Month' as Unit_PeriodAccount

  UNION ALL
	 
	SELECT 
    'CNG Usage (Hot oil #1-2)' as Description,
    CAST((SELECT SUM(cng.[Hot_oil_01_Usage]) + SUM(cng.[Hot_oil_02_Usage])
          FROM [ISMPALI].[dbo].[ut_sus_rpt_cng_usage] as cng
          WHERE Date BETWEEN @StartDate AND @EndDate) AS INT) as PeriodAccount,
    'M3/Month' as Unit_PeriodAccount
    
 
 UNION ALL
	 
	SELECT 
    'CNG Usage (Hot oil #3-4)' as Description,
    CAST((SELECT SUM(cng.[Hot_oil_03_Usage]) + SUM(cng.[Hot_oil_04_Usage])+ SUM(cng.[Hot_oil_05_Usage])
          FROM [ISMPALI].[dbo].[ut_sus_rpt_cng_usage] as cng
          WHERE Date BETWEEN @StartDate AND @EndDate) AS INT) as PeriodAccount,
    'M3/Month' as Unit_PeriodAccount
    
 UNION ALL
	 
	SELECT 
    'CNG Usage (Boiler #1-2))' as Description,
    CAST((SELECT SUM(cng.[Boiler_01_Usage]) + SUM(cng.[Boiler_02_Usage])
          FROM [ISMPALI].[dbo].[ut_sus_rpt_cng_usage] as cng
          WHERE Date BETWEEN @StartDate AND @EndDate) AS INT) as PeriodAccount,
    'M3/Month' as Unit_PeriodAccount
    
 UNION ALL
	 
	SELECT 
    'CNG Usage (Boiler #3-4))' as Description,
    CAST((SELECT SUM(cng.[Boiler_03_Usage]) + SUM(cng.[Boiler_04_Usage])
          FROM [ISMPALI].[dbo].[ut_sus_rpt_cng_usage] as cng
          WHERE Date BETWEEN @StartDate AND @EndDate) AS INT) as PeriodAccount,
    'M3/Month' as Unit_PeriodAccount
    

  


UNION ALL

SELECT 
    'CO2 usage' as Description,

    (SELECT CAST(Sum(co2.CO2_usage) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_co2_usage] as co2
     WHERE Date between @StartDate and @EndDate) as PeriodAccount,

    'M3/Month' as Unit_PeriodAccount




   