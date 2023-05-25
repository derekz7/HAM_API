create database hamdb
go
use hamdb
go


create table tbl_role(
	id int primary key identity(0,1),
	role_name nvarchar(100),
)
go

create table tbl_department(
	id int primary key identity(0,1),
	name nvarchar(200),
	description nvarchar(500)
)
go

create table tbl_service(
	id nvarchar(20) primary key,
	name nvarchar(200),
	description nvarchar(300),
	price varchar(20)
)
go


create table tbl_user(
	id nvarchar(20) primary key,
	email nvarchar(20),
	pw nvarchar(20),
	role_id int,
	name nvarchar(100),
	dob date,
	p_number nvarchar(10),
	img text,
	constraint fk_role_id foreign key (role_id) references tbl_role(id)
)
go
create table tbl_patient(
	id nvarchar(20) primary key,
	pt_name nvarchar(100),
	dob date,
	gender char,
	job nvarchar(100),
	address nvarchar(300),
	user_id nvarchar(20),
	constraint fk_userid foreign key (user_id) references tbl_user(id)
)
go

create table tbl_doctor(
	id nvarchar(20) primary key,
	name nvarchar(100),
	room nvarchar(100),
	dep_id int,
	user_id nvarchar(20),
	constraint fk_dep_id foreign key (dep_id) references tbl_department(id),
	constraint fk_user_id foreign key (user_id) references tbl_user(id)
)
go

create table tbl_booking(
	id nvarchar(20) primary key,
	order_num int,
	date date,
	time nvarchar(20),
	price nvarchar(20),
	status nvarchar(100),
	pt_id nvarchar(20),
	user_id nvarchar(20),
	dc_id nvarchar(20),
	sv_id nvarchar(20),
	constraint fk_pt_id foreign key (pt_id) references tbl_patient(id),
	constraint fk_uid foreign key (user_id) references tbl_user(id),
	constraint fk_dc_id foreign key (dc_id) references tbl_doctor(id),
	constraint fk_sv_id foreign key (sv_id) references tbl_service(id),
)
go

create table tbl_prescription(
	id nvarchar(20) primary key,
	disease nvarchar(100),
	symptoms nvarchar(300),
	medicines nvarchar(500),
	ptu_medicines nvarchar(1000),
	user_id nvarchar(20),
	dc_id nvarchar(20),
	constraint fk_userid1 foreign key (user_id) references tbl_user(id),
	constraint fk_dcid foreign key (dc_id) references tbl_doctor(id)
)
go

drop database hapdb
delete tbl_role
ALTER TABLE tbl_role ALTER COLUMN role_name nvarchar(100);

select * from tbl_user
insert into tbl_role (role_name) values ('Administrator')
insert into tbl_role (role_name) values ('Doctor')
insert into tbl_role (role_name) values ('User')