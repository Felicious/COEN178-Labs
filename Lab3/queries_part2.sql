/* Part 2
Exercise 7: Show deptId and # of employees of each department*/
Select deptId AS deptno, count(*) AS empcount 
from L_EMP group by deptId;

/*Exercise 8: show deptname and # of employees in each
a) */
Select deptno, deptname, empcount from
(Select deptId AS deptno, count(*) AS empcount
from L_EMP group by deptId), L_DEPT 
where deptno = L_DEPT.deptid;

/*b) (same as above), but ahoq rows in ascending order, sorted by empcount */ 
Select deptno, deptname, empcount from
(Select deptId AS deptno, count(*) AS empcount
from L_EMP group by deptId), L_DEPT 
where deptno = L_DEPT.deptid
order by empcount;

/*Exercise 9 find deptId of dept with max employees
Attempt 1: 
It doesn't work.

Attempt 2
a) The problem with the query is that Having requires the subquery to return one 
comparable result. Need to alter it so that the subquery returns one tuple
*/
Select deptid from L_EMP Group by deptid 
Having count(*) >= ALL (Select count(*) from L_EMP Group by deptid);

/*b) */

Select deptname from 
(Select deptid AS angfds from L_EMP Group by deptid 
Having count(*) >= ALL (Select count(*) from L_EMP Group by deptid)), L_DEPT 
where angfds=deptid;

/*Exercise 10
a) Show output:
DEPTI	   EMPNO EMPNAME    DEPTNAME
----- ---------- ---------- ----------
d1	       6 chen	    Research
d1	       3 wayne	    Research
d1	       1 smith	    Research
d1	       5 king	    Research
d2	       2 jones	    Devt
d3	       7 winger     Testing
d3	       4 moor	    Testing

b) Complete query */
Select L_EMP.deptid, empno, empname, deptname 
from L_EMP, L_DEPT where L_EMP.deptid = L_DEPT.deptid;








