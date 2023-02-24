/* EJERCICIOS REPASO */

/* 1. Amósense os proxectos (prono) nos que traballan como mínimo 2 empregados que cobren máis de 1000 euros,
amósese tamén a suma de horas traballadas por ditos empregados neses proxectos. */

SELECT ep.prono, sum(hours)
FROM emp e JOIN emppro ep 
ON e.empno=ep.empno
WHERE e.sal>1000 
GROUP BY ep.prono
HAVING count(*)>2
	
/* 2. Considerando empregados con salario menor de 5000, obtén a media de salario dos departamentos cuxo
salario mínimo supera 900. Amosa tamén o código e o nome dos departamentos. */

SELECT d.deptno,dname,avg(sal)
FROM emp e JOIN dept d 
ON e.deptno=d.deptno
WHERE sal<5000
GROUP BY d.deptno,dname
HAVING min(sal)>900

/* 3. Por cada proxecto controlado polo departamento 30, indica o seu número, cidade, número de empregados
participantes no proxecto, as horas dedicadas polo empregado que máis traballou, as horas dedicadas polo que
menos traballou e a diferencia entre elas. */

SELECT DISTINCT ep.prono,p.loc,count(*),max(hours),min(hours),max(hours)-min(hours)
FROM emp e JOIN emppro ep ON ep.empno=e.empno
JOIN pro p ON p.prono=ep.prono
WHERE p.deptno=30
GROUP BY p.loc,ep.prono
ORDER BY ep.prono

/* 4. Para cada departamento (nome) móstrese cantos empregados teñen. Inclúase (ou non) os departamentos que
non teñen empregados. */

SELECT d.dname, count(empno)
FROM emp e RIGHT JOIN dept d ON e.deptno=d.deptno
GROUP BY d.dname

/* 5. Dígase o nome e código dos empregados que traballaron nos proxectos con nome P6 ou P8. */

SELECT DISTINCT e.ename,e.empno
FROM emp e RIGHT JOIN emppro ep ON e.empno=ep.empno
JOIN pro p ON p.prono=ep.prono
WHERE p.pname IN ('P6','P8')

/* 6. Para cada departamento (dname) amosa cantos xefes ten e cantos subordinados teñen eses xefes (os
subordinados non teñen por que ser do mesmo departamento que o xefe). Deben aparecer todos os
departamentos. */
 
SELECT dname,count(e.mgr),count(a.empno)
FROM emp e JOIN emp a ON a.mgr=e.empno
RIGHT JOIN dept d ON a.deptno=d.deptno
GROUP BY dname

/* 7. Amosa empregados con SAL > que o promedio de salarios do seu departamento. */

SELECT *
FROM emp e
WHERE sal>(SELECT avg(sal)
		   FROM emp
		   WHERE deptno=e.deptno)

/* 8. Obtén os empregados cuxo salario supera ao dos seus compañeiros de departamento. Se hai algún
departamento onde dous ou mais empregados teñen o salario mais alto, entón ninguén supera aos seus
compañeiros. */

SELECT ename, deptno
FROM emp e
WHERE sal>(SELECT max(sal)
		   FROM emp
		   WHERE e.deptno=deptno AND empno <> e.empno)
		   
/* 9. Indique o nome do(s) departamento(s) que ten(ñen) o maior número de supervisores. */
		   
SELECT dname,d.deptno, count(*) AS num_supervisores
FROM emp e JOIN dept d ON d.deptno=e.deptno
WHERE e.empno IN (SELECT mgr FROM emp)
GROUP BY d.deptno, dname
HAVING count(*) >=ALL (SELECT count(*)
					   FROM emp
					   WHERE empno IN
					  (SELECT mgr FROM emp)
					   GROUP BY deptno)
		   
/* 10. Obtén o nome, o salario, a comisión e o salario total (salario + comisión, se ten comisión) dos empregados con
salario total superior a 2300. */
					   
SELECT ename,sal,comm,coalesce(sal+comm,sal) salario_total
FROM emp
WHERE coalesce(sal+comm,sal)>2300
					   
/* 11. Amosa o nome do empregado/s que máis horas traballan en cada proxecto. Amosa tamén o nome do proxecto. */

