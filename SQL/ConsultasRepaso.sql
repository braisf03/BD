/* EJERCICIOS 1 */

/* 1.Mostra os postos de traballo que hai en cada departamento (código de dept e
nome do posto de traballo). Non deben aparecer repetidos. */

SELECT DISTINCT deptno, job 
FROM emp 

/* 2.Mostra os códigos de empregados que son xefes. No resultado non deben
aparecer filas con nulos. */

SELECT DISTINCT mgr 
FROM emp 
WHERE mgr IS NOT NULL 

/* 3. Mostra as cidades onde se executan proxectos controlados polo departamento 30.
Non deben aparecer repetidos no resultado. */

SELECT DISTINCT loc 
FROM pro 
WHERE deptno = 30

/* 4. Mostra empregados que non teñen xefe. */

SELECT ename
FROM emp 
WHERE mgr IS NULL 

/* 5. Mostra empregados que teñan xefe e que gañen (incluíndo salario e comisión)
máis de 2500. */

SELECT DISTINCT ename
FROM emp 
WHERE mgr IS NOT NULL AND (sal+comm>2500 OR sal>2500)

/* 6. Mostra os empregados cuxo nome comeza por ‘S’. */

SELECT ename
FROM emp 
WHERE ename LIKE 'S%'

/* 7. Mostra os empregados que gañan (incluíndo salario e comisión) entre 1500 e 2500
euros. */

SELECT ename 
FROM emp 
WHERE ((sal+comm BETWEEN 1500 AND 2500) OR (sal BETWEEN 1500 AND 2500))

/* 8. Mostra os empregados que son ‘CLERK’, ‘SALESMAN’ ou ‘ANALYST’ e gañan
(incluíndo salario e comisión) máis de 1250. */

SELECT ename 
FROM emp 
WHERE job IN ('CLERK','SALESMAN','ANALYST') AND ((sal+comm>1250) OR (sal>1250)) 

/* EJERCICIOS 2 */

/* 1. Mostra cantos empregados hai e a canto ascenden os seus ingresos (sumando os
de todos e incluíndo salario e comisión) que sexan SALESMAN ou CLERK. */

SELECT count(empno), sum(coalesce(sal+comm,sal))
FROM emp

/* 2. Cantos empregados teñen comisión, cantos non teñen comisión, a canto ascende
o salario medio, e a canto ascende a comisión media. */

SELECT count(comm), count(*)-count(comm), avg(sal), avg(comm)
FROM emp

/* 3. Empregados cun nome de máis de 5 letras. */

SELECT ename 
FROM emp 
WHERE LENGTH(ename)>5 

/* 4. Cantos empregados traballan para os departamentos 20 e 30, e cantos traballos
distintos se desempeñan neses departamentos. */

SELECT DISTINCT count(empno), count(DISTINCT job)
FROM emp
WHERE deptno IN ('20','30')

/* 5. Cantos empregados teñen xefe, cantos son xefes e cantos non son xefes. */

SELECT count(mgr), count(DISTINCT mgr), count(empno)-count(DISTINCT mgr)
FROM emp 

/* 6. Cantos son os ingresos (salario máis comisión) medios dos empregados
contratados despois do 01-08-1981. */

SELECT avg(coalesce(sal+comm,sal))
FROM emp 
WHERE hiredate>='01-08-1981'

/* EJERCICIOS 3 */

/* 1. Cantos empregados hai en cada departamento, cantos teñen comisión, cantos non
teñen comisión e cales son os ingresos medios (incluíndo salario e comisión). */

SELECT deptno, count(*), count(comm), count(*)-count(comm),avg(coalesce(sal+comm,sal))
FROM emp 
GROUP BY deptno

/* 2. Mostra os departamentos que teñen empregados con comisión. Non pode haber
valores repetidos. */

SELECT deptno
FROM emp
WHERE comm IS NOT NULL
GROUP BY deptno

/* 3. Para cada departamento mostra a comisión media; se non ten empregados con
comisión, débese indicar cun 0. */

SELECT deptno, avg(coalesce(comm,0))
FROM emp
GROUP BY deptno

/* 4. Para cada departamento mostra cantos postos de traballo distintos desempeñan
os seus traballadores. */

SELECT DISTINCT deptno, count(DISTINCT job)
FROM emp
GROUP BY deptno
ORDER BY deptno

/* 5. Para cada departamento mostra cantos empregados hai de cada posto de traballo. */

SELECT deptno, job ,count(job)
FROM emp
GROUP BY deptno, job
ORDER BY deptno

/* 6. Mostra cantos empregados teñen uns ingresos superiores a 2500 € en cada
departamento. */

SELECT deptno, count(*)
FROM emp 
WHERE coalesce(sal+comm,sal)>2500
GROUP BY deptno
ORDER BY deptno

/* EJERCICIOS 4 */

