/* Part 2 
Question 4: */
Create or Replace Procedure DisplayMessage(message in VARCHAR) As BEGIN
DBMS_OUTPUT.put_line('Hello '||message);
END;
/
Show Errors;

/* Q: Did the procedure compile without errors? Yes. 

Q: What is displayed?
Usage: SHOW ERRORS [{ FUNCTION | PROCEDURE | PACKAGE |
   PACKAGE BODY | TRIGGER | VIEW
   | TYPE | TYPE BODY | DIMENSION
   | JAVA SOURCE | JAVA CLASS } [schema.]name]

Question 5: */
Select ROUND(DBMS_RANDOM.value (10,100)) from DUAL;

/*Q: What is displayed?
ROUND(DBMS_RANDOM.VALUE(10,100))
--------------------------------
			      21
A random value from 10 to 100 was selected*/
Create or Replace Procedure setSalaries(low in INTEGER, high in INTEGER)
As Cursor Emp_cur IS
	Select * from AlphaCoEmp;
	--Local variables
	l_emprec Emp_cur%rowtype;
	l_salary AlphaCoEmp.salary%type;
BEGIN 
	for l_emprec IN Emp_cur
	loop
		l_salary := ROUND(dbms_random.value(low,high));
		update AlphaCoEmp
		set salary = l_salary
		where name = l_emprec.name;
	END LOOP;
	commit;
END;
/
show errors;

exec setSalaries (50000,100000)

select * from AlphaCoEmp;

/* Q:Do you see the salaries (where previously there was a 0 for this column)? 
YES

Question 6:*/
Select name, salary from AlphaCoEmp where salary IN
(Select salary from AlphaCoEmp 
where salary >= 80000);

/* Question 7 
Procedure is in separate file*/

exec setEmpSalary('Vale', 10000, 20000) 

/* Question 8 */
Select getEmpSalary('Vale')From Dual;

/*Q: Did your function work correctly?
Yes*/
