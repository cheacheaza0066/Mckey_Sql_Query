DECLARE @StartDate DATETIME = '2024-06-12 07:00:00.000';
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

    '(M³/Month)' as Unit_PeriodAccount,

    FORMAT(@StartDate, 'dd/MM/yyyy') + ' - ' + FORMAT(@EndDate, 'dd/MM/yyyy') as Period_Date_On_Bill,

    (SELECT CAST(Sum(wtp.Total_water_PWA_supply_usage) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_total_wtp_wwtp_usage] as wtp
     WHERE Date between @StartDate and @EndDate) as Total_Unit_from_Bill,

    '(M³)' as Unit_Onbill,

    (SELECT CAST(Sum(wtp.Total_water_PWA_supply_usage) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_total_wtp_wwtp_usage] as wtp
     WHERE Date between @StartDate and @EndDate) * @Const_Per_Unit as Total_Cost_OnBill,

    @Const_Per_Unit as Const_Per_Unit_Onbill,

	(SELECT CAST(Sum(wtp.Total_water_PWA_supply_usage) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_total_wtp_wwtp_usage] as wtp
     WHERE Date between @StartDate and @EndDate) * @Const_Per_Unit as Cost_By_Period_Account,
	    
	@Cost_FG_KG as Cost_By_Period_FG_KG,

	(SELECT CAST(Sum(wtp.Total_water_PWA_supply_usage) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_total_wtp_wwtp_usage] as wtp
     WHERE Date between @StartDate and @EndDate) * @Const_Per_Unit / @Cost_FG_KG as Cost_By_Period_Cost_FG_KG,

	 @Price_Per_Unit as Estimate_Cost_Price_Per_Unit,

	 @Avg_Usage_Per_Day as Estimate_Cost_Avg_Usage_Per_Day,

	 (SELECT CAST(Sum(wtp.Total_water_PWA_supply_usage) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_total_wtp_wwtp_usage] as wtp
     WHERE Date between @StartDate and @EndDate) * @Avg_Usage_Per_Day as Estimate_Cost_Total_Cost



UNION ALL




SELECT 

    'Total Water Treatment volumn' as Description,

    (SELECT CAST(Sum(wtp.Total_water_PWA_supply_usage) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_total_wtp_wwtp_usage] as wtp
     WHERE Date between @StartDate and @EndDate) as PeriodAccount,

    '(M³/Month)' as Unit_PeriodAccount,

    FORMAT(@StartDate, 'dd/MM/yyyy') + ' - ' + FORMAT(@EndDate, 'dd/MM/yyyy') as Period_Date_On_Bill,

    (SELECT CAST(Sum(wtp.Total_water_PWA_supply_usage) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_total_wtp_wwtp_usage] as wtp
     WHERE Date between @StartDate and @EndDate) as Total_Unit_from_Bill,

    '(M³)' as Unit_Onbill,

    (SELECT CAST(Sum(wtp.Total_water_PWA_supply_usage) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_total_wtp_wwtp_usage] as wtp
     WHERE Date between @StartDate and @EndDate) * @Const_Per_Unit as Total_Cost_OnBill,

    @Const_Per_Unit as Const_Per_Unit_Onbill,

	(SELECT CAST(Sum(wtp.Total_water_PWA_supply_usage) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_total_wtp_wwtp_usage] as wtp
     WHERE Date between @StartDate and @EndDate) * @Const_Per_Unit as Cost_By_Period_Account,
	    
	@Cost_FG_KG as Cost_By_Period_FG_KG,

	(SELECT CAST(Sum(wtp.Total_water_PWA_supply_usage) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_total_wtp_wwtp_usage] as wtp
     WHERE Date between @StartDate and @EndDate) * @Const_Per_Unit / @Cost_FG_KG as Cost_By_Period_Cost_FG_KG,

	 @Price_Per_Unit as Estimate_Cost_Price_Per_Unit,

	 @Avg_Usage_Per_Day as Estimate_Cost_Avg_Usage_Per_Day,

	 (SELECT CAST(Sum(wtp.Total_water_PWA_supply_usage) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_total_wtp_wwtp_usage] as wtp
     WHERE Date between @StartDate and @EndDate) * @Avg_Usage_Per_Day as Estimate_Cost_Total_Cost



