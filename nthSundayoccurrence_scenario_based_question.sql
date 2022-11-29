-- Write a Query to provide the date for nth occurence of Sunday in future from given date
--datepart
--Sunday-1
--Monday-2
--Tuesday-3
--Wednesday-4
--Thursday-5
--Friday-6
--Saturday-7

declare @today_date date;
declare @n int;
set @today_date = '2022-12-04' -- Sunday
set @n = 3;

SELECT dateadd(week, @n-1,dateadd(day,8 - datepart(weekday, @today_date),@today_date))