Create or Replace FUNCTION getEmpSalary(p_name in VARCHAR)
Return NUMBER IS
	l_salary AlphaCoEmp.salary%type;
BEGIN
	Select salary into l_salary from AlphaCoEmp 
	where lower(name) = lower(p_name);
	return l_salary;
END;
/
show errors;
