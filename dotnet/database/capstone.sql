USE master
GO

--drop database if it exists
IF DB_ID('final_capstone') IS NOT NULL
BEGIN
	ALTER DATABASE final_capstone SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE final_capstone;
END

CREATE DATABASE final_capstone
GO

USE final_capstone
GO

--create tables
CREATE TABLE users (
	user_id int IDENTITY(1,1) NOT NULL,
	username varchar(50) NOT NULL,
	password_hash varchar(200) NOT NULL,
	salt varchar(200) NOT NULL,
	user_role varchar(50) NOT NULL,
	organization varchar(100) NOT NULL,
	location varchar(100) NOT NULL,
	name varchar (100) NOT NULL,
	phone varchar (50) NOT NULL,
    email varchar (100) NOT NULL,
	CONSTRAINT PK_user PRIMARY KEY (user_id)
)

--populate default data

-- user/password
INSERT INTO users (username, password_hash, salt, user_role, organization, location, name, phone, email) VALUES ('user','Jg45HuwT7PZkfuKTz6IB90CtWY4=','LHxP4Xh7bN0=','admin', 'company', '12345 road street', 'Guy Person', '5558675309', 'email@email.com');

--admin/password
INSERT INTO users (username, password_hash, salt, user_role, organization, location, name, phone, email) VALUES ('admin','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','admin', 'charity', '678910 street road', 'Person Mann', '5555555555', 'realmail@fakeemail.com');

GO

CREATE TABLE [events] (
	event_id int IDENTITY(1000,1) NOT NULL,
	name varchar(200) NOT NULL,
	description varchar(4000),
	img_url varchar(max),
	start_time DATETIME NOT NULL,
	end_time DATETIME NOT NULL,
	city varchar(100) NOT NULL,
	state varchar(100) NOT NULL,
	zip int NOT NULL,
	address varchar(100) NOT NULL,
	user_id int NOT NULL,
	--add property for user who created event
	CONSTRAINT PK_event PRIMARY KEY (event_id),
	CONSTRAINT  FK_event FOREIGN KEY (user_id) REFERENCES users(user_id)
		
)

INSERT INTO events (name, description, img_url, start_time, end_time, city, state, zip, address, user_id)
VALUES ();

INSERT INTO events (name, description, img_url, start_time, end_time, city, state, zip, address, user_id)
VALUES ();

INSERT INTO events (name, description, img_url, start_time, end_time, city, state, zip, address, user_id)
VALUES ();

INSERT INTO events (name, description, img_url, start_time, end_time, city, state, zip, address, user_id)
VALUES ();

GO

CREATE TABLE event_tags (
	event_id int FOREIGN KEY REFERENCES [events](event_id),
	tag_name varchar(50) 

	CONSTRAINT PK_event_tags PRIMARY KEY (tag_name, event_id)
)

INSERT INTO event_tags (event_id, tag_name) VALUES ();
INSERT INTO event_tags (event_id, tag_name) VALUES ();
INSERT INTO event_tags (event_id, tag_name) VALUES ();
INSERT INTO event_tags (event_id, tag_name) VALUES ();
INSERT INTO event_tags (event_id, tag_name) VALUES ();

GO
