use ids14db;
SET SQL_SAFE_UPDATES = 0;

#Display the full chart
select *
from child_mortality;

#Display all rows with a blank (0) value
select *
from child_mortality
where `Under-Five mortality rate` = 0
OR `Infant mortality rate` = 0
OR `Neonatal mortality rate` = 0;

#All three numeric columns have missing rows, avgs need to be done for all 
select @UnderFiveAvg := avg(`Under-Five mortality rate`) from child_mortality;
select @InfantAvg := avg(`Infant mortality rate`) from child_mortality;
select @NeoAvg := avg(`Neonatal mortality rate`) from child_mortality;

#Update first col
update child_mortality
set `Under-Five mortality rate` = @UnderFiveAvg 
where `Under-Five mortality rate` = 0;

#Update second col
update child_mortality
set `Infant mortality rate` = @InfantAvg
where `Infant mortality rate` = 0;

#Update third col
update child_mortality
set `Neonatal mortality rate` = @NeoAvg
where `Neonatal mortality rate` = 0;

#Display result
select *
from child_mortality;

#Display the year with the max number of infant mortalities
select `Year` as "Max number of infant mortalities"
from child_mortality
where `Infant mortality rate` = (select max(`Infant mortality rate`) from child_mortality);

#Display the year with the min number of infant mortalities
select `Year` as "Min number of infant mortalities"
from child_mortality
where `Infant mortality rate` = (select min(`Infant mortality rate`) from child_mortality);

#Display the number of years the neonatal rate was above average
select `Year` as "Years the neonatal rate was above average"
from child_mortality
where `Neonatal mortality rate` > (select avg(`Neonatal mortality rate`) from child_mortality);

#Display the data sorted by infant mortality rate descinding
select * 
from child_mortality
order by `Infant mortality rate` desc;

#Display the numerical info for the first col
select min(`Under-Five mortality rate`), max(`Under-five mortality rate`),
avg(`Under-Five mortality rate`), variance(`Under-Five mortality rate`), 
std(`Under-Five mortality rate`)
from child_mortality;

#Display the numerical info for the second col
select min(`Infant mortality rate`), max(`Infant mortality rate`),
avg(`Infant mortality rate`), variance(`Infant mortality rate`),
std(`Infant mortality rate`)
from child_mortality;

#Display the numerical info for the third col
select min(`Neonatal mortality rate`), max(`Neonatal mortality rate`),
avg(`Neonatal mortality rate`), variance(`Neonatal mortality rate`),
std(`Neonatal mortality rate`)
from child_mortality;

#Add new column to the child mortality table
alter table child_mortality
add column `Above-Five Mortality Rate` float after `Neonatal mortality rate`;

#Show the new column has been added
select *
from child_mortality;

update child_mortality
set `Above-Five Mortality Rate` = 100 - `Under-Five mortality rate`;

select *
from child_mortality;