SELECT ename,p.prono
FROM emp e JOIN emppro ep ON e.empno=ep.empno
JOIN pro p ON p.prono=ep.prono
WHERE hours=(SELECT max(hours)
			 FROM emppro
			 WHERE prono=p.prono)
ORDER BY prono

/* 12. Para cada departamento, amosa os empregados que traballan en proxectos controlados por el. Amosa o nome
do departamento e o código dos empregados. */

SELECT dname, ep.empno
FROM dept d JOIN pro p ON d.deptno = p.deptno
JOIN emppro ep on p.prono = ep.prono

/* 13. Para cada supervisor, amosa o subordinado(s) que máis gaña. */

SELECT e.ename jefe, a.ename subordinado, a.sal
FROM emp e JOIN emp a ON e.empno=a.mgr 
WHERE e.sal>=(SELECT max(sal)
		   FROM emp
		   WHERE mgr=a.empno)

/* 14. Obtén os datos dos empregados que cobren os dous maiores salarios da empresa. (Nota: Procura facer a
consulta de forma que sexa doado obter os empregados dos N maiores salarios). */
		   
SELECT ename,sal
FROM emp e
WHERE 2>(SELECT count(*)
		 FROM emp 
		 WHERE sal> e.sal)
		 
/* 15. Obtén as localidades que non teñen departamentos sen empregados e nas que traballen ao menos catro
empregados. Indica tamén o número de empregados que traballan nesas localidades. (Nota: Por exemplo, pode
que na Coruña existan dous departamentos, un con máis de catro empregados e outro sen empregados; en tal
caso, A Coruña non debe aparecer no resultado, posto que ten un departamento SEN EMPREGADOS, a pesar
de ter outro con empregados e ter máis de catro empregados EN TOTAL. ATENCIÓN, a restrición de que teñen
que ser catro empregados refírese á totalidade dos departamentos da localidade). */
		 
SELECT loc, count(*)
FROM emp e JOIN dept d on e.deptno = d.deptno
WHERE loc NOT IN (SELECT loc
FROM dept
WHERE deptno NOT IN (SELECT deptno
FROM emp))
GROUP BY loc
HAVING count(*)>=4
		 
/* 16. Para cada empregado cuxo nome acabe en S, número, nome e contar cantos gañan menos que el (se non hai
ningún, debe aparecer un 0). */

SELECT e.ename,e.empno,count(a.ename)
FROM emp e JOIN emp a ON e.sal>a.sal
WHERE e.ename LIKE '%S'
GROUP BY e.ename,e.empno
ORDER BY e.empno

/* 17. Para cada departamento que teña polo menos dous empregados sen comisión, mostra o nome do
departamento e cantos empregados ten en total (con e sen comisión). */

SELECT d.dname Dept,count(comm) Con_comision,count(*)-count(comm) Sin_comision, count(*) Total
FROM emp e JOIN dept d ON e.deptno=d.deptno
WHERE 2<=(SELECT count(*)-count(comm)
		  FROM emp)
GROUP BY d.dname

/* 18. Mostra para cada proxecto o seu código e, dos empregados que traballan en dito proxecto, o nome do
empregado que máis gaña de cada posto de traballo. */

SELECT prono,ename,job
FROM emp e JOIN emppro ep ON e.empno=ep.empno
WHERE sal=(SELECT max(sal)
		   FROM emp e1 JOIN emppro ep1 ON e1.empno=ep1.empno
		   WHERE ep1.prono=ep.prono AND e1.job=e.job)
GROUP BY prono,ename,job

/* 19. Amosa o nome e o traballo dos empregados que son supervisores e que teñen o mesmo traballo que todos os
seus subordinados. */

SELECT e.ename Jefe,e.job,a.ename Subordinado,a.job
FROM emp e JOIN emp a ON e.empno=a.mgr
WHERE e.job=a.job

/* 20. Mostra o nome dos departamentos con máis de tres empregados dos cales ao menos dous sexan xefes. */

SELECT dname
FROM emp e JOIN dept d ON e.deptno = d.deptno
WHERE (SELECT count(*)
	   FROM emp
	   WHERE empno IN (SELECT mgr FROM emp) AND deptno = e.deptno) >= 2
GROUP BY e.deptno, dname
HAVING count(*)>3