/* 1. Para cada departamento mostra cantos empregados teñen uns ingresos
(sal+comm) superiores a 2500 €. */

SELECT deptno, count (*)
FROM emp
WHERE coalesce(sal+comm,sal)>2500
GROUP BY deptno
ORDER BY deptno

/* 2. Mostra os departamentos cuns ingresos medios superiores aos 2500 €. Mostra
para cada un, cantos empregados teñen. */

SELECT deptno, count(*)
FROM emp 
GROUP BY deptno
HAVING avg(coalesce(sal+comm,sal))>2500

/* 3. Departamentos con, polo menos, dous ‘MANAGER’. */

SELECT deptno
FROM emp 
WHERE job ='MANAGER'
GROUP BY deptno
HAVING count(*)>2

/* 4. Departamentos con, polo menos, dous empregados con comisión. Para cada
departamento mostra cantos empregados ten (en total) e cantos con comisión. */

SELECT deptno, count(*), count(comm)
FROM emp 
GROUP BY deptno
HAVING count(comm)>2

/* 5. Departamentos con, polo menos, dous empregados co mesmo posto de traballo.
Non poden aparecer repetidos. */

SELECT DISTINCT deptno
FROM emp 
GROUP BY deptno,job
HAVING count(*)>2

/* EJERCICIOS 5 */

/* 1. Para cada proxecto mostra o seu nome e o nome do departamento que os
controla. */

SELECT pro.pname, dept.dname
FROM pro JOIN dept
ON pro.deptno = dept.deptno

/* 2. Para cada empregado mostra o seu nome e os códigos de proxectos para os que
traballa. */

SELECT DISTINCT emp.ename, pro.prono
FROM emp JOIN pro 
ON emp.deptno=pro.deptno
ORDER BY prono

/* 3. Para cada empregado mostra o seu nome e os códigos de proxectos para os que
traballa. Se hai empregados que non traballan en proxectos, estes deben aparecer
co código de proxecto a nulo. */

SELECT emp.ename, pro.prono
FROM emp LEFT JOIN pro 
ON emp.deptno=pro.deptno
ORDER BY prono

/* 4. Para cada empregado mostra o nome do seu xefe; se non ten xefe, mostra un nulo
no nome do xefe. */

SELECT e.ename, o.ename
FROM emp e LEFT JOIN emp o
ON e.mgr=o.empno
ORDER BY e.mgr

/* 5. Para cada empregado mostra o seu nome, o nome do seu xefe e o departamento
para o que traballa o seu xefe. */

SELECT e.ename, o.ename, o.deptno
FROM emp e LEFT JOIN emp o
ON e.mgr=o.empno
ORDER BY o.deptno

/* 6. Devolve os empregados que teñen un salario máis alto que o seu xefe. */

SELECT e.ename, e.sal, j.ename, j.sal
FROM emp e JOIN emp j ON e.mgr=j.empno
WHERE e.sal>j.sal

/* EJERCICIOS 6 */

/* 1. Para cada empregado mostra o seu nome e cantas horas traballou en proxectos. */

SELECT ename, sum(hours) 
FROM emp e JOIN emppro ep 
ON e.empno=ep.empno
GROUP BY ename

/*2. Para cada departamento, mostra o seu nome e cantos empregados ten. */

SELECT DISTINCT dept.dname, count(ename)
FROM emp JOIN dept 
ON emp.deptno=dept.deptno
GROUP BY dept.dname

/*3. Para cada xefe, mostra o seu nome e cantos subordinados ten.*/

SELECT DISTINCT j.ename,count(e.ename) 
FROM emp e RIGHT JOIN emp j 
ON e.mgr = j.empno 
GROUP BY j.ename
ORDER BY j.ename

/*4. Mostra o nome de proxectos onde se traballou (en total, todos os empregados)
máis de 15 horas. */

SELECT ep.prono, sum(ep.hours)
FROM emp e JOIN emppro ep 
ON e.empno=ep.empno
GROUP BY ep.prono
ORDER BY ep.prono

/*5. Mostra os departamentos (nome) que controlan máis de dous proxectos. */

SELECT dept.dname, count(pname)
FROM pro JOIN dept
ON pro.deptno=dept.deptno
GROUP BY dept.dname
HAVING count(*)>2

/*6. Mostra os departamentos (nome) onde hai polo menos dous empregados co
mesmo posto de traballo. Non deben aparecer repetidos. */

SELECT DISTINCT dept.dname, emp.job
FROM emp RIGHT JOIN dept
ON emp.deptno = dept.deptno
GROUP BY dept.dname, emp.job
HAVING count(emp.job)>=2

/*7. Para cada departamento mostra o seu nome e cantos empregados ten; se non ten
ningún, hai que indicalo cun 0. */

SELECT dept.dname, count(emp.ename)
FROM emp RIGHT JOIN dept
ON emp.deptno=dept.deptno
GROUP BY dept.dname
ORDER BY dept.dname

