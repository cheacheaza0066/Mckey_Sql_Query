DECLARE @StartTime DATETIME = '2024-03-12 00:00:00.000';
DECLARE @FinishTime DATETIME = '2024-05-12 00:00:00.000';

UPDATE [ISMPALI].[dbo].[ut_sus_rpt_steam_boiler_usage]
SET 
       [Water_usage_Boiler_01] = SubqueryUpdate.[Water_usage_Boiler_01]
      ,[Water_usage_Boiler_02] = SubqueryUpdate.[Water_usage_Boiler_02]
      ,[Water_usage_Boiler_03] = SubqueryUpdate.[Water_usage_Boiler_03]
      ,[Water_usage_Boiler_04] = SubqueryUpdate.[Water_usage_Boiler_04]
	  ,[Total_usage_Boiler_01_02] = SubqueryUpdate.[Total_usage_Boiler_01_02]
      ,[Total_usage_Boiler_03_04] = SubqueryUpdate.[Total_usage_Boiler_03_04]
FROM(
    SELECT
       [Date]
      ,[Water_usage_Boiler_01] 
      ,[Water_usage_Boiler_02]
      ,[Water_usage_Boiler_03]
      ,[Water_usage_Boiler_04]
      ,[Total_usage_Boiler_01_02]
      ,[Total_usage_Boiler_03_04]
FROM (
    SELECT
	   [Date]
      ,[Meters_boiler_01]
      ,[Meters_boiler_02]
      ,[Meters_boiler_03]
      ,[Meters_boiler_04]
	  ,case when LEAD([Meters_boiler_01]) over (order by [Date]) - [Meters_boiler_01] is null then 0 else LEAD([Meters_boiler_01]) over (order by [Date]) - [Meters_boiler_01] END as [Water_usage_Boiler_01]
	  ,case when LEAD([Meters_boiler_02]) over (order by [Date]) - [Meters_boiler_02] is null then 0 else LEAD([Meters_boiler_02]) over (order by [Date]) - [Meters_boiler_02] END as [Water_usage_Boiler_02]
	  ,case when LEAD([Meters_boiler_03]) over (order by [Date]) - [Meters_boiler_03] is null then 0 else LEAD([Meters_boiler_03]) over (order by [Date]) - [Meters_boiler_03] END as [Water_usage_Boiler_03]
	  ,case when LEAD([Meters_boiler_04]) over (order by [Date]) - [Meters_boiler_04] is null then 0 else LEAD([Meters_boiler_04]) over (order by [Date]) - [Meters_boiler_04] END as [Water_usage_Boiler_04]
	  ,case when (Lead([Meters_boiler_01]) over (order by [Date]) - [Meters_boiler_01]) + (Lead([Meters_boiler_02]) over (order by [Date]) - [Meters_boiler_02]) is null then 0 else (Lead([Meters_boiler_01]) over (order by [Date]) - [Meters_boiler_01]) + (Lead([Meters_boiler_02]) over (order by [Date]) - [Meters_boiler_02]) END as [Total_usage_Boiler_01_02]
	  ,case when (Lead([Meters_boiler_03]) over (order by [Date]) - [Meters_boiler_03]) + (Lead([Meters_boiler_04]) over (order by [Date]) - [Meters_boiler_04]) is null then 0 else (Lead([Meters_boiler_03]) over (order by [Date]) - [Meters_boiler_03]) + (Lead([Meters_boiler_04]) over (order by [Date]) - [Meters_boiler_04]) END as [Total_usage_Boiler_03_04]
	  from [Test].[dbo].[ut_sus_rw_data_steam_boiler_usage]
        WHERE [Date] BETWEEN @StartTime AND @FinishTime
    ) AS Subquery
) AS SubqueryUpdate
WHERE
    [ISMPALI].[dbo].[ut_sus_rpt_steam_boiler_usage].[Date] = SubqueryUpdate.[Date]
    AND [ISMPALI].[dbo].[ut_sus_rpt_steam_boiler_usage].Approve = 0;
