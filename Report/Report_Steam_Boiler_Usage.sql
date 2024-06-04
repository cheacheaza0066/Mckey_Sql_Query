insert into [Test].[dbo].[Report_Steam_Boiler_Usage] 
	  ([Date]
      ,[Unit]
      ,[Water_usage_Boiler_01]
      ,[Water_usage_Boiler_02]
      ,[Water_usage_Boiler_03]
      ,[Water_usage_Boiler_04]
	  ,[Total_usage_Boiler_01_02]
      ,[Total_usage_Boiler_03_04])
select [Date]
      ,[Unit] 
      ,[Water_usage_Boiler_01] 
      ,[Water_usage_Boiler_02]
      ,[Water_usage_Boiler_03]
      ,[Water_usage_Boiler_04]
      ,[Total_usage_Boiler_01_02]
      ,[Total_usage_Boiler_03_04]
from(select 
	   [Date]
      ,[Unit]
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
	  from [Test].[dbo].[RawData_Steam_Boiler_Usage]    WHERE [Date] BETWEEN CONVERT(date, GETDATE() - 1 ) AND CONVERT(date, GETDATE() )
)
        
         as Subquery
        
	  where not exists (SELECT 1
FROM [Test].[dbo].[Report_Steam_Boiler_Usage] 
WHERE [Test].[dbo].[Report_Steam_Boiler_Usage] .[Date] = Subquery.[Date]
);