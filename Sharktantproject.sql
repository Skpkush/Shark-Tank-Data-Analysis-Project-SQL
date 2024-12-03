create database project 

use project

select * from sharktankproject

-- =========================================================
-- Project: Shark Tank Data Analysis
-- Description: This project involves analyzing the data from the Shark Tank TV show. The goal is to explore 
-- various business attributes such as industry type, valuation, investments, and more. We aim to answer 
-- key business questions using SQL queries and provide insights to stakeholders.

-- Table: sharktankproject
-- This table contains information about startups pitching to investors (sharks) on Shark Tank.
-- ====================================================================================================
-- Query to fetch all records from the Shark Tank project table
SELECT * 
FROM sharktankproject;

-- 1. Lets retrive all data of startup and industry or there yearly revenue
SELECT Startup_Name, Industry, Yearly_Revenue FROM SharkTankproject;

-- 2. List of all the startups industries or get total revenuw from each industry .
select distinct(industry) from sharktankproject
-- or So we have total 17 industry now let get all the total revenue for the same 
select distinct industry, SUM(Yearly_Revenue) AS Total_revenue
from sharktankproject
group by industry;

-- 3. Now lets get the startups with yearly revenue greater than 50 crores.
select startup_name, Yearly_revenue from sharktankproject where Yearly_revenue > 50;

-- 4. Now geting the list whose startup is register before the covid or after the covid means 2020
select Startup_name, Started_in from SharkTankproject where Started_in >= 2020;
-- or the data before the covid
select Startup_name, Started_in from SharkTankproject where Started_in <= 2020;
-- Here is other insight for advance level is the Total Count of Startups Before and After 2020 using case command
Select 
    sum(case when Started_in < 2020 then 1 Else 0 end) as Startups_Before_2020,
    sum(case when Started_in >= 2020 then 1 else 0 end) as Startups_After_2020,
    count (*) as Total_Startups
FROM SharkTankproject;

-- 5. Lets we need now all startups with a Gross Margin greater than 30%.
select Industry, startup_name, gross_margin from sharktankproject 
where gross_margin >= 30
order by Industry;

-- 6. First lets Find startups that received a deal from the sharks.
select startup_name, total_deal_amount from sharktankproject 
where received_offer = 1
order by total_deal_amount Asc;

-- 7. Well lets get the total deal amount for startups with accepted offers in descending order;
select startup_name, total_deal_amount from sharktankproject 
where accepted_offer = 1
order by total_deal_amount desc;

-- 8. Now lets Retrieve all startups where the original ask amount is less than 1 crore.
select startup_name, original_ask_amount from sharktankproject
where original_ask_amount > 100; 

-- 9. lets calculate the which one is more in the number of male and female presenters across sharktank

select male_presenters, Female_presenters from sharktankproject; -- to get which type of data is available

select 
    sum(Male_Presenters) as Total_male_presenters,
    sum(Female_Presenters) as Total_female_presenters
from SharkTankproject;

--10. Now get list of company who has patent 
select startup_name, has_patents from sharktankproject 
where has_patents = 'Yes'

select * from sharktankproject

-- 11. Now find which part of indian state has more startup 
select distinct Pitchers_state, count(Startup_name) as Total_startup
from SharkTankproject
group by Pitchers_state
order by total_startup desc;

-- 12. Now lets find city wise total startup available in india and get only top 15 city who 
select Top 15 Pitchers_City, count(Startup_name) as Total_startup
from SharkTankproject
group by Pitchers_City
order by total_startup desc;

-- 13. lets get the List of startups where the Total Deal Equity is greater than 10% amd get seasonwise data.
select Season_number, startup_name, total_Deal_Equity from sharktankproject
where total_deal_equity > 10;

-- 14. lets Find the startups that received an offer but did not accept it.
Select Startup_Name, industry
From sharktankproject
Where Received_Offer = 1 AND Accepted_Offer = 0;

-- 15. lets Find the startups with the highest valuation requested.
Select Startup_Name, season_number, Valuation_Requested
From sharktankproject
Order by Season_number, Valuation_Requested DESC;

