
-- 1. Find all universities in USA and China. The result
-- should have two columns university and country.
-- First should be listed the universities in USA.

select country_name, university_name
from universities.country as con
join universities.university as uni
on con.id = uni.country_id


-- 2. Find all time top 10 universities with the most number of students. 
-- The result should be sorted from highest to lowest number of students.

select distinct university_name, num_students
from universities.university as uni
join universities.university_year as ye
on uni.id = ye.university_id
order by num_students DESC
limit 10

-- 3. Find the university name that had the most 
-- international students in 2016. The result should show 
-- the university name and the percentage of international students.
select Distinct university_name, pct_international_students, Round(pct_international_students/100.0 * num_students)
from universities.university_year as ye
join universities.university as uni
on ye.university_id = uni.id
where ye.year = 2016
order by round desc
limit 1


-- 4. Select the universities,  with their  highest
-- ever value of male percentage among students.
-- Show the result without null values.
select Distinct university_name, (100 - pct_female_students) as "male_perc"
from universities.university as uni 
join universities.university_year as ye
on ye.university_id = uni.id
where pct_female_students is not Null
order by male_perc DESC


-- 5. List top 3 countries that have the most ranked universities along with 
-- the number of universities.

select country_name, count(university_name)
from universities.university
join universities.country
on country.id = university.country_id
group by country_name
order by count DESC

-- 6. Create view that will show the name of the universities along with their score in 2016.

select * from universities.university
select * from universities.university_ranking_year

drop view university_2016

create view universities.university_2016 AS
select university_name, score from universities.university 
join universities.university_ranking_year 
on university.id = university_ranking_year.university_id
where year = 2016 and score IS NOT NULL
order by score DESC

select * from university_2016

-- 7. Set the column name of score as universite_score in the view

alter view universities.university_2016 rename column score to univesitie_score

-- 8. Show all criterias for Center for World University Rankings system.

select * from universities.ranking_criteria
select * from universities.ranking_system

select criteria_name
from universities.ranking_criteria as cr
join universities.ranking_system as sy
on sy.id = cr.ranking_system_id
where ranking_system_id = 3
