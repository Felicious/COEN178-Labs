/* Exercise 1
Approach 1 */
Select First ||' '|| Last AS Fullname, salary from Staff_2010 
where salary IN (Select MAX(salary) from Staff_2010); 
/*Approach 2 */ 
Select First ||' '|| Last AS Fullname, salary from Staff_2010 
where salary = (Select MAX(salary) from Staff_2010);

/* Exercise 2
Find lastnames of people with the same salary as "Zichal" */ 
Select last, salary from Staff_2010 where salary = 
(Select salary from Staff_2010 where lower(last) = 'zichal');

/*Find last names of ppl with same salary as "Young"*/
Select last, salary from Staff_2010 where salary IN
(Select salary from Staff_2010 where lower(last) = 'young');

/* Exercise 3
Salaries >100k */
Select count(salary) from Staff_2010 where salary > 100000;

/* Exercise 4
# of ppl with salaries greater than 100k and grouped by a salary number*/
Select salary, count(salary) AS SALARIES_100K_ABOVE 
from Staff_2010 where salary > 100000 group by salary;

/* Exercise 5
# of ppl with salaries greater than 100k with 10 + in that salary group */
Select salary, count(salary) AS SALARIES_100K_ABOVE
from Staff_2010 where salary > 100000 
group by salary having count(salary) >= 10; 

/*Exercise 6 
Examine output and answer: "What is the option 'i' for?" */
SELECT last FROM Staff_2010
WHERE REGEXP_LIKE (last, '([aeiou])\1', 'i');
/*Answer: REGEXP, with the aeiou parameter is case sensitive to consecutive 
lowercase vowels, but the additional 'i' makes it so that consecutive upper
case I results are included */ 
