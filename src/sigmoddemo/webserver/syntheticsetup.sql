drop table if exists  qlogs cascade;
CREATE TABLE qlogs (
	expid int,
	qid int,
	type text, 
	mode text,
	algorithm text,
	priority int,
	correct int,
	query text,
	vals text,
	attrs text,
	setc text,
	wherec text
);

	  
drop table if exists qfixconfig cascade;
CREATE TABLE qfixconfig (
	expid int primary key,
	compl_list text,
	algorithm text,
	workload text
);
insert into qfixconfig values (0,'','','');

drop table if exists stats cascade;
CREATE TABLE stats (
	expid int,
	algorithm text, 
	exetime real,
	precision real,
	recall real
);
	

drop table if exists taxes cascade;	  
CREATE TABLE taxes (
	employee_id int primary key,
	income real,
	tax_rate real,
	pay real
);

drop table if exists oorder cascade;
CREATE TABLE oorder (
	o_w_id int NOT NULL,
	o_d_id int NOT NULL,
	o_id int NOT NULL,
	o_c_id int NOT NULL,
	o_carrier_id int DEFAULT NULL,
	o_ol_cnt decimal(2,0) NOT NULL,
	o_all_local decimal(1,0) NOT NULL,
	PRIMARY KEY (o_w_id,o_d_id,o_id),
	UNIQUE (o_w_id,o_d_id,o_c_id,o_id)
);

drop table if exists error_tracker cascade;
CREATE TABLE error_tracker (
	expid int PRIMARY KEY
);
	
drop table if exists subscriber cascade;
CREATE TABLE subscriber (
	s_id INTEGER NOT NULL PRIMARY KEY,
	bit_1 SMALLINT,
	bit_2 SMALLINT,
	bit_3 SMALLINT,
	bit_4 SMALLINT,
	bit_5 SMALLINT,
	bit_6 SMALLINT,
	bit_7 SMALLINT,
	bit_8 SMALLINT,
	bit_9 SMALLINT,
	bit_10 SMALLINT,
	hex_1 SMALLINT,
	hex_2 SMALLINT,
	hex_3 SMALLINT,
	hex_4 SMALLINT,
	hex_5 SMALLINT,
	hex_6 SMALLINT,
	hex_7 SMALLINT,
	hex_8 SMALLINT,
	hex_9 SMALLINT,
	hex_10 SMALLINT,
	byte2_1 SMALLINT,
	byte2_2 SMALLINT,
	byte2_3 SMALLINT,
	byte2_4 SMALLINT,
	byte2_5 SMALLINT,
	byte2_6 SMALLINT,
	byte2_7 SMALLINT,
	byte2_8 SMALLINT,
	byte2_9 SMALLINT,
	byte2_10 SMALLINT,
	msc_location INTEGER,
	vlr_location INTEGER
);
