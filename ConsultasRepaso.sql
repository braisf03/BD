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