/*8. Para cada empregado mostra as horas que traballou en proxectos; se non traballou
en ningún, hai que indicalo cun 0. */

SELECT DISTINCT emp.ename, coalesce(sum(emppro.hours),0)
FROM emp LEFT JOIN emppro
ON emp.empno = emppro.empno
GROUP BY emp.ename

/*9. Para cada xefe, cantos subordinados gañan máis ca el; se non o gaña ningún, hai
que indicalo cun 0. */

SELECT DISTINCT e.ename,count(j.ename)
FROM emp e LEFT JOIN emp j
ON e.empno=j.mgr
AND j.sal>e.sal
GROUP BY e.ename,e.empno

/* EJERCICIOS 7 */

/* 1. Empregados que teñen un salario maior ao salario medio da empresa. */

SELECT *
FROM emp 
WHERE sal > (SELECT avg(sal)
			 FROM emp)
ORDER BY deptno

/* 2. Para cada departamento, mostra cantos empregados ten que gañen máis do
salario medio da empresa. Mostra o nome do departamento. */

SELECT DISTINCT dept.dname,count(*)
FROM emp JOIN dept
ON emp.deptno=dept.deptno
WHERE sal>(SELECT avg(sal)
			FROM emp)
GROUP BY dept.dname

/* 3. Empregados que son xefe. Mostra o seu nome. */

SELECT DISTINCT e.ename
FROM emp e JOIN emp j 
ON e.empno=j.mgr 

/* 4. Empregados que non son xefe. Mostra o seu nome. */

SELECT ename 
FROM emp  
WHERE empno NOT IN (SELECT DISTINCT mgr 
					FROM emp
					WHERE mgr IS NOT NULL)

/* 5. Mostra o(s) empregado(s) (nome) co salario máis alto. */

SELECT ename
FROM emp 
WHERE sal=(SELECT max(sal)
			FROM emp)

/* 6. Mostra o departamento (nome) coa suma de salarios máis alta. */

SELECT dname
FROM emp JOIN dept
ON emp.deptno=dept.deptno
GROUP BY dept.deptno,dept.dname
HAVING sum(sal)=(SELECT max(sum(sal))
				 FROM emp
				 GROUP BY deptno)

/* 7. Para os departamentos que teñen empregados con comisión, mostra cantos
empregados teñen comisión, e cantos non. Mostra o nome do departamento. */

SELECT dept.dname,count(comm),count(*)-count(comm)
FROM emp JOIN dept
ON emp.deptno=dept.deptno
WHERE emp.deptno IN (SELECT deptno
					 FROM emp
					 WHERE comm IS NOT NULL)
GROUP BY dept.dname

/* EJERCICIOS 8 */

/* 1. Mostra o(s) empregado(s) co salario máis alto de cada departamento. */

SELECT ename,deptno,sal
FROM emp a
WHERE sal = (SELECT max(sal)
			 FROM emp
			 WHERE deptno=a.deptno)

/* 2. Mostra o código do(s) empregado(s) que máis horas traballa(n) en cada proxecto. */

SELECT empno, prono, hours
FROM emppro e
WHERE hours=(SELECT max(hours)
			 FROM emppro
			 WHERE prono=e.prono)
ORDER BY prono

/* 3. Mostra o nome do(s) empreado(s) que máis horas traballa(n) en cada proxecto. */

SELECT e.ename,ep.hours,ep.prono
FROM emp e JOIN emppro ep
ON e.empno=ep.empno
WHERE hours =(SELECT max(hours)
			  FROM emppro
			  WHERE prono=ep.prono)
			  ORDER BY prono

/* 4. Mostra o nome do(s) empregado(s) que máis horas traballa(n) en cada proxecto.
Mostra tamén o nome do proxecto. */

SELECT e.ename,ep.hours,p.prono
FROM emp e JOIN emppro ep ON e.empno=ep.empno 
JOIN pro p ON p.deptno=e.deptno
WHERE hours =(SELECT max(hours)
			  FROM emppro
			  WHERE prono=p.prono)
ORDER BY p.prono
			  

/* 5. Para cada departamento mostra o seu nome e cantos empregados dese
departamento teñen un salario maior ao salario medio do seu departamento. */

SELECT d.dname,count(*)
FROM emp e JOIN dept d 
ON e.deptno=d.deptno
WHERE e.sal>(SELECT avg(sal)
			 FROM emp 
			 WHERE deptno=e.deptno)
GROUP BY d.dname,e.deptno
ORDER BY e.deptno

/*6. Para cada departamento mostra o seu nome e cantos empregados gañan máis que
o seu xefe. */

SELECT d.dname,count(*)
FROM emp e JOIN emp ep 
ON e.empno=ep.mgr
		   JOIN dept d 
		   ON d.deptno=e.deptno
WHERE ep.sal>e.sal
GROUP BY d.dname