-- 16. List the startups where more than 3 sharks invested.
Select season_number, Startup_Name
From sharktankproject
Where Number_Of_Sharks_In_Deal > 3;

-- 17. List the businesses from Delhi or Pune that received offers.
Select Season_number, Startup_Name, Pitchers_City
From sharktankproject
Where (Pitchers_City = 'Delhi' OR Pitchers_City = 'Pune') AND Received_Offer = 1;

-- 18. Find the startups with the highest net margin.
Select TOP 50 Startup_Name, Net_Margin
From sharktankproject
Order by Net_Margin DESC;

-- 19. Find all businesses in the "Food" industry that have patents.
Select Season_number, Startup_Name
from sharktankproject
where Industry = 'Food' AND Has_Patents = 'yes';


-- 20. Find businesses where the valuation requested is greater than the total deal amount.
select Season_number, Startup_Name, Valuation_Requested, Total_Deal_Amount
from sharktankproject
where Valuation_Requested > Total_Deal_Amount;

-- 21. List startups that have both Namita and Vineeta as investors.
select Season_number, Startup_Name
from sharktankproject
where Namita_Investment_Amount > 0 AND Vineeta_Investment_Amount > 0;


--22. Find businesses with a monthly sales greater than the average for all businesses.
Select Startup_Name, Monthly_Sales
from sharktankproject
where Monthly_Sales > 
	(select AVG(Monthly_Sales) from sharktankproject);

-- 23. Calculate the total debt for all businesses that received an offer.
Select sum(Total_Deal_Debt) as Total_Debt_Received_Offer
from sharktankproject
where Received_Offer = 1;

-- 24. Calculate the percentage change in the total deal amount from the first to the last season.

WITH FirstSeasonDeal AS (
    SELECT 
        SUM(Total_Deal_Amount) AS FirstSeasonDeal
    From sharktankproject
    Where Season_Number = 1
),
LastSeasonDeal AS (
    SELECT 
        SUM(Total_Deal_Amount) AS LastSeasonDeal
    from sharktankproject
    whereSeason_Number = (SELECT MAX(Season_Number) FROM sharktankproject)
)
select (LastSeasonDeal - FirstSeasonDeal) / FirstSeasonDeal * 100 as PercentageChange
from FirstSeasonDeal, LastSeasonDeal;

-- 25. Create a report showing the number of businesses that received offers by city and state.
SELECT 
    Pitchers_City, 
    Pitchers_State, 
    COUNT(*) AS NumberOfOffers
From sharktankproject
Where Received_Offer = 1
group by Pitchers_City, Pitchers_State
order by NumberOfOffers Desc;

-- 26. lets calculate the total debt, deal, investment for each season and episodes.
select 
	Season_Number, 
    sum(Total_Deal_Debt) as TotalDebt,
	count(Episode_number) as episodes,
	sum(Total_deal_Amount) as TotalDealamt,
	sum(Deal_valuation) as TotalValuation	
from sharktankproject
group by Season_Number
order by TotalDebt;

select * from sharktankproject

-- 27. Now whats the average number of sharks investing per startup
--  and list startup with above-average shark involvement.

WITH AvgSharks as (
    select 
		AVG(Number_Of_Sharks_In_Deal) as AverageSharks
    from sharktankproject
)
select 
    Startup_Name, 
	season_number,
    Number_Of_Sharks_In_Deal
from sharktankproject, AvgSharks
where Number_Of_Sharks_In_Deal > AverageSharks;

-- 28. List the startup where the startup valuation requested was higher than the industry average.
WITH Industry_Avg as (
    select 
        Industry, 
        AVG(Valuation_Requested) AS IndustryAvgValuation
    from sharktankproject
    group by Industry
)
select 
    s.Industry,
	s.startup_name,
    s.Valuation_Requested
from sharktankproject s
JOIN Industry_Avg ia ON s.Industry = ia.Industry
where s.Valuation_Requested > ia.IndustryAvgValuation

