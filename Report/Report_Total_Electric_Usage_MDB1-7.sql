SELECT 
    mdb1.[ID], 
    mdb1.[Date], 
    mdb1.[MDB1_kW_Hr] As MDB1, 
    mdb2.[MDB2_kW_Hr] As MDB2, 
    mdb3.[MDB3_kW_Hr] As MDB3, 
    mdb4.[MDB4_kW_Hr] As MDB4, 
    mdb5.[MDB5_kW_Hr] As MDB5, 
    mdb6.[MDB6_kW_Hr] As MDB6, 
    mdb7.[MDB7_kW_Hr] As MDB7,
    COALESCE(mdb1.[MDB1_kW_Hr], 0) +
    COALESCE(mdb2.[MDB2_kW_Hr], 0) +
    COALESCE(mdb3.[MDB3_kW_Hr], 0) +
    COALESCE(mdb4.[MDB4_kW_Hr], 0) +
    COALESCE(mdb5.[MDB5_kW_Hr], 0) +
    COALESCE(mdb6.[MDB6_kW_Hr], 0) +
    COALESCE(mdb7.[MDB7_kW_Hr], 0) AS ToTal
FROM 
    [ISMPALI].[dbo].[ut_sus_rw_data_electric_usage_mdb1] mdb1
LEFT JOIN 
    [ISMPALI].[dbo].[ut_sus_rw_data_electric_usage_mdb2] mdb2 ON mdb1.[Date] = mdb2.[Date]
LEFT JOIN 
    [ISMPALI].[dbo].[ut_sus_rw_data_electric_usage_mdb3] mdb3 ON mdb1.[Date] = mdb3.[Date]
LEFT JOIN 
    [ISMPALI].[dbo].[ut_sus_rw_data_electric_usage_mdb4] mdb4 ON mdb1.[Date] = mdb4.[Date]
LEFT JOIN 
    [ISMPALI].[dbo].[ut_sus_rw_data_electric_usage_mdb5] mdb5 ON mdb1.[Date] = mdb5.[Date]
LEFT JOIN 
    [ISMPALI].[dbo].[ut_sus_rw_data_electric_usage_mdb6] mdb6 ON mdb1.[Date] = mdb6.[Date]
LEFT JOIN 
    [ISMPALI].[dbo].[ut_sus_rw_data_electric_usage_mdb7] mdb7 ON mdb1.[Date] = mdb7.[Date]
WHERE 
    mdb1.[Date] BETWEEN '2024-04-13 00:00:00.000' AND '2024-04-19 00:00:00.000'
GROUP BY
    mdb1.[ID], 
    mdb1.[Date], 
    mdb1.[Unit], 
    mdb1.[MDB1_kW_Hr], 
    mdb2.[MDB2_kW_Hr], 
    mdb3.[MDB3_kW_Hr], 
    mdb4.[MDB4_kW_Hr], 
    mdb5.[MDB5_kW_Hr], 
    mdb6.[MDB6_kW_Hr], 
    mdb7.[MDB7_kW_Hr]
ORDER BY 
    mdb1.[Date];












