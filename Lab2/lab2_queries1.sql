REM a)Display data with fullname 
Select custid, firstname ||' '|| lastname as fullname, city from Customer; 

REM b)Order the Customer table by last name
Select * from Customer order by lastname; 

REM c)order by descending serviceid and custid
Select * from Schedule order by serviceid desc, custid desc; 

REM d) Service ids of delivery that are not in the schedule table
Select distinct serviceid from DeliveryService where serviceid not in (select serviceid from Schedule); 

REM e)Show names of customers who ordered a delivery service on Monday
Select firstname, lastname from customer inner join Schedule on Customer.custid=Schedule.custid where day = 'm';

REM f) Show last names of customers with are scheduled delivery services
Select distinct lastname from Customer Inner Join Schedule on Schedule.custid = Customer.custid;

REM g) highest service in Delivery Services
Select max(servicefee) as highest_Servicefee from DeliveryService;

REM h) Number of delivery services scheduled by day
Select Count(custid) from Schedule group by (day);

REM i) Show pairs of customer IDs from the same city
Select A.custid, B.custid, A.city from Customer A, Customer B where A.custid < B.custid and A.city=B.city;

REM j) Show customers whose customer city and location are the same
Select distinct firstname, lastname from Customer inner join DeliveryService on DeliveryService.location = Customer.city;

REM k) Maximum salary of ppl in Staff_2010
Select min(salary) as minimum, max(salary) as maximum from staff_2010;

REM Pathway
@/DCNFS/users/student/fkuan/Documents/COEN178/labs/lab2/lab2_queries1.sql





