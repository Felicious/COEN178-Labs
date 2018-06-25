CREATE TABLE AlphaCoEmp(Name VARCHAR(25) Primary Key, 
Title VARCHAR(20) DEFAULT NULL, 
Salary Number(10,2) DEFAULT 0);

INSERT INTO AlphaCoEmp (name) SELECT distinct last from Staff_2010;

/*Question 1: Did it run now? How many rows are created?

The query goes through after adding "distinct" after the select command
434 rows were created. 

 Do a Select * from AlphaCoEmp and check the results displayed.
 Q: What was displayed for title and salary?
 The title is blank and the salary is 0 for all employees.

Question 2 */
Create Table Emp_Work(name VARCHAR(25) Primary Key, 
Project VARCHAR(20) default NULL,
Constraint FK_AlphaCo
Foreign Key (name) REFERENCES AlphaCoEmp(name));

/*This inserts employee names that start with A, G, or S from Alpha into Emp*/
Insert into Emp_Work(name) Select Name from AlphaCoEmp 
where REGEXP_LIKE(name,'(^[ags])','i');

/* Q: What is the 'i' for?
REGEXP is case sensitive, so including the i in the second parameter makes the values in the first parameters (ags) not case-sensitive.

Q: How many rows were inserted? 83 rows

Delete random name: */
Delete from AlphaCoEmp Where name='Stone';

/* Q: did your deletion work? why?
 The deletion did not work because cannot delete tuples in AlphaCoEmp reference Emp_Work

Question 3: */
Alter table Emp_Work
drop constraint FK_AlphaCo;

Alter table Emp_Work
add constraint FK_AlphaCo
FOREIGN KEY (name)references AlphaCoEmp(name)
on delete cascade;

/* Question: is the table altered?
Yes, it was altered without a hitch.

Question: did you succeed in deleting Stone this time?
Yes. When Select name from AlphaCoEmp where name= 'Stone'; was run, no rows were selected.