SELECT 
    mdb1.[ID], 
    mdb1.[Date], 
    mdb1.[MDB1_kW_Hr] , 
	CASE WHEN LAG(mdb1.[MDB1_kW_Hr]) OVER (ORDER BY mdb1.[Date]) IS NULL THEN 0 ELSE mdb1.[MDB1_kW_Hr] - LAG(mdb1.[MDB1_kW_Hr]) OVER (ORDER BY mdb1.[Date]) END AS MDB1,

    mdb2.[MDB2_kW_Hr] , 
	CASE WHEN LAG(mdb2.[MDB2_kW_Hr]) OVER (ORDER BY mdb1.[Date]) IS NULL THEN 0 ELSE mdb2.[MDB2_kW_Hr] - LAG(mdb2.[MDB2_kW_Hr]) OVER (ORDER BY mdb1.[Date]) END AS MDB2,

    mdb3.[MDB3_kW_Hr] , 
	CASE WHEN LAG(mdb3.[MDB3_kW_Hr]) OVER (ORDER BY mdb1.[Date]) IS NULL THEN 0 ELSE mdb3.[MDB3_kW_Hr] - LAG(mdb3.[MDB3_kW_Hr]) OVER (ORDER BY mdb1.[Date]) END AS MDB3,

    mdb4.[MDB4_kW_Hr] , 
	CASE WHEN LAG(mdb4.[MDB4_kW_Hr]) OVER (ORDER BY mdb1.[Date]) IS NULL THEN 0 ELSE mdb4.[MDB4_kW_Hr] - LAG(mdb4.[MDB4_kW_Hr]) OVER (ORDER BY mdb1.[Date]) END AS MDB4,

    mdb5.[MDB5_kW_Hr] , 
	CASE WHEN LAG(mdb5.[MDB5_kW_Hr]) OVER (ORDER BY mdb1.[Date]) IS NULL THEN 0 ELSE mdb5.[MDB5_kW_Hr] - LAG(mdb5.[MDB5_kW_Hr]) OVER (ORDER BY mdb1.[Date]) END AS MDB5,

    mdb6.[MDB6_kW_Hr] , 
	CASE WHEN LAG(mdb6.[MDB6_kW_Hr]) OVER (ORDER BY mdb1.[Date]) IS NULL THEN 0 ELSE mdb6.[MDB6_kW_Hr] - LAG(mdb6.[MDB6_kW_Hr]) OVER (ORDER BY mdb1.[Date]) END AS MDB6,

    mdb7.[MDB7_kW_Hr] ,
	CASE WHEN LAG(mdb7.[MDB7_kW_Hr]) OVER (ORDER BY mdb1.[Date]) IS NULL THEN 0 ELSE mdb7.[MDB7_kW_Hr] - LAG(mdb7.[MDB7_kW_Hr]) OVER (ORDER BY mdb1.[Date]) END AS MDB7,


   ISNULL((
   mdb1.[MDB1_kW_Hr] - LAG(mdb1.[MDB1_kW_Hr]) OVER (ORDER BY mdb1.[Date])+
   mdb2.[MDB2_kW_Hr] - LAG(mdb2.[MDB2_kW_Hr]) OVER (ORDER BY mdb1.[Date]) +
   mdb3.[MDB3_kW_Hr] - LAG(mdb3.[MDB3_kW_Hr]) OVER (ORDER BY mdb1.[Date])+
   mdb4.[MDB4_kW_Hr] - LAG(mdb4.[MDB4_kW_Hr]) OVER (ORDER BY mdb1.[Date])+
   mdb5.[MDB5_kW_Hr] - LAG(mdb5.[MDB5_kW_Hr]) OVER (ORDER BY mdb1.[Date])+
   mdb6.[MDB6_kW_Hr] - LAG(mdb6.[MDB6_kW_Hr]) OVER (ORDER BY mdb1.[Date])+
   mdb7.[MDB7_kW_Hr] - LAG(mdb7.[MDB7_kW_Hr]) OVER (ORDER BY mdb1.[Date])
   ), 0) As Total


FROM 
    [ISMPALI].[dbo].[ut_sus_rw_data_electric_usage_mdb1] mdb1
LEFT JOIN 
    [ISMPALI].[dbo].[ut_sus_rw_data_electric_usage_mdb2] mdb2 ON mdb1.[Date] = mdb2.[Date]
LEFT JOIN 
    [ISMPALI].[dbo].[ut_sus_rw_data_electric_usage_mdb3] mdb3 ON mdb1.[Date] = mdb3.[Date]
LEFT JOIN 
    [ISMPALI].[dbo].[ut_sus_rw_data_electric_usage_mdb4] mdb4 ON mdb1.[Date] = mdb4.[Date]
LEFT JOIN 
    [ISMPALI].[dbo].[ut_sus_rw_data_electric_usage_mdb5] mdb5 ON mdb1.[Date] = mdb5.[Date]
LEFT JOIN 
    [ISMPALI].[dbo].[ut_sus_rw_data_electric_usage_mdb6] mdb6 ON mdb1.[Date] = mdb6.[Date]
LEFT JOIN 
    [ISMPALI].[dbo].[ut_sus_rw_data_electric_usage_mdb7] mdb7 ON mdb1.[Date] = mdb7.[Date]
WHERE 
    mdb1.[Date] BETWEEN '2024-04-13 00:00:00.000' AND '2024-04-19 00:00:00.000'
GROUP BY
    mdb1.[ID], 
    mdb1.[Date], 
    mdb1.[Unit], 
    mdb1.[MDB1_kW_Hr], 
    mdb2.[MDB2_kW_Hr], 
    mdb3.[MDB3_kW_Hr], 
    mdb4.[MDB4_kW_Hr], 
    mdb5.[MDB5_kW_Hr], 
    mdb6.[MDB6_kW_Hr], 
    mdb7.[MDB7_kW_Hr]
ORDER BY 
    mdb1.[Date];


