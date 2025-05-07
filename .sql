SELECT count(*)
FROM get_fit_now_member;

SELECT * FROM person LIMIT 10;

SELECT DISTINCT type FROM crime_scene_report;

SELECT * FROM person WHERE name = 'Ted Denfip'
SELECT * FROM person WHERE name = 'Yessenia Fossen'
SELECT * FROM person WHERE name = 'Davina Gangwer'

SELECT * FROM crime_scene_report 
WHERE type = 'theft' 
OR city = 'Chicago';

SELECT * FROM crime_scene_report 
WHERE type = 'theft' 
AND city = 'Chicago';

SELECT * FROM crime_scene_report 
WHERE type = 'murder' 
AND city = 'SQL City';

-- The first witness lives at the last house on "Northwestern Dr". 
-- The second witness, named Annabel, lives somewhere on "Franklin Ave".

SELECT DISTINCT city 
FROM crime_scene_report 
WHERE city LIKE 'I%';

SELECT DISTINCT city 
FROM crime_scene_report 
WHERE city BETWEEN 'W%' AND 'Z%';

SELECT DISTINCT city 
FROM crime_scene_report 
WHERE LOWER(city) ='sql city';

SELECT max(age) FROM drivers_license;

SELECT * FROM drivers_license ORDER BY age ASC LIMIT 10;

SELECT * FROM person 
WHERE address_street_name = 'Northwestern Dr' 
ORDER BY address_number DESC LIMIT 1;

SELECT * FROM person 
WHERE name like '%Annabel%'
AND address_street_name = 'Franklin Ave';

-- 14887	Morty Schapiro	118009	4919	Northwestern Dr	111564949
-- 16371	Annabel Miller	490173	103	Franklin Ave	318771143

SELECT person.name, income.annual_income 
FROM income 
JOIN person 
  ON income.ssn = person.ssn 
WHERE annual_income > 450000

SELECT name, annual_income as income, 
gender, eye_color as eyes, hair_color as hair
FROM income i
JOIN person p
  ON i.ssn = p.ssn 
JOIN drivers_license dl
  ON p.license_id = dl.id
WHERE annual_income > 450000

SELECT person.name, interview.transcript
FROM person JOIN interview
ON person.id = interview.person_id
WHERE person.id = 14887 OR person.id = 16371;

-- Morty Schapiro - I heard a gunshot and then saw a man run out. 
-- He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". 
-- Only gold members have those bags. The man got into a car with a plate that included "H42W".

-- Annabel Miller - I saw the murder happen, and I recognized the killer from my gym when 
-- I was working out last week on January the 9th.

Search: - Gold Members  
        - member ID with 48Z%  
        - license plate with H42W%
        - Jan 9th 

SELECT plate_number 
FROM drivers_license
WHERE plate_number LIKE 'H42W%';

-- id	   age	height	eye_color	hair_color	gender	plate_number	car_make	car_model
-- 183779	21	  65	      blue	blonde	     female	   H42W0X	     Toyota	     Prius


--Check the get fit now table
SELECT * 
FROM get_fit_now_member
WHERE id LIKE '48Z%';

--find who checked in January 9th
SELECT * 
FROM get_fit_now_check_in
WHERE membership_id IN ('48Z7A', '48Z55')
AND check_in_date = 20180109;

--check their license plates
SELECT * 
FROM drivers_license
WHERE id IN (
    SELECT license_id 
    FROM person 
    WHERE id IN (28819, 67318) -- Joe Germuska & Jeremy Bowers
)
AND plate_number LIKE '%H42W%';

--link driver's licnese to person
SELECT * 
FROM person
WHERE license_id = 423327;

--and the murderer is.....
INSERT INTO solution VALUES (1, 'Jeremy Bowers');
        
        SELECT value FROM solution;


--Bonus queries 

--Retreive Jeremy's  interview
SELECT * 
FROM interview
WHERE person_id = 67318; -- Jeremy Bowers' ID

--Query the mastermind's information
SELECT p.*
FROM person p
JOIN drivers_license d ON p.license_id = d.id
JOIN facebook_event_checkin f ON p.id = f.person_id
WHERE d.hair_color = 'red'
AND d.height BETWEEN 65 AND 67
AND d.car_make = 'Tesla'
AND d.car_model = 'Model S'
AND f.event_name = 'SQL Symphony Concert'
AND f.date BETWEEN 20171201 AND 20171231
GROUP BY p.id
HAVING COUNT(f.event_name) = 3;

--The mastermind is...
INSERT INTO solution VALUES (1, 'Miranda Priestly');
        
        SELECT value FROM solution;

