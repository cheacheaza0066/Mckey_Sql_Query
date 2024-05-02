select [Date]
      ,[Area]
      ,[Machine]
      ,[Start]
      ,[Stop]
from(select 
	   [Date]
      ,[Area]
      ,[Machine]
      ,[Start]
      ,[Stop] 
FROM [Test].[dbo].[RawData_Start_Stop_Hot_oil_Boiler]) as Subquery