/* Q1 */
Create or Replace Procedure assignJobTitlesAndSalaries As
type titlesList IS VARRAY(6) OF AlphaCoEmp.title%type;
type salaryList IS VARRAY(6) of AlphaCoEmp.salary%type;

v_titles titlesList; 
v_salaries salaryList;

Cursor Emp_cur IS
	Select * from AlphaCoEmp;

l_emprec Emp_cur%rowtype;
l_title AlphaCoEmp.title%type;
l_salary AlphaCoEmp.salary%type;
l_randomnumber INTEGER := 1;

BEGIN
	v_titles := titlesList('advisor', 'director', 'assistant', 
'manager', 'supervisor', 'secretary');

	v_salaries := salaryList(130000, 100000, 120000, 600000, 500000, 800000); 
	for l_emprec IN Emp_cur
	loop
		l_randomnumber := dbms_random.value(1,6);
		l_title := v_titles(l_randomnumber);
		l_salary := v_salaries(l_randomnumber);

		update AlphaCoEmp
		set title = l_title where name = l_emprec.name;
		update AlphaCoEmp
		set salary = l_salary where name = l_emprec.name; 
	END LOOP;
commit;
END;
/
Show errors;

exec assignJobTitlesAndSalaries

Select * from AlphaCoEmp;  


/*Q2 */
Create or Replace Function calcSalaryRaise( p_name in AlphaCoEmp.name%type, percentRaise IN NUMBER)
RETURN NUMBER 
IS
l_salary AlphaCoEmp.salary%type;
l_raise AlphaCoEmp.salary%type;
l_cnt Integer;

BEGIN
	Select salary into l_salary from AlphaCoEmp where upper(name) = upper(p_name);
	l_raise := l_salary * (percentRaise/100);

	Select count(*) into l_cnt from Emp_Work
	where upper(name) = upper(p_name);

	if l_cnt >= 1 THEN
		l_raise := l_raise + 1000;
	End IF;
	return l_raise;
END;
/
Show Errors;

/* Part a) what is the output?
	Typing in Select calcSalaryRaise('Stone',2) from Dual; did not give me rresults, but I got something when I replaced Stone with a name that exists in the table */

/* Part b) 
Select name, title, salary CURRENTSALARY, 
trunc(calcSalaryRaise(name,2)) RaisedSalaryBy 
from AlphaCoEmp where upper(name) = upper('Cutter');

Output displayed Cutter's current salary and how much the new salary raised by */
/* Q3 */ 
Create table EmpStats (title VARCHAR(20) Primary KEY,
	empcount INTEGER, lastModified DATE);


Create or Replace Function countByTitle(p_title in AlphaCoEmp.title%type)

RETURN NUMBER IS
l_cnt Integer;

BEGIN
	Select count(*) into l_cnt from AlphaCoEmp
	Group by title
	Having title = p_title;

	return l_cnt;
END;
/ 
select countByTitle('director') from Dual;
select countByTitle('advisor') from Dual;
 
/* c) Output: 
COUNTBYTITLE('DIRECTOR')
------------------------
		      88


COUNTBYTITLE('ADVISOR')
-----------------------
		     35

Q4 */

CREATE or REPLACE procedure saveCountByTitle AS 
l_cnt integer := 0;

BEGIN
	delete from EmpStats; 
	l_cnt := countByTitle('advisor');
	insert into EmpStats values ('advisor',l_cnt,SYSDATE);

	l_cnt := countByTitle('director');
	insert into EmpStats values ('director',l_cnt,SYSDATE);

	l_cnt := countByTitle('assistant');
        insert into EmpStats values ('assistant',l_cnt,SYSDATE);

	l_cnt := countByTitle('manager');
        insert into EmpStats values ('manager',l_cnt,SYSDATE);

	l_cnt := countByTitle('supervisor');
        insert into EmpStats values ('supervisor',l_cnt,SYSDATE);

	l_cnt := countByTitle('secretary');
        insert into EmpStats values ('secretary',l_cnt,SYSDATE);

END;
/
Show errors;
/* 
c) The count for advisor is 35.



 Q5 */

CREATE Or Replace TRIGGER titlecountchange_trig
	AFTER INSERT ON AlphaCoEmp
	FOR EACH ROW
	BEGIN
		Update EmpStats
		set Empcount = Empcount + 1, lastmodified = SYSDATE
		where title = :new.title;
	END;
/
Show errors;

/*Count for advisor: 36
The trigger fired because it is set to increase the title that was inserted by by 1. 

Q6*/

CREATE Or Replace TRIGGER countchange_trig
	AFTER INSERT or DELETE ON AlphaCoEmp
	FOR EACH ROW
	BEGIN
	IF DELETING THEN 
		Update EmpStats
		set Empcount = Empcount -1, lastmodified = SYSDATE
		where title = :old.title;
	END IF;
	If Inserting THEN
		Update EmpStats
		set Empcount = Empcount +1, lastmodified = SYSDATE
		where title = :new.title;
	End IF;
END;
/
Show errors;

/* c) The trigger fired because the emp count decremented from 36 (from earlier) to 35. */

