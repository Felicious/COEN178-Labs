REM Creating L_DEPT Table
Create table L_DEPT (deptId CHAR(5) Primary Key, deptname CHAR(10));

REM Creating L_EMP Table
Create table L_EMP (empNo Integer Primary Key, empname CHAR(10), deptId CHAR(5), Foreign Key (deptID) references L_DEPT(deptId));

REM Inserting Tuples into L_EMP
insert into L_EMP values(1,'smith','d1');
insert into L_EMP values(2,'jones','d2');
insert into L_EMP values(3,'wayne','d1');
insert into L_EMP values(4,'moor','d3');
insert into L_EMP values(5,'king','d1');
insert into L_EMP values(6,'chen','d1');
insert into L_EMP values(7,'winger','d3');

REM Inserting Tuples into L_DEPT
insert into L_DEPT values('d1','Research');
insert into L_DEPT values('d2','Devt');
insert into L_DEPT values('d3','Testing');
insert into L_DEPT values('d4','Advert');

REM Query for names of employees who work in the same dept with name, 'testing'

REM Approach 1 
Select empname from L_EMP, L_DEPT where L_EMP.deptId = L_Dept.deptId AND lower(deptname) = 'testing';

REM Approach 2
Select empname from L_EMP where L_EMP.deptId in (Select deptId from L_DEPT where lower(deptname) ='testing'); 

REM Exercise 2 - Show dept names with no employees

REM Approach 1
Select deptname from L_DEPT LEFT JOIN L_EMP ON L_DEPT.deptId = L_EMP.deptID where empname is NULL;

REM Approach 2
Select deptname from L_DEPT where L_DEPT.deptId not in (Select L_EMP.deptId from L_EMP); 