UNION ALL




SELECT 

    'Total Waste water volumn' as Description,

    (SELECT CAST(Sum(wtp.Total_waste_water) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_total_wtp_wwtp_usage] as wtp
     WHERE Date between @StartDate and @EndDate) as PeriodAccount,

    '(M³/Month)' as Unit_PeriodAccount,

    FORMAT(@StartDate, 'dd/MM/yyyy') + ' - ' + FORMAT(@EndDate, 'dd/MM/yyyy') as Period_Date_On_Bill,

    (SELECT CAST(Sum(wtp.Total_waste_water) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_total_wtp_wwtp_usage] as wtp
     WHERE Date between @StartDate and @EndDate) as Total_Unit_from_Bill,

    '(M³)' as Unit_Onbill,

    (SELECT CAST(Sum(wtp.Total_waste_water) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_total_wtp_wwtp_usage] as wtp
     WHERE Date between @StartDate and @EndDate) * @Const_Per_Unit as Total_Cost_OnBill,

    @Const_Per_Unit as Const_Per_Unit_Onbill,

	(SELECT CAST(Sum(wtp.Total_waste_water) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_total_wtp_wwtp_usage] as wtp
     WHERE Date between @StartDate and @EndDate) * @Const_Per_Unit as Cost_By_Period_Account,
	    
	@Cost_FG_KG as Cost_By_Period_FG_KG,

	(SELECT CAST(Sum(wtp.Total_waste_water) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_total_wtp_wwtp_usage] as wtp
     WHERE Date between @StartDate and @EndDate) * @Const_Per_Unit / @Cost_FG_KG as Cost_By_Period_Cost_FG_KG,

	 @Price_Per_Unit as Estimate_Cost_Price_Per_Unit,

	 @Avg_Usage_Per_Day as Estimate_Cost_Avg_Usage_Per_Day,

	 (SELECT CAST(Sum(wtp.Total_waste_water) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_total_wtp_wwtp_usage] as wtp
     WHERE Date between @StartDate and @EndDate) * @Avg_Usage_Per_Day as Estimate_Cost_Total_Cost



UNION ALL




SELECT 

    'Total PEA Meter' as Description,

    (SELECT CAST(Sum(mdb.PEA_Meter) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_electric_usage_mdb1] as mdb
     WHERE Date between @StartDate and @EndDate) as PeriodAccount,

    '(M³/Month)' as Unit_PeriodAccount,

    FORMAT(@StartDate, 'dd/MM/yyyy') + ' - ' + FORMAT(@EndDate, 'dd/MM/yyyy') as Period_Date_On_Bill,

    (SELECT CAST(Sum(mdb.PEA_Meter) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_electric_usage_mdb1] as mdb
     WHERE Date between @StartDate and @EndDate) as Total_Unit_from_Bill,

    '(M³)' as Unit_Onbill,

    (SELECT CAST(Sum(mdb.PEA_Meter) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_electric_usage_mdb1] as mdb
     WHERE Date between @StartDate and @EndDate) * @Const_Per_Unit as Total_Cost_OnBill,

    @Const_Per_Unit as Const_Per_Unit_Onbill,

	(SELECT CAST(Sum(mdb.PEA_Meter) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_electric_usage_mdb1] as mdb
     WHERE Date between @StartDate and @EndDate) * @Const_Per_Unit as Cost_By_Period_Account,
	    
	@Cost_FG_KG as Cost_By_Period_FG_KG,

	(SELECT CAST(Sum(mdb.PEA_Meter) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_electric_usage_mdb1] as mdb
     WHERE Date between @StartDate and @EndDate) * @Const_Per_Unit / @Cost_FG_KG as Cost_By_Period_Cost_FG_KG,

	 @Price_Per_Unit as Estimate_Cost_Price_Per_Unit,

	 @Avg_Usage_Per_Day as Estimate_Cost_Avg_Usage_Per_Day,

	 (SELECT CAST(Sum(mdb.[PEA_Meter]) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_electric_usage_mdb1] as mdb
     WHERE Date between @StartDate and @EndDate) * @Avg_Usage_Per_Day as Estimate_Cost_Total_Cost



