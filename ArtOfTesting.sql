CREATE TABLE EmployeeDetails(
	EmpID	INT PRIMARY kEY,
	FullName	VARCHAR(20),
	ManagerID	INT,
	DateOfJoining	DATE,
	City	VARCHAR(20)
);

CREATE TABLE EmployeeSalary (
	EmpID INT,
	Project	VARCHAR(2),
	Salary	INT,
	Variable INT 
);

INSERT INTO EmployeeDetails (EmpID, FullName, ManagerID, DateOfJoining,City)
VALUES (121, 'John Snow', 321, '2019/01/31', 'Toronto'),
		(321, 'Walter White', 986, '2020/01/30', 'California'),
		(421, 'Kuldeep Rana', 876, '2021/11/27', 'New Delhi');

INSERT INTO EmployeeSalary (EmpID, Project, Salary, Variable)
VALUES (121, 'P1', 8000, 500),
		(321, 'P2', 10000, 1000),
		(421, 'P1', 12000, 0)


-- 1) Napi�te SQL dotaz pro z�sk�n� EmpID a FullName v�ech zam�stnanc� pracuj�c�ch pod mana�erem s id 986

SELECT EmpID, FullName
FROM EmployeeDetails
WHERE ManagerID = 986;

-- 2) Napi�te dotaz pro na�ten� r�zn�ch projekt� dostupn�ch z tabulky EmployeeSalary

SELECT DISTINCT(Project)
FROM EmployeeSalary;

-- 3) Napi�te SQL dotaz pro zji�t�n� po�tu zam�stnanc� pracuj�c�ch v projektu P1

SELECT COUNT(*)
FROM EmployeeSalary
WHERE Project = 'P1';

-- 4) Napi�te  SQL dotaz pro zji�t�n� maxim�ln�, minim�ln� a pr�m�rn� mzdy zam�stnanc�

SELECT
	MAX(Salary) AS MaxSalary,
	MIN(Salary) AS MinSalary,
	AVG(Salary) AS AvgSalary
FROM EmployeeSalary;

-- 5) Napi�te SQL dotaz a najd�te ID zam�stnance, jeho� plat je v rozsahu 9000 a� 15000

SELECT EmpID
FROM EmployeeSalary
WHERE Salary BETWEEN 9000 AND 15000;

-- 6) Napi�t� SQL dotaz pro vyhled�v�n� zam�stnanc�, kte�� �ij� v Torontu a pracuj� pod mana�erem s ID 321

SELECT EmpID
FROM EmployeeDetails
WHERE City = 'Toronto' AND ManagerID = 321;

-- 7) Napi�t� SQL dotaz pro vyhled�v�n� v�ech zam�stnanc�, kte�� �ij� v Kalifornii nebo pracuj� pod mana�erem s ID 321

SELECT EmpID
FROM EmployeeDetails
WHERE City = 'California' OR ManagerID = 321;

-- 8) Napi�t� SQL dotaz pro z�sk�n� v�ech zam�stnanc�, kte�� pracuj� na jin�ch projektech ne� P1

SELECT EmpID, Project
FROM EmployeeSalary
WHERE Project != 'P1';

-- 9) Napi�t� SQL dotaz pro zobrazen� celkov� mzdy ka�d�ho zam�stnance, kter� p�id� hodnotu Salary s VARIABLE

SELECT EmpID, Salary + Variable AS TotalSalary
FROM EmployeeSalary;

-- 10) Napi�t� SQL dotaz pro vyhled�v�n� zam�stnanc�, jejich� jm�no za��n� libovoln�mi dv�ma znaky,
-- n�sleduje text "hn" a kon�� libovolnou sekvenc� znak�

SELECT FullName
FROM EmployeeDetails
WHERE FullName like '__hn%';

-- 11) Napi�t� SQL dotaz pro na�ten� v�ech EmpID, kter� jsou p��tomna v jedn� z tabulek

SELECT EmpID
FROM EmployeeDetails
UNION
SELECT EmpID
FROM EmployeeSalary;

-- 12) Napi�t� dotaz SQL pro na�ten� EmpID, kter� jsou p��tomna v obou tabulk�ch

SELECT EmpID
FROM EmployeeDetails
WHERE EmpID IN ( SELECT EmpID
				FROM EmployeeDetails);

-- 13) Napi�t� dotaz SQL pro na�ten� EmpId, kter� jsou p�itomna v EmployeeDetails, ale ne v EmployeeSalary

SELECT EmpID
FROM EmployeeDetails
WHERE EmpID NOT IN ( SELECT EmpID
					FROM EmployeeSalary);

-- 14) Napi�te SQL dotaz pro z�sk�n� �pln�ch jmen zam�stnance a nahra�te mezeru '-'

SELECT REPLACE(FullName,' ','-')
FROM EmployeeDetails;

-- 15) Napi�t� SQL dotaz pro na�ten� jmen zam�stnanc� s platem vy���m nebo rovn�m 5000 a men��m nebo rovn�m 10000

SELECT FullName
FROM EmployeeDetails
WHERE EmpID IN ( SELECT EmpID
				FROM EmployeeSalary
				WHERE Salary BETWEEN 5000 AND 10000); 

-- 16) Napi�te dotaz SQL pro zji�t�n� aktu�ln�ho data a �asu

SELECT GETDATE() as [Datum a �as];

-- 17) Napi�te SQL dotaz pro na�ten� v�ech podrobnost� o zam�stanc�ch z tabulky EmployeeDetails, kte�� se p�ipojili v roce 2020

SELECT *
FROM EmployeeDetails
WHERE DateOfJoining BETWEEN '2020/01/01' AND '2020/12/31';

-- 18) Napi�te SQL dotaz pro na�ten� v�ech z�znam� zam�stnanc� z tabulky EmployyeeDetails, kte�� maj� z�znam o mzd� v tabulce EmployeeSalary

SELECT *
FROM EmployeeDetails ED
WHERE EXISTS (SELECT *
				FROM EmployeeSalary ES
				WHERE ED.EmpID = ES.EmpID);

-- 19) Napi�t� SQL dotaz pro z�sk�n� projektov�ho po�tu zam�stnanc� se�azen�ch podle po�tu projektu v sestupn�m po�ad�

SELECT project, COUNT(EmpID) AS pocet
FROM EmployeeSalary
GROUP BY Project
ORDER BY Project DESC;

-- 20) Napi�te dotaz pro z�sk�n� jmen zam�stnanc� a platov�ch z�znam�. 
-- Zobrazte podrobnosti o zam�stnanci, i kdy� u zem�stnance neexistuje z�znam o mzd�

SELECT ED.FullName, ES.Salary
FROM EmployeeDetails ED
LEFT JOIN EmployeeSalary ES
ON ED.EmpID = ES.EmpID;

-- 21) Napi�te SQL dotaz, kter� na�te v�echny zam�stnance, kte�� jsou z�rove� mana�ery z tabulky EmloyeeDetails

SELECT ED.EmpID, ED.FullName
FROM EmployeeDetails ED
JOIN EmployeeDetails EM
ON ED.EmpID = EM.ManagerID;



