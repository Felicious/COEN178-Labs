Create table ItemOrder (orderNo VARCHAR(5) Primary key, qty Integer);

CREATE OR REPLACE TRIGGER ItemOrder_after_insert_trig
AFTER INSERT
	ON ItemOrder   
	FOR EACH ROW
DECLARE
    v_quantity Integer;
BEGIN
	SELECT qty
	INTO v_quantity
    FROM ItemOrder
    WHERE orderNo = 'o1';
END;
/
Show Errors;

Insert into ItemOrder values ('o1',100);

CREATE TABLE Course(
    courseNo   INTEGER PRIMARY KEY,
    courseName VARCHAR(20)
);
CREATE TABLE Course_Prereq(
    courseNo   INTEGER ,
    prereqNo Integer,
	Foreign Key(prereqNo) references Course (courseNo)
);

insert into Course values (10,'C++');
insert into Course values (11,'Java');
insert into Course values (12,'Python');
insert into Course values (121,'Web');
insert into Course values (133,'Software Eng');

/*Enforce: a course cannot have more than 2 prereqs */
CREATE OR REPLACE TRIGGER LimitTest
    BEFORE INSERT OR UPDATE ON Course_Prereq
    FOR EACH ROW  -- A row level trigger
DECLARE
    v_MAX_PREREQS CONSTANT INTEGER := 2;     
	v_CurNum INTEGER;
BEGIN
	BEGIN
		SELECT COUNT(*) INTO v_CurNum FROM Course_Prereq
		WHERE courseNo = :new.CourseNo Group by courseNo;
		EXCEPTION
			-- Before you enter the first row, no data is found
			WHEN no_data_found THEN
			DBMS_OUTPUT.put_line('not found'); 
				v_CurNum := 0;
	END;
	if v_curNum > 0 THEN
		IF v_CurNum + 1 > v_MAX_PREREQS THEN
		RAISE_APPLICATION_ERROR(-20000,'Only   2   prereqs   for course');
		END IF;
	END IF;
END;
/
SHOW ERRORS;

insert into Course_Prereq values (121,11);
insert into Course_Prereq values (121,10);

insert into Course_Prereq values (121,12);

insert into Course_Prereq values (133,12);
Select * from Course_Prereq;

update COURSE_PREREQ
set courseno = 121 where courseno= 133;

Delete from Course_Prereq;

/* Compound trigger */
CREATE OR REPLACE TRIGGER LimitTest
FOR INSERT
ON Course_Prereq
COMPOUND TRIGGER
 /* Declaration Section*/
 v_MAX_PREREQS CONSTANT INTEGER := 2;
    v_CurNum INTEGER := 1;
    v_cno INTEGER; 
 --ROW level
 BEFORE EACH ROW IS
 BEGIN
 	v_cno := :NEW.COURSENO;
 END BEFORE EACH ROW; 
 --Statement level
 AFTER STATEMENT IS
 BEGIN
 SELECT COUNT(*) INTO v_CurNum FROM Course_Prereq 
 	WHERE courseNo = v_cno Group by courseNo;
 	IF v_CurNum  > v_MAX_PREREQS THEN
 		RAISE_APPLICATION_ERROR(-20000,'Only 2 prereqs for 
 		course');
 			END IF;
 END AFTER STATEMENT; 
 END ;
 /
 SHOW ERRORS;

insert into Course_Prereq values (121,11);
insert into Course_Prereq values (121,10);
insert into Course_Prereq values (121,12);
insert into Course_Prereq values (133,12);

update COURSE_PREREQ
set courseno = 121 where courseno= 133;