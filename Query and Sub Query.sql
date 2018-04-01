--#1
SELECT last_name, hire_date
FROM employees
WHERE department_id =
  (SELECT department_id
  FROM employees
  WHERE last_name = '&&enter_name'
  ) 
  
AND last_name <> '&enter_name';

--#2
SELECT employee_id, last_name, salary
FROM employees
WHERE salary >
  (SELECT AVG(salary)
  FROM employees)
ORDER BY salary;

--#3
SELECT employee_id, last_name
FROM employees
WHERE department_id IN
  (SELECT department_id
  FROM employees
  WHERE last_name LIKE '%u%'
  );

--#4
SELECT last_name, department_id, job_id
FROM employees
WHERE department_id IN
  (SELECT department_id
  FROM departments
  WHERE location_id = 1700
  );

--$5
SELECT last_name, salary
FROM employees
WHERE manager_id =
  (SELECT employee_id
  FROM employees
  WHERE last_name = 'King'
  );

--or

SELECT e.last_name, e.salary
FROM employees e JOIN employees m
ON e.manager_id = m.employee_id
    AND m.last_name = 'King';

--#6
SELECT department_id, last_name, job_id
FROM employees
WHERE department_id =
  (SELECT department_id
  FROM departments
  WHERE department_name = 'Executive'
  );

--#7
SELECT last_name
FROM employees
WHERE salary > ANY
  (SELECT salary
  FROM employees
  WHERE department_id = 60
  );
  
--or--

SELECT last_name
FROM employees
WHERE salary > 
  (SELECT MIN(salary)
  FROM employees
  WHERE department_id=60
  );

--#8
SELECT employee_id, last_name, salary
FROM employees
WHERE department_id IN
  (SELECT department_id
  FROM employees
  WHERE last_name LIKE '%u%'
  ) 
AND salary >
  (SELECT AVG(salary)
  FROM employees
  );


-1
CREATE TABLE my_employee
  (id  NUMBER(4) CONSTRAINT my_employee_id_pk PRIMARY Key,
   last_name VARCHAR2(25),
   first_name VARCHAR2(25),
   userid  VARCHAR2(8),
   salary  NUMBER(9,2));
   
--2
DESCRIBE my_employee;

--3
INSERT INTO my_employee
VALUES (1, 'Patel', 'Ralph', 'rpatel', 895);

--4
INSERT INTO my_employee (ID, last_name, first_name, userid, salary)
VALUES (2, 'Dancs', 'Betty', 'bdancs', 860);

--5
SELECT * 
FROM my_employee;

--6 & 7
INSERT INTO my_employee 
VALUES
  (
    &enter_id,
    '&enter_last_name',
    '&enter_first_name',
    '&enter_userid',
    &enter_salary
  );
  
--8
SELECT *
FROM my_employee;

--9: not required
COMMIT;

--10
UPDATE my_employee
SET last_name='Drexler'
WHERE ID=3;

--11
UPDATE my_employee
SET salary=1000
WHERE salary<900;

--12
SELECT *
FROM my_employee;

--13
DELETE FROM my_employee
WHERE lower(last_name) = 'dancs' AND lower(first_name) = 'betty';

--14
SELECT *
FROM my_employee;

--15: not required
COMMIT;

-------- Trasaction control not required: 16-23 -------------------
--16
INSERT INTO my_employee 
VALUES
  (
    &enter_id,
    '&enter_last_name',
    '&enter_first_name',
    '&enter_userid',
    &enter_salary
  );
  
--17
SELECT *
FROM my_employee;

--18
SAVEPOINT step_17;

--19
DELETE FROM my_employee;

--20
SELECT *
FROM my_employee;

--21
ROLLBACK TO step_17;

--22
SELECT *
FROM my_employee;

--23
COMMIT;

-------- Trasaction control not required: 16-23 -------------------

--24 & 25: VERIFY and UNDEFINE not required

--1
CREATE TABLE DEPT (
  ID NUMBER(7) PRIMARY KEY, 
  NAME VARCHAR2(25));

DESCRIBE DEPT;

--2
INSERT INTO DEPT
  SELECT department_id, department_name
  FROM departments;
  
--3
CREATE TABLE EMP (
  id NUMBER(7),
  last_name VARCHAR2(25),
  first_name VARCHAR2(25),
  dept_id NUMBER(7) REFERENCES DEPT (ID));

DESCRIBE EMP;

--4
CREATE TABLE employees2
AS
  SELECT employee_id id, first_name, last_name, salary, department_id dept_id
  FROM employees;
  
--5: not required
ALTER TABLE employees2 READ ONLY;

--6
INSERT INTO employees2
VALUES (34, 'Grant', 'Marcie', 5678, 10);

--7: alter table not required
ALTER TABLE employees2 READ WRITE;

INSERT INTO employees2
VALUES (34, 'Grant', 'Marcie', 5678, 10);

--8: not required
DROP TABLE employees2;

