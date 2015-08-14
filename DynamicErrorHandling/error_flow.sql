
--the example assumes you're using database "cozyroc"

use cozyroc

CREATE TABLE [cozyroc].[etl_errors](
	[etl_error_id] [int] IDENTITY(1,1) NOT NULL,
	[package_nm] [varchar](256) NULL,
	[database_nm] [varchar](256) NULL,
	[schema_nm] [varchar](256) NULL,
	[table_nm] [varchar](256) NULL,
	[record_id] [varchar](max) NULL,
	[record_id_dsc] [varchar](max) NULL,
	[column_nm] [varchar](256) NULL,
	[error_id] [int] NULL,
	[error_dsc] [varchar](max) NULL,
	[error_data] [varchar](max) NULL,
	[row_xml] [xml] NULL,
	[meta_orignl_load_dts] [datetime] NULL,
	[meta_load_exectn_guid] [uniqueidentifier] NULL,
 CONSTRAINT [PK_etl_errors] PRIMARY KEY CLUSTERED 
(
	[etl_error_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


CREATE TABLE [cozyroc].[etl_proxy_table](
	[THUNK_COLUMN] [int] NOT NULL,
	[meta_orignl_load_dts] [datetime] NULL,
	[meta_load_exectn_guid] [uniqueidentifier] NULL
) ON [PRIMARY]


CREATE TABLE [cozyroc].[etl_proxy_table_src](
	[THUNK_COLUMN] [int] NOT NULL
) ON [PRIMARY]


CREATE TABLE [cozyroc].[etl_proxy_table_stg](
	[THUNK_COLUMN] [int] NOT NULL,
	[meta_orignl_load_dts] [datetime] NULL,
	[meta_load_exectn_guid] [uniqueidentifier] NULL
) ON [PRIMARY]

--DROP TABLE [cozyroc].[demo_source_table]
CREATE TABLE [cozyroc].[demo_source_table](
	[employee_id] [int] IDENTITY(1,1) NOT NULL,
	[employee_guid] [uniqueidentifier] NULL,
	[email_addr] varchar(20) NULL,
	[first_nm] varchar(20) NULL,
	[last_nm] varchar(20) NULL,
	[awesomeness] [bigint] NOT NULL,
	[create_dts] [datetime] NULL DEFAULT GETDATE(),
	[modified_dts] [datetime] NULL,
 CONSTRAINT [PK_cozyroc_demo_source_table_employee_id] PRIMARY KEY CLUSTERED 
(
	[employee_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

--DROP TABLE [cozyroc].[demo_dest_table]
CREATE TABLE [cozyroc].[demo_dest_table](
	[employee_id] [int] NOT NULL,
	[employee_guid] [uniqueidentifier] NULL,
	[email_addr] varchar(15) NULL,--NOTE: intentionally made data type smaller
	[first_nm] varchar(10) NULL,--NOTE: intentionally made data type smaller
	[last_nm] varchar(10) NULL,--NOTE: intentionally made data type smaller
	[awesomeness] [int] NOT NULL,--NOTE: intentionally made data type smaller
	[create_dts] [datetime] NULL,
	[modified_dts] [datetime] NULL,
 CONSTRAINT [PK_cozyroc_demo_dest_table_employee_id] PRIMARY KEY CLUSTERED 
(
	[employee_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

truncate table [cozyroc].[demo_source_table]
insert into cozyroc.demo_source_table (employee_guid, email_addr, first_nm, last_nm, awesomeness) values (NEWID(), 'jjones@test.org', 'Jimbo', 'Jones', 25)--should be OK
insert into cozyroc.demo_source_table (employee_guid, email_addr, first_nm, last_nm, awesomeness) values (NEWID(), 'captain@test.org', 'Horatio', 'McCallister', 100000)--last name too long
insert into cozyroc.demo_source_table (employee_guid, email_addr, first_nm, last_nm, awesomeness) values (NEWID(), 'homer@test.org', 'Homer', 'Simpson', 25000)--should be OK
insert into cozyroc.demo_source_table (employee_guid, email_addr, first_nm, last_nm, awesomeness) values (NEWID(), 'marge@test.org', 'Marjorie', 'Simpson', 250000000000)--awesomeness exceeds int
insert into cozyroc.demo_source_table (employee_guid, email_addr, first_nm, last_nm, awesomeness) values (NEWID(), 'cruiser@test.org', 'Waylon', 'Smithers', 100)--email too long
insert into cozyroc.demo_source_table (employee_guid, email_addr, first_nm, last_nm, awesomeness) values (NEWID(), 'bart@test.org', 'Bartholomew', 'Simpson', 25)--first name too long
insert into cozyroc.demo_source_table (employee_guid, email_addr, first_nm, last_nm, awesomeness) values (NEWID(), 'lisasimpson@test.org', 'Lisa', 'Simpson', 25)--email too long




select * from cozyroc.cozyroc.etl_errors
select * from cozyroc.cozyroc.[demo_source_table]
select * from cozyroc.cozyroc.[demo_dest_table]


--truncate table [cozyroc].[demo_dest_table]

