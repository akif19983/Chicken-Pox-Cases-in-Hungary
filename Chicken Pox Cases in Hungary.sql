-- Master data table 

Select *
From ChickenPoxCasesinHungary..hungary_chickenpox$

-- Cleaning data and check for duplicates by using date (unique colummn)

With Duplicate(Date, Duplicates)
as
(
Select Date, COUNT(*) as Duplicates
From ChickenPoxCasesinHungary..hungary_chickenpox$
Group by Date
)
Select *
From Duplicate
Where Duplicates <> 1


-- Combine date in year

Select Year(Date) as Year, BUDAPEST, BARANYA, BACS, BEKES, BORSOD, CSONGRAD, FEJER, GYOR, HAJDU, HEVES, JASZ, KOMAROM, NOGRAD, PEST, SOMOGY, SZABOLCS, TOLNA, VAS, VESZPREM, ZALA
From ChickenPoxCasesinHungary..hungary_chickenpox$

Drop table if exists #CombinedYear
Create table #CombinedYear
(
Year int,
Budapest int,
Baranya int,
Bacs int,
Bekes int,
Borsod int,
Csongrad int,
Fejer int,
Gyor int, 
Hajdu int,
Heves int,
Jasz int,
Komarom int,
Nograd int,
Pest int,
Somogy int,
Szabolcs int,
Tolna int,
Vas int, 
Veszprem int,
Zala int
)

Insert into #CombinedYear
Select Year(Date), BUDAPEST, BARANYA, BACS, BEKES, BORSOD, CSONGRAD, FEJER, GYOR, HAJDU, HEVES, JASZ, KOMAROM, NOGRAD, PEST, SOMOGY, SZABOLCS, TOLNA, VAS, VESZPREM, ZALA
From ChickenPoxCasesinHungary..hungary_chickenpox$

Select *
From #CombinedYear

-- Total cases for each state by year

Select Year, SUM(Budapest) as Budapest, SUM(Baranya) as Baranya, SUM(Bacs) as Bacs, SUM(Bekes) as Bekes, SUM(Borsod) as Borsod, SUM(Csongrad) as Csongrad, SUM(Fejer) as Fejer, SUM(Gyor) as Gyor, SUM(Hajdu) as Hajdu, SUM(Heves) as Heves, SUM(Jasz) as Jasz, SUM(Komarom) as Komarom, SUM(Nograd) as Nograd, SUM(Pest) as Pest, SUM(Somogy) as Somogy, SUM(Szabolcs) as Szablocs, SUM(Tolna) as Tolna, SUM(Vas) as Vas, SUM(Veszprem) as Veszprem, SUM(Zala) as Zala
From #CombinedYear
Group by Year

Drop table if Exists #TotalCasesPerYearinHungary
Create Table #TotalCasesPerYearinHungary
(
Year int,
Budapest int,
Baranya int,
Bacs int,
Bekes int,
Borsod int,
Csongrad int,
Fejer int,
Gyor int, 
Hajdu int,
Heves int,
Jasz int,
Komarom int,
Nograd int,
Pest int,
Somogy int,
Szabolcs int,
Tolna int,
Vas int, 
Veszprem int,
Zala int
)

Select *
From #TotalCasesPerYearinHungary

Insert into #TotalCasesPerYearinHungary
Select Year, SUM(Budapest) as Budapest, SUM(Baranya) as Baranya, SUM(Bacs) as Bacs, SUM(Bekes) as Bekes, SUM(Borsod) as Borsod, SUM(Csongrad) as Csongrad, SUM(Fejer) as Fejer, SUM(Gyor) as Gyor, SUM(Hajdu) as Hajdu, SUM(Heves) as Heves, SUM(Jasz) as Jasz, SUM(Komarom) as Komarom, SUM(Nograd) as Nograd, SUM(Pest) as Pest, SUM(Somogy) as Somogy, SUM(Szabolcs) as Szablocs, SUM(Tolna) as Tolna, SUM(Vas) as Vas, SUM(Veszprem) as Veszprem, SUM(Zala) as Zala
From #CombinedYear
Group by Year

Select Year, (BUDAPEST + BARANYA + BACS + BEKES + BORSOD + CSONGRAD + FEJER + GYOR + HAJDU + HEVES + JASZ + KOMAROM + NOGRAD + PEST + SOMOGY + SZABOLCS + TOLNA + VAS + VESZPREM + ZALA) as TotalCasesPerYear
From #TotalCasesPerYearinHungary

Select *
From #TotalCasesPerYearinHungary

-- Rank year by TotalCasesPerYear

Drop table if exists #RankYearbyTotalCases
Create table #RankYearbyTotalCases
(
Year int,
TotalCasesPerYear int
)

Insert into #RankYearbyTotalCases
Select Year, (BUDAPEST + BARANYA + BACS + BEKES + BORSOD + CSONGRAD + FEJER + GYOR + HAJDU + HEVES + JASZ + KOMAROM + NOGRAD + PEST + SOMOGY + SZABOLCS + TOLNA + VAS + VESZPREM + ZALA) as TotalCasesPerYear
From #TotalCasesPerYearinHungary

Select *, RANK() OVER (Order by TotalCasesPerYear desc) as RankYearbyTotalCases
From #RankYearbyTotalCases

-- Total cases in Hungary

Select SUM(TotalCasesPerYear) as TotalCasesinHungary
From #RankYearbyTotalCases

-- To rank top 3 year for each state based on cases (2005, 2007, 2006)

Select *
From #TotalCasesPerYearinHungary
Where Year = 2005

Select *
From #TotalCasesPerYearinHungary
Where Year = 2007

Select *
From #TotalCasesPerYearinHungary
Where Year = 2006





