use ids14db;
#First lets see what rows in the table contain a 0
select murder, Assault, UrbanPop
from USArrests
where murder=0 OR Assault=0 OR UrbanPop=0;

#Get and store the avg of the assault column in a variable
select @myVar := avg(Assault) from USArrests;

#Show the variable
select @myVar;

SET SQL_SAFE_UPDATES = 0;
#From the displayed result the only column which needs to be updated is Assault
update USArrests
SET Assault = @myVar
where Assault=0;

#Get min, max, mean, varaiance for murder
select min(murder), max(murder), avg(murder), variance(murder)
from USArrests;

#Get min, max, mean, variance for Assault
select min(Assault), max(Assault), avg(Assault), variance(Assault)
from USArrests;

#Get min, max, mean, variance for UrbanPop
select min(UrbanPop), max(UrbanPop), avg(UrbanPop), variance(UrbanPop)
from USArrests;

#Get state with max murder rate
select state
from USArrests
where murder = (Select max(murder) from USArrests);

#List states in ascending order of UrbanPop
select state
from USArrests
Order by UrbanPop asc;

#List of states with higher murder rate then Arizona
select state
from USArrests
where murder > (select murder from USArrests where state='Arizona');

