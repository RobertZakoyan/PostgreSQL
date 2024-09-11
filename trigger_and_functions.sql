-- \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\first \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
CREATE OR REPLACE FUNCTION log_updates()
returns trigger as  $$
begin 
 insert into employeeLog (id, updatedate) 
 values (New.id, Now());
 return new;
end;
$$ language plpgsql;

create or replace trigger logUpdates
after update on employee
for each row
execute function log_updates();

Insert into employee (id, name, department)
values(6,'name1','IT') 
update employee set department = 'Sales'
WHERE id = 6
select * from employee
select * from employeeLog
--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\second \\\\\\\\\\\\\\\\\\\\\\\\\\\
create table test(id int, name varchar(50));

-- converts timestemp into text 
select to_char(now(), 'YYYY-MM-DD HH24:MI:SS') AS time_stemp_into_string;

-- checks the type of given variable 
select pg_typeof(to_char(now(), 'YYYY-MM-DD HH24:MI:SS'));

-- function that will check the threshold of the rows in given table
create or replace function check_threshold()
returns trigger as $$
declare row_count int;
--TG_TABLE_NAME is  name of the table on which trigger will be run (in our case it is 'test' table)
-- we also add timestemp for our new table name for to differentiate tables
         new_table_name text := TG_TABLE_NAME || '_' || to_char(now(), 'YYYYMMDDHH24MISS');
BEGIN
  select count(*) into row_count from test;
--   checks whether rows of the given table is more than two. if so it creates new table
  if row_count > 2 then 
	execute 'create table ' || new_table_name || ' (like ' || TG_TABLE_NAME  || ' including all)';
	execute 'insert into ' || new_table_name || ' select * from ' || TG_TABLE_NAME; 
	execute 'delete from ' || TG_TABLE_NAME;
	raise notice 'Data has been transfereed into % table ',new_table_name;
	return null;
   else 
   return new;
  end if;
end;
$$ language plpgsql;
create trigger transfer_data 
after insert on test 
for each row
execute function check_threshold();

insert into test (id,name)
values(4,'name3');
select * from test

