-- calculate rectangle area
CREATE OR REPLACE FUNCTION calculateRectangleArea(length FLOAT, width FLOAT)
RETURNS FLOAT AS $$
BEGIN
    RETURN length * width;
END;
$$ LANGUAGE plpgsql;

select calculateRectangleArea(2, 5)


CREATE OR REPLACE FUNCTION calculateRectangleArea(length FLOAT, width FLOAT)
RETURNS FLOAT AS $$
DECLARE area FLOAT;
BEGIN 
	if length = width THEN
		RAISE NOTICE 'Length is equal to width';
		area := POWER(length, 2);
	ELSE
		area := length * width;
	end if;
RETURN area;
END;
$$ LANGUAGE plpgsql;

select calculateRectangleArea(5, 5);


-- Select from table

SELECT * FROM noble;

CREATE OR REPLACE FUNCTION get_winner(winning_year int)
RETURNS TABLE(year int, subject VARCHAR(50), winner VARCHAR(50)) as $$
BEGIN 
	RETURN query SELECT n.YEAR, n.subject, n.winner FROM noble n WHERE n.YEAR = winning_year;
END;
$$ LANGUAGE plpgsql;

SELECT subject, winner from
(SELECT * FROM get_winner(2014)) w;

DROP FUNCTION get_winner;

CREATE TABLE employee (
		id INT,
    name VARCHAR(50),
    department VARCHAR(50)
);


CREATE OR REPLACE FUNCTION insert_employee(
    employee_id INT,
    employee_name VARCHAR(50),
    department VARCHAR(50)
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO employee(id, name, department)
    VALUES (employee_id, employee_name, department);
END;
$$ LANGUAGE plpgsql;


SELECT * FROM employee;
SELECT insert_employee(2, 'Jhon Smith', 'Accountancy');

