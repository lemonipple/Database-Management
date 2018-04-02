-- #4
DESCRIBE departments;

SELECT * 
FROM departments;

--#5
DESCRIBE employees;

SELECT employee_id, last_name, job_id, hire_date StartDate
FROM employees;

--#6
SELECT employee_id, last_name, job_id, hire_date StartDate
FROM employees;

--#7
SELECT DISTINCT job_id
FROM employees;

--#8
SELECT employee_id "Emp #", last_name Employee, job_id Job, hire_date "Hire Date"
FROM employees;

--#9
SELECT last_name || ', ' || job_id "Employee and Title"
FROM employees;

--#10
SELECT employee_id || ',' || first_name || ',' || last_name || ',' || email || ',' || 
phone_number || ',' || hire_date || ',' || job_id || ',' || salary || ',' || commission_pct
|| ',' || manager_id || ',' ||  department_id as THE_OUTPUT
from employees;


2
--#1
SELECT last_name, salary
FROM employees
WHERE salary > 12000;

--#2
SELECT last_name, department_id
FROM employees
WHERE employee_id = 176;

--#3
SELECT last_name, salary
FROM employees
WHERE salary NOT BETWEEN 5000 AND 12000;

--#4
SELECT last_name, job_id, hire_date
FROM employees
WHERE LAST_NAME IN ('Matos', 'Taylor')
ORDER BY hire_date;

--#5
SELECT last_name, department_id
FROM employees
WHERE department_id IN (20, 50)
ORDER BY last_name;

--#6
SELECT last_name "Employee", salary "Monthly Salary"
FROM EMPLOYEES
WHERE SALARY BETWEEN 5000 AND 12000 AND department_id IN(20, 50);

--7
SELECT LAST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN '01-Jan-94' AND '31-Dec-94';

SELECT LAST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE LIKE '%94';

--8
SELECT LAST_NAME, JOB_ID
FROM EMPLOYEES
WHERE MANAGER_ID IS NULL;

--9
SELECT LAST_NAME, SALARY, COMMISSION_pct
FROM EMPLOYEES
WHERE commission_pct IS NOT NULL
ORDER BY 2 DESC, 3 DESC;

--10
SELECT LAST_NAME, SALARY
FROM EMPLOYEES
WHERE salary > &sal_amt;

--11
SELECT employee_id, last_name, salary, department_id
FROM EMPLOYEES
WHERE MANAGER_ID = &MGR_NUM
ORDER BY &ORDER_COL;

--12
SELECT LAST_NAME
FROM EMPLOYEES
WHERE last_name LIKE '__a%';

--13
SELECT last_name
FROM EMPLOYEES
WHERE LAST_NAME LIKE '%a%'
AND LAST_NAME LIKE '%e%';

--14
SELECT LAst_NAME, job_id, SALARY
FROM EMPLOYEES
WHERE JOB_ID IN ('SA_REP', 'ST_CLERK')
AND salary NOT IN (2500, 3500, 7000);

--15
SELECT last_name "Employee", salary "Monthly Salary", COMMISSION_PCT
FROM EMPLOYEES
WHERE commission_pct = 0.2; 


3

--1
SELECT sysdate "Date"
FROM DUAL;

--2 & 3
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, ROUND(SALARY * 1.155, 0) "New Salary"
FROM employees;

--4
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, ROUND(SALARY * 1.155, 0) "New Salary",
  ROUND(SALARY * 1.155, 0) - Salary "Increase"
FROM EMPLOYEES;

--5
SELECT INITCAP(LAST_NAME) "Name", LENGTH(LAST_NAME) "Length"
FROM EMPLOYEES
WHERE SUBSTR(LAST_NAME, 1, 1) IN ('J', 'A', 'M')
ORDER BY last_name;

SELECT INITCAP(LAST_NAME) "Name", LENGTH(LAST_NAME) "Length"
FROM EMPLOYEES
WHERE last_name LIKE 'J%' or last_name like 'M%' or last_name like 'A%'
ORDER BY last_name;

--6
SELECT LAST_NAME, ROUND(MONTHs_BETWEEN(sysdate, HIRE_DATE)) month_worked
FROM EMPLOYEES
ORDER BY month_worked;

--7
SELECT LAST_NAME, LPAD(SALARY, 15, '$') salary
FROM employees;

--8
SELECT RPAD(SUBSTR(last_name, 1, 8), 8) || rpad(' ', TRUNC(salary / 1000), '*')
  employees_and_their_salaries
FROM EMPLOYEES
ORDER BY salary DESC;

4

