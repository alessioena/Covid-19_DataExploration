-- 1	Checkout datasets

select *
from coviddeaths;

select *
from covidvaccinations;


-- 2	Looking at total cases VS total deaths in the USA

select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
from coviddeaths
where location like '%states%' 
order by 1,2;


-- 3	Looking at the total cases VS population in Italy
-- The Infection_rate shows what percentage of population got COVID

select location,date,total_cases,population,(total_cases/population)*100 as Infection_rate
from coviddeaths
where location='italy'
order by 1,2;


-- 4	Looking at countries with highest infection rate compared to population

select location,population, max(total_cases) as HighestInf,max(total_cases/population)*100 as Infection_rate
from coviddeaths
Group by location, population
order by Infection_rate desc;


-- 5	Showing countries with the highest death count per population

select location, max(cast(total_deaths as float)) as TotalDeathCount
from coviddeaths
Group by location
order by TotalDeathCount desc;


-- 6	Global numbers

select date,sum(new_cases) as total_cases,sum(cast(new_deaths as float)) as total_deaths,sum(cast(new_deaths as float))/sum(new_cases)*100 as DeathPercentage
from coviddeaths
where continent is not null
group by date
order by 1,2;


-- 7	Total cases and total deaths in Italy

select sum(new_cases) as total_cases,sum(cast(new_deaths as float)) as total_deaths,sum(cast(new_deaths as float))/sum(new_cases)*100 as DeathPercentage
from coviddeaths
where location='Italy'
order by 1,2;


-- 8	Join the datasets

select *
from coviddeaths dea
join covidvaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date;


-- 9	Looking at total population vs vaccinations
 
select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
from coviddeaths dea
join covidvaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 1,2,3;
