conn / as sysdba
DROP USER TRAM_ADMIN cascade;
-- PROMPT 'Creating Tablespaces'

-- CREATE TABLESPACE ts_tram_system DATAFILE 'C:\ORACLEXE\APP\ORACLE\ORADATA\XE\ts_tram_01.dbf' SIZE 200M AUTOEXTEND ON;
-- PROMPT '.... Tablespace creation completed.

PROMPT 'Creating user'
CREATE USER TRAM_ADMIN IDENTIFIED BY TRAM DEFAULT TABLESPACE ts_tram_system QUOTA UNLIMITED ON ts_tram_system;
GRANT CREATE SESSION TO TRAM_ADMIN;
GRANT CREATE TABLE TO TRAM_ADMIN;
GRANT CREATE VIEW TO TRAM_ADMIN;
GRANT RESOURCE TO TRAM_ADMIN;

PROMPT '.... User created with required privileges'

-- Connect as the schema user
PROMPT 'Connecting as STEP user'
conn TRAM_ADMIN/TRAM

PROMPT '....employee table is in creation'

CREATE TABLE employee (
	employee_id 	NUMBER(3),
	employee_name 	VARCHAR(20),
	contact_no 		VARCHAR(15)
);

PROMPT '....employee table is created'

PROMPT '....routes table is in creation'

CREATE TABLE routes (
	route_id 			NUMBER(3),
	start_station 		NUMBER(3),
	end_station	        NUMBER(3)
	-- TRAMS 				varchar(32, ARRAY[10]) NOT NULL
);

PROMPT '....routes table is created'

PROMPT '....junction table is in creation'

CREATE TABLE junction (
	junction_id 	NUMBER(3),
	junction_name 	VARCHAR(30)
);

PROMPT '....junction table is created'

PROMPT '....monthly table is in creation'

CREATE TABLE monthly (
	monthly_id 	NUMBER(3),
	route_id 	VARCHAR(30),
	issue_date  DATE,
	valid_till	DATE
);

PROMPT '....monthly table is created'

PROMPT '....schedule table is in creation'

CREATE TABLE schedule (
	schedule_id 	NUMBER(3),
	train_id 		NUMBER(5),
	route_id  		Number(3)
);

PROMPT '....schedule table is created'
