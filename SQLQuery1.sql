-- Query 1 (Use)
-- Run the CrudeSuicideRates file
SELECT *
FROM [MentalHealth-Suicide]..['CrudeSuicideRates$']
order by 1


-- Query 2 (Use)
-- Run the Facilities file
SELECT *
FROM [MentalHealth-Suicide]..Facilities$
order by 1


-- Query 3 (Use)
-- Run the HumanResources file
SELECT *
FROM [MentalHealth-Suicide]..['HumanResources$']
order by 1


-- Query 4 (Use)
-- Get total suicide rates from all ages for Males (CrudeSuicideRates, per population of 100,000)
SELECT Country, ((AVG([80_above])) + (AVG([70to79])) + (AVG([60to69])) + (AVG([50to59])) + (AVG([40to49])) + (AVG([30to39])) + (AVG([20to29])) + (AVG([10to19]))) /8 AS AllAgeMaleRate
FROM [MentalHealth-Suicide]..['CrudeSuicideRates$'] AS rates
WHERE Sex = 'Male'
GROUP BY Country


-- Query 5 (Use)
-- Get total suicide rates from all ages for Females (CrudeSuicideRates, per population of 100,000)
SELECT Country, ((AVG([80_above])) + (AVG([70to79])) + (AVG([60to69])) + (AVG([50to59])) + (AVG([40to49])) + (AVG([30to39])) + (AVG([20to29])) + (AVG([10to19]))) /8 AS AllAgeFemaleRate
FROM [MentalHealth-Suicide]..['CrudeSuicideRates$'] AS rates
WHERE Sex = 'Female'
GROUP BY Country


-- Query 6
-- Get total suicide rates from all ages for both sexes (CrudeSuicideRates, per population of 100,000)
SELECT Country, ((AVG([80_above])) + (AVG([70to79])) + (AVG([60to69])) + (AVG([50to59])) + (AVG([40to49])) + (AVG([30to39])) + (AVG([20to29])) + (AVG([10to19]))) /8 AS AllAgeBothSexesRate
FROM [MentalHealth-Suicide]..['CrudeSuicideRates$'] AS rates
WHERE Sex = 'Both sexes'
GROUP BY Country


-- Query 7
-- Get total treatment facilities per country (Facilities, per population of 100,000)
SELECT Country, Year, ([Mental _hospitals] + health_units + [outpatient _facilities] + [day _treatment] + residential_facilities) AS totalfacilities
FROM [MentalHealth-Suicide]..Facilities$ AS Facilities


-- Query 8
-- Get total human resources availble per country (Human Resources, per population of 100,000)
SELECT Country, Year, (Psychiatrists + Nurses + Social_workers + Psychologists) AS totalResources
FROM [MentalHealth-Suicide]..['HumanResources$'] AS Resources


-- Query 9 (Use)
-- Combine Query 7 and Query 8
SELECT Facilities.Country, Facilities.Year, (Facilities.[Mental _hospitals] + Facilities.health_units + Facilities.[outpatient _facilities] + Facilities.[day _treatment] + Facilities.residential_facilities) AS totalfacilities,(Resources.Psychiatrists + Resources.Nurses + Resources.Social_workers + Resources.Psychologists) AS totalResources
FROM [MentalHealth-Suicide]..Facilities$ AS Facilities
JOIN [MentalHealth-Suicide]..['HumanResources$'] AS Resources
	ON Facilities.Country = Resources.Country


-- Query 10 (Use)
-- Grouping CrudeSuicide Rates by: ChildrenTeenagers (10-19), Young Adults (20-29), Adults (30-59), Older Adults (60+)
SELECT Country, ((SUM([10to19])) + (SUM([20to29]))) AS ChildrenYoungAdults, ((SUM([30to39])) + (SUM([40to49]))) AS Adults, ((SUM([50to59])) + (SUM([60to69]))) AS OlderAdults, ((SUM([70to79])) + (SUM([80_above]))) AS Elderly
FROM [MentalHealth-Suicide]..['CrudeSuicideRates$'] AS rates
WHERE SEX = 'Both Sexes'
GROUP BY Country