--#1
SELECT LAST_NAME || ' earns ' || TO_CHAR(SALARY, 'fm$99,999.00') ||
  ' monthly but wants ' || TO_CHAR(SALARY * 3, 'fm$99,999.00') || '.'
  "Dream Salaries"
FROM employees;

--#2
SELECT LAST_NAME, HIRE_DATE, TO_CHAR(NEXT_DAY(ADD_MONTHS(HIRE_DATE, 6),
  'MONDAY'), 'fmDay, "the" Ddspth "of" Month, YYYY') REVIEW
FROM employees;

--#3
SELECT LAST_NAME, HIRE_DATE, TO_CHAR(HIRE_DATE, 'Day') DAY
FROM EMPLOYEES
ORDER BY TO_CHAR(hire_date - 1, 'd');

--#4:
SELECT LAST_NAME, NVL(TO_CHAR(COMMISSION_PCT), 'No Commission') COMM
FROM EMPLOYEES;

--#5: NOT REQUIRED
SELECT JOB_ID, DECODE(JOB_ID,
                'AD_PRES',  'A',
                'ST_MAN',   'B',
                'IT_PROG',  'C',
                'SA_REP',   'D',
                'ST_CLERK', 'E',
                '0') GRADE
FROM EMPLOYEES;


--#6
SELECT JOB_ID, CASE JOB_ID
                WHEN 'AD_PRES'  THEN 'A'
                WHEN 'ST_MAN'   THEN 'B'
                WHEN 'IT_PROG'  THEN 'C'
                WHEN 'SA_REP'   THEN 'D'
                WHEN 'ST_CLERK' THEN 'E'
                ELSE '0' END GRADE
FROM EMPLOYEES;

--#4
SELECT ROUND(MAX(salary)) "Maximum", ROUND(MIN(salary)) "Minimum", ROUND(SUM(
  salary)) "Sum", ROUND(AVG(salary)) "Average"
FROM EMPLOYEES;

--#5
SELECT job_id, ROUND(MAX(salary)) "Maximum", ROUND(MIN(salary)) "Minimum",
  ROUND(SUM( salary)) "Sum", ROUND(AVG(salary)) "Average"
FROM EMPLOYEES
GROUP BY job_id;

--#6
SELECT job_id, COUNT( * )
FROM EMPLOYEES
GROUP BY job_id;

SELECT job_id, COUNT( * )
FROM EMPLOYEES
WHERE job_id = '&job_title'
GROUP BY job_id;

--#7
SELECT COUNT(DISTINCT manager_id) "Number of Managers"
FROM EMPLOYEES;

--#8
SELECT MAX(salary) - MIN(salary) DIFFERENCE
FROM employees;

--#9
SELECT manager_id, MIN(salary)
FROM EMPLOYEES
WHERE manager_id IS NOT NULL
GROUP BY manager_id
HAVING MIN(salary) > 6000
ORDER BY MIN(salary) DESC;

--#10
SELECT COUNT( * ), 
        SUM(CASE TO_CHAR(hire_date, 'YYYY') WHEN '1995' THEN 1 ELSE 0 END) "1995", 
        SUM(CASE TO_CHAR(hire_date, 'YYYY') WHEN '1996' THEN 1 ELSE 0 END) "1996", 
        SUM(CASE TO_CHAR(hire_date, 'YYYY') WHEN '1997' THEN 1 ELSE 0 END) "1997", 
        SUM(CASE TO_CHAR(hire_date, 'YYYY') WHEN '1998' THEN 1 ELSE 0 END) "1998"
FROM employees;

--OR--

SELECT COUNT( * ), 
        COUNT(CASE TO_CHAR(hire_date, 'YYYY') WHEN '1995' THEN ' ' END) "1995", 
        COUNT(CASE TO_CHAR(hire_date, 'YYYY') WHEN '1996' THEN ' ' END) "1996", 
        COUNT(CASE TO_CHAR(hire_date, 'YYYY') WHEN '1997' THEN ' ' END) "1997", 
        COUNT(CASE TO_CHAR(hire_date, 'YYYY') WHEN '1998' THEN ' '  END) "1998"
FROM employees;

--#11
SELECT JOB_ID, 
        SUM(CASE department_id WHEN 20 THEN salary END) "Dept 20", 
        SUM(CASE department_id WHEN 50 THEN salary END) "Dept 50", 
        SUM(CASE department_id WHEN 80 THEN salary END) "Dept 80", 
        SUM(CASE department_id WHEN 90 THEN salary END) "Dept 90", 
        SUM(salary) "Total"
FROM employees
group by job_id;
