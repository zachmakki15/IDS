use ids14db;
select * from Life_Expectancy;
SET SQL_SAFE_UPDATES = 0;

#Display all rows with population 0
select *
from Life_Expectancy
where Population = 0;

#1) Delete all rows with population size 0
delete from Life_Expectancy
where Population = 0;

#Display all rows where any numeric attribute is 0
select * 
from Life_Expectancy
where Year = 0 or
Life_Expectancy = 0 or
Adult_Mortality = 0 or
Alcohol = 0 or
Percentage_Expenditure = 0 or
BMI = 0 or
Total_Expenditure = 0 or
GDP = 0 or
Schooling = 0;

#The results show that all numeric attributes have at least one 0
#To start cleaning the data all rows where the Life_Expectancy is 0 will be
#dropped from the dataset, this is because in this dataset Life_Expectancy is the
#target variable, so filling it in with a mean could led to incorrect model results
delete From Life_Expectancy
where Life_Expectancy = 0;

#Now the the mean will be calculated for each of the remaining numeric columns
select @AM := avg(Adult_Mortality),
@Alc := avg(Alcohol),
@PE := avg(Percentage_Expenditure),
@BMI := avg(BMI),
@TE := avg(Total_Expenditure),
@GDP := avg(GDP),
@SCH := avg(Schooling)
from Life_Expectancy;

#Update each numeric column changing all 0 values to the columns mean
update Life_Expectancy
set Adult_Mortality = @AM
where Adult_Mortality = 0 or Adult_Mortality is null;

update Life_Expectancy
set Alcohol = @Alc
where Alcohol = 0 or Alcohol is null;

update Life_Expectancy
set Percentage_Expenditure = @PE
where Percentage_Expenditure = 0 or Percentage_Expenditure is null;

update Life_Expectancy
set BMI = @BMI
where BMI = 0 or BMI is null;

update Life_Expectancy
set Total_Expenditure = @TE
where Total_Expenditure = 0 or Total_Expenditure is null;

update Life_Expectancy
set GDP = @GDP
where GDP = 0 or GDP is null;

update Life_Expectancy
set Schooling = @SCH
where Schooling = 0 or Schooling is null;

#2) Display count of countries after data cleaning
select count(Country)
from Life_Expectancy;

#3) List of countries w/highest & lowest average mortality rates (2010-2015)
#Highest
select Country, avg(Adult_Mortality)
from Life_Expectancy
where Year >= 2010 AND Year <= 2015
group by Country
order by avg(Adult_Mortality) desc;

#Lowest
select Country, avg(Adult_Mortality)
from Life_Expectancy
where Year >= 2010 AND Year <= 2015
group by Country
order by avg(Adult_Mortality);
                        
#4) List of countries w/highest & lowest avg population (2010 - 2015)
#Highest
select Country, avg(Population)
from Life_Expectancy
where Year >= 2010 AND Year <= 2015
group by Country
order by avg(Population) desc;

#Lowest
select Country, avg(Population)
from Life_Expectancy
where Year >= 2010 AND Year <= 2015
group by Country
order by avg(Population);

#5) List of countries w/Highest & Lowest average GDP (2010-2015)
#Highest
select Country, avg(GDP)
from Life_Expectancy
where Year >= 2010 AND Year <= 2015
group by Country
order by avg(GDP) desc;

#Lowest
select Country, avg(GDP)
from Life_Expectancy
where Year >= 2010 AND Year <= 2015
group by Country
order by avg(GDP);

#6) List of countries w/Highest & Lowest average schooling (2010-2015)
#Highest
select Country, avg(Schooling)
from Life_Expectancy
where Year >= 2010 AND Year <= 2015
group by Country
order by avg(Schooling) desc;

#Lowest
select Country, avg(Schooling)
from Life_Expectancy
where Year >= 2010 AND Year <= 2015
group by Country
order by avg(Schooling);

#7) Countries w/highest & lowest average alcohol consumption (2010-2015)
#Highest
select Country, avg(Alcohol)
from Life_Expectancy
where Year >= 2010 AND Year <= 2015
group by Country
order by avg(Alcohol) desc
limit 1;

#Lowest
select Country, avg(Alcohol)
from Life_Expectancy
where Year >= 2010 AND Year <= 2015
group by Country
order by avg(Alcohol)
limit 1;

#8) Do densly populated countries tend to have a lower life expectancy?
#The size of each country is not listed in the dataset so the only way to examine
#population density in this dataset is by just looking at the total country population
select Country, Population, Life_Expectancy
from Life_Expectancy
order by Population;

select Country, Population, Life_Expectancy
from Life_Expectancy
order by Life_Expectancy desc;

#Just from looking at the top 5 results of the last query we can see that the countries with the highest
#life expectancy have highly varying population sizes, scrolling thru the rest of the data the population
#sizes also vary highly and do not seem to correlate strongly to the countries life expectancy

#Export the updated table to a csv file