--29. Identify startup with a gross margin greater than the average gross margin. 
WITH AvgGrossMargin as (
    select 
        AVG(Gross_Margin) as AvgGrossMargin
    from 
        sharktankproject
)
select 
    Startup_Name, 
    Gross_Margin
from sharktankproject, AvgGrossMargin
where Gross_Margin > AvgGrossMargin;

-- 30. Calculate the percentage of startup that received offers with conditions across seasons.
select 
    Season_Number, 
    count(CASE WHEN Deal_Has_Conditions = 'yes' THEN 1 END) * 100.0 / count(*) as PercentageWithConditions
from sharktankproject
group by Season_Number;

 -- 31. lets Calculate the percentage of shartup where more than one shark invested across all seasons.
Select 
    (Count(CASE WHEN Number_Of_Sharks_In_Deal > 1 THEN 1 END) * 100.0 / COUNT(*)) AS PercentageMultiSharkInvestments
From sharktankproject;

--32. Identifing the industries where at least 50% of businesses received offers.
Select Industry
From sharktankproject
Group by Industry
Having  Count(CASE WHEN Received_Offer = 1 THEN 1 END) * 1.0 / COUNT(*) >= 0.5;

--33. Find all the sharks investment and there equity 
select* from SharkTankProject


SELECT 
    Season_Number, Startup_Name, Industry, 
    Namita_Investment_Amount AS Investment_Amount, 
    Namita_Investment_Equity AS Investment_Equity,
	'Namita' AS Investor
FROM SharkTankproject
WHERE Namita_Investment_Amount IS NOT NULL AND Namita_Investment_Equity IS NOT NULL
UNION ALL
SELECT 
    Season_Number, Startup_Name, Industry, 
    Vineeta_Investment_Amount AS Investment_Amount, 
    Vineeta_Investment_Equity AS Investment_Equity,
    'Vineeta' AS Investor
FROM SharkTankproject
WHERE Vineeta_Investment_Amount IS NOT NULL AND Vineeta_Investment_Equity IS NOT NULL
UNION ALL
SELECT 
    Season_Number, Startup_Name, Industry, 
    Ashneer_Investment_Amount AS Investment_Amount, 
    Ashneer_Investment_Equity AS Investment_Equity,
    'Ashneer' AS Investor
FROM SharkTankproject
WHERE Ashneer_Investment_Amount IS NOT NULL AND Ashneer_Investment_Equity IS NOT NULL
UNION ALL
SELECT 
	Season_Number, Startup_Name, Industry, 
    Aman_Investment_Amount AS Investment_Amount, 
    Aman_Investment_Equity AS Investment_Equity,
	'Aman' AS Investor
FROM SharkTankproject
WHERE Aman_Investment_Amount IS NOT NULL AND Aman_Investment_Equity IS NOT NULL
UNION ALL
SELECT 
    Season_Number, Startup_Name, Industry, 
    Anupam_Investment_Amount AS Investment_Amount, 
    Anupam_Investment_Equity AS Investment_Equity,
    'Anupam' AS Investor
FROM SharkTankproject
WHERE Anupam_Investment_Amount IS NOT NULL AND Anupam_Investment_Equity IS NOT NULL
UNION ALL
SELECT 
    Season_Number, Startup_Name, Industry, 
    Peyush_Investment_Amount AS Investment_Amount, 
    Peyush_Investment_Equity AS Investment_Equity,
    'Peyush' AS Investor
FROM SharkTankproject
WHERE Peyush_Investment_Amount IS NOT NULL AND Peyush_Investment_Equity IS NOT NULL
UNION ALL
SELECT 
    Season_Number, Startup_Name, Industry, 
    Amit_Investment_Amount AS Investment_Amount, 
    Amit_Investment_Equity AS Investment_Equity,
    'Amit' AS Investor
FROM SharkTankproject
WHERE Amit_Investment_Amount IS NOT NULL AND Amit_Investment_Equity IS NOT NULL;

