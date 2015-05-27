@http://profs.info.uaic.ro/~vcosmin/pagini/resurse_psgbd/Script/Script.sql
/
DROP TYPE empraises;
DROP TYPE empraisesdates;
CREATE OR REPLACE TYPE EmpRaiseValueType AS OBJECT(
  empno NUMBER,
  marire NUMBER);
/
CREATE TYPE empraises IS TABLE OF EmpRaiseValueType;
/
CREATE OR REPLACE TYPE EmpRaiseDateType AS OBJECT(
  newsal NUMBER,
  datamarire DATE);
/
CREATE TYPE empraisesdates IS TABLE OF EmpRaiseDateType;
/
ALTER TABLE emp ADD(mariri empraisesdates default empraisesdates()) NESTED TABLE mariri STORE AS nested_mariri;
/
--Procedura 1: mariri salariale fara exceptii
CREATE OR REPLACE PROCEDURE maririSalariale(emplist IN empraises) IS
BEGIN
  FOR i IN emplist.FIRST..emplist.LAST LOOP
    UPDATE emp
    SET sal = sal + sal *((emplist(i).marire)/100)
    WHERE empno = emplist(i).empno;
    END LOOP;
END;
/
--Procedura 1: mariri salariale cu exceptii pt fiecare emp care nu e in lista
CREATE OR REPLACE PROCEDURE maririSalariale2(emplist IN empraises) IS
CURSOR c IS SELECT empno, sal FROM emp;
emp_not_found EXCEPTION;
found BOOLEAN := false;
salary emp.sal%TYPE;
BEGIN
  FOR employee in c LOOP
    salary := employee.sal;
    FOR i in emplist.FIRST..emplist.LAST LOOP
      IF emplist(i).empno = employee.empno THEN
        salary := salary + salary*((emplist(i).marire)/100);
        UPDATE emp
        SET sal = salary
        WHERE empno = emplist(i).empno;        
        INSERT INTO TABLE(SELECT mariri FROM emp WHERE empno = employee.empno)
                    VALUES((EmpRaiseDateType(salary,sysdate)));
        found := true;
      END IF;
    END LOOP;
    IF found = false THEN
    BEGIN
      RAISE emp_not_found;
      EXCEPTION
        WHEN emp_not_found THEN
          DBMS_OUTPUT.PUT_LINE('Angajatul '||employee.empno||' nu e in lista de mariri.');
    END;
    END IF;   
    found := false;    
  END LOOP;  
END;
/
-- Procedura 2: afisare mariri salariale pt. nr. mariri >= 1
CREATE OR REPLACE PROCEDURE afisareMariri IS
CURSOR e IS SELECT ename, mariri FROM emp;
BEGIN
  FOR employee IN e LOOP
    IF employee.mariri.COUNT > 0 THEN
      DBMS_OUTPUT.PUT_LINE(trim(employee.ename) || '''s raises:');
      FOR i in 1..employee.mariri.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(employee.mariri(i).newsal||' '||employee.mariri(i).datamarire);
      END LOOP;
    END IF;
  END LOOP;
END;
/
DECLARE
  raise_list empraises := empraises();
  raise_list_size NUMBER(9,0) :=5;
BEGIN
  raise_list.EXTEND(raise_list_size);
  raise_list(1) := EmpRaiseValueType(7369,10);
  raise_list(2) := EmpRaiseValueType(7369,10);
  raise_list(3) := EmpRaiseValueType(7369,10);
  raise_list(4) := EmpRaiseValueType(7521,20.5);
  raise_list(5) := EmpRaiseValueType(7902,16.3);
  maririsalariale2(raise_list);
  afisareMariri();
END;
/
