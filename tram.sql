conn / as sysdba
DROP USER TRAM_ADMIN cascade;
clear screen
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

PROMPT '....monthly_holder table is in creation'

CREATE TABLE monthly_holder (
	monthly_holder_id 		NUMBER(3),
	monthly_holder_name		VARCHAR(20),
	CONSTRAINT monthly_holder_pk PRIMARY KEY(monthly_holder_id)
);

PROMPT '....monthly_holder table is created'

PROMPT '....employee table is in creation'

CREATE TABLE employee (
	employee_id 	NUMBER(3),
	employee_name 	VARCHAR(20),
	contact_no 		VARCHAR(15),
	CONSTRAINT employee_pk PRIMARY KEY(employee_id)
);

PROMPT '....employee table is created'

PROMPT '....customer table is in creation'

CREATE TABLE customer (
	customer_id 	NUMBER(3),
	customer_name 	VARCHAR(20),
	contact_no 		VARCHAR(15),
	--other details also has to be captured
	CONSTRAINT customer_pk PRIMARY KEY(customer_id)
);

PROMPT '....employee table is created'

PROMPT '....junction table is in creation'

CREATE TABLE junction (
	junction_id 	NUMBER(3),
	junction_name 	VARCHAR(30),
	CONSTRAINT junction_pk PRIMARY KEY(junction_id)
);

PROMPT '....junction table is created'

PROMPT '....station table is in creation'

CREATE TABLE station (
	station_id 		NUMBER(3),
	station_name	VARCHAR(20),
	CONSTRAINT station_pk PRIMARY KEY(station_id)
);

PROMPT '....station table is created'

PROMPT '....monthly table is in creation'

CREATE TABLE monthly (
	monthly_id 	NUMBER(3),
	route_id 	VARCHAR(30),
	issue_date  DATE,
	valid_till	DATE,
	CONSTRAINT monthly_pk PRIMARY KEY(monthly_id)
);

PROMPT '....monthly table is created'

PROMPT '....routes table is in creation'

CREATE TABLE routes (
	route_id 			NUMBER(3),
	start_station 		NUMBER(3),
	end_station	        NUMBER(3),
	CONSTRAINT route_pk PRIMARY KEY(route_id),
	CONSTRAINT start_fk FOREIGN KEY (start_station) REFERENCES station(station_id),
	CONSTRAINT end_fk FOREIGN KEY (end_station) REFERENCES station(station_id)  
);

PROMPT '....routes table is created'

PROMPT '....deport table is in creation'

CREATE TABLE deport (
	deport_id 	NUMBER(3),
	station_id 	NUMBER(5),
	capacity	NUMBER(5),
	CONSTRAINT deport_pk PRIMARY KEY(deport_id),
	CONSTRAINT deport_id_fk FOREIGN KEY (deport_id) REFERENCES station(station_id)
);

PROMPT '....deport table is created'

PROMPT '....tram_type table is in creation'

CREATE TABLE tram_type (
	tram_type_id 		NUMBER(5),
	tram_type_name		VARCHAR(20),
	fare_chart_id		NUMBER(5),
	CONSTRAINT tram_type_pk PRIMARY KEY(tram_type_id)
);

PROMPT '....tram_type table is created'

PROMPT '....tram table is in creation'

CREATE TABLE tram (
	tram_id 		NUMBER(5),
	tram_name		VARCHAR(20),
	type_id 		NUMBER(5),
	fare_chart_id 	VARCHAR(5),
	on_road_date 	DATE,
	CONSTRAINT tram_pk PRIMARY KEY(tram_id),
	-- CONSTRAINT fare_chart_fk FOREIGN KEY (end_station) REFERENCES station(station_id),
	CONSTRAINT tram_type_fk FOREIGN KEY (type_id) REFERENCES tram_type(tram_type_id)    
);

PROMPT '....tram table is created'

PROMPT '....ticket table is in creation'

CREATE TABLE ticket (
	ticket_id 	NUMBER(3),
	tram_id 	NUMBER(5),
	capacity	NUMBER(5),
	mfd			DATE,
	valid_till	DATE,
	CONSTRAINT ticket_id_pk PRIMARY KEY(ticket_id),
	CONSTRAINT tram_id_fk FOREIGN KEY (tram_id) REFERENCES tram(tram_id)	
);

PROMPT '....ticket table is created'

PROMPT '....schedule table is in creation'

CREATE TABLE schedule (
	schedule_id 	NUMBER(3),
	tram_id 		NUMBER(5),
	route_id  		Number(3),
	CONSTRAINT schedule_pk PRIMARY KEY(schedule_id),
	CONSTRAINT tram_fk FOREIGN KEY (tram_id) REFERENCES station(station_id),
	CONSTRAINT route_fk FOREIGN KEY (route_id) REFERENCES station(station_id)
);

PROMPT '....schedule table is created'