UNION ALL







SELECT 
    'CNG Usage' as Description,

    (SELECT CAST(Sum(cng.[SCM_CNG_usage]) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_cng_usage] as cng
     WHERE Date between @StartDate and @EndDate) as PeriodAccount,

    '(M³/Month)' as Unit_PeriodAccount,

    FORMAT(@StartDate, 'dd/MM/yyyy') + ' - ' + FORMAT(@EndDate, 'dd/MM/yyyy') as Period_Date_On_Bill,

    (SELECT CAST(Sum(cng.[SCM_CNG_usage]) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_cng_usage] as cng
     WHERE Date between @StartDate and @EndDate) as Total_Unit_from_Bill,

    '(M³)' as Unit_Onbill,

    (SELECT CAST(Sum(cng.[SCM_CNG_usage]) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_cng_usage] as cng
     WHERE Date between @StartDate and @EndDate) * @Const_Per_Unit as Total_Cost_OnBill,

    @Const_Per_Unit as Const_Per_Unit_Onbill,

	(SELECT CAST(Sum(cng.[SCM_CNG_usage]) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_cng_usage] as cng
     WHERE Date between @StartDate and @EndDate) * @Const_Per_Unit as Cost_By_Period_Account,
	 	
		@Cost_FG_KG as Cost_By_Period_FG_KG,

(SELECT CAST(Sum(cng.[SCM_CNG_usage]) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_cng_usage] as cng
     WHERE Date between @StartDate and @EndDate) * @Const_Per_Unit /@Cost_FG_KG as Cost_By_Period_Cost_FG_KG,


	 	 @Price_Per_Unit as Estimate_Cost_Price_Per_Unit,

		 	 @Avg_Usage_Per_Day as Estimate_Cost_Avg_Usage_Per_Day,

			(SELECT CAST(Sum(cng.[SCM_CNG_usage]) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_cng_usage] as cng
     WHERE Date between @StartDate and @EndDate) * @Price_Per_Unit as Estimate_Cost_Total_Cost



	 UNION ALL







SELECT 
    'CO2 usage' as Description,

    (SELECT CAST(Sum(co2.CO2_usage) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_co2_usage] as co2
     WHERE Date between @StartDate and @EndDate) as PeriodAccount,

    '(M³/Month)' as Unit_PeriodAccount,

    FORMAT(@StartDate, 'dd/MM/yyyy') + ' - ' + FORMAT(@EndDate, 'dd/MM/yyyy') as Period_Date_On_Bill,

    (SELECT CAST(Sum(co2.CO2_usage) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_co2_usage] as co2
     WHERE Date between @StartDate and @EndDate) as Total_Unit_from_Bill,

    '(M³)' as Unit_Onbill,

    (SELECT CAST(Sum(co2.CO2_usage) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_co2_usage] as co2
     WHERE Date between @StartDate and @EndDate) * @Const_Per_Unit as Total_Cost_OnBill,

    @Const_Per_Unit as Const_Per_Unit_Onbill,

	(SELECT CAST(Sum(co2.CO2_usage) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_co2_usage] as co2
     WHERE Date between @StartDate and @EndDate) * @Const_Per_Unit as Cost_By_Period_Account,
	 	
		@Cost_FG_KG as Cost_By_Period_FG_KG,

(SELECT CAST(Sum(co2.CO2_usage) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_co2_usage] as co2
     WHERE Date between @StartDate and @EndDate) * @Const_Per_Unit /@Cost_FG_KG as Cost_By_Period_Cost_FG_KG,


	 	 @Price_Per_Unit as Estimate_Cost_Price_Per_Unit,

		 	 @Avg_Usage_Per_Day as Estimate_Cost_Avg_Usage_Per_Day,

			(SELECT CAST(Sum(co2.CO2_usage) AS INT)
     FROM [ISMPALI].[dbo].[ut_sus_rpt_co2_usage] as co2
     WHERE Date between @StartDate and @EndDate) * @Price_Per_Unit as Estimate_Cost_Total_Cost


