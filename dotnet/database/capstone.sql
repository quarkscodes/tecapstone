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
	user_role varchar(50) NOT NULL
	CONSTRAINT PK_user PRIMARY KEY (user_id)
)

--populate default data

-- Robert/password
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('user','Jg45HuwT7PZkfuKTz6IB90CtWY4=','LHxP4Xh7bN0=','user');

--Nancy/password
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('admin','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','admin');

GO

CREATE TABLE events (
	event_id int IDENTITY(1000,1) NOT NULL,
	name varchar(200) NOT NULL,
	description varchar(4000),
	img_url varchar(max),
	start_time DATETIME NOT NULL,
	end_time DATETIME NOT NULL,
	--tag placeholder, make conjoined table
	tag varchar(50) NOT NULL,
	location varchar(1000) NOT NULL,
	--add property for user who created event
	CONSTRAINT PK_event PRIMARY KEY (event_id)
)

INSERT INTO events (name, description, img_url, start_time, end_time, tag, location)
VALUES ('snackums', 'get your free snackums', 'https://images.freshop.com/00038000417405/0c14512451238be71bb6a5f7ef26304c_large.png', '2022-12-30 07:00:00', '2023-01-07 17:00:00', 'food', 'Slade Cottage Bridstow ROSS-ON-WYE, HR9 6AJ United Kingdom

');

INSERT INTO events (name, description, img_url, start_time, end_time, tag, location)
VALUES ('pants', 'why you no pants', 'https://www.helikon-tex.com/media/catalog/product/cache/6/image/9df78eab33525d08d6e5fb8d27136e95/s/p/sp-pgm-dc-11.jpg', '2022-12-30 07:00:00', '2023-01-07 19:00:00', 'pants', 'My house or smthn');

INSERT INTO events (name, description, img_url, start_time, end_time, tag, location)
VALUES ('poplock danceoff', 'pop and lock all the way to the moon', 'https://i.ytimg.com/vi/Cg6u8WbOOdA/hqdefault.jpg', '2022-12-26 19:00:00', '2022-12-26 22:00:00', 'soul', '1337 ITSLITFAM, Columbus, OH 8675309');

INSERT INTO events (name, description, img_url, start_time, end_time, tag, location)
VALUES ('USA Fit Pflugerville Resolution Race',
	'Stay on track on your new year’s resolutions and help us fight hunger by registering for the USA Fit Resolution Half & Austin Subaru 5K race benefiting the Food Bank. The race kicks off on January 8, 2023 at Lake Pflugerville this new year. The race will feature New Year’s themed festivities at the start and at the finish line. Register today to help families in need start the year off right with healthy meals.',
	'https://s3.amazonaws.com/runguides2/events/flyers/000/007/960/original/data?1637718078',
	'2023-01-08 07:30:00',
	'2023-01-08 23:59:59',
	'food, fitness',
	'18216 Weiss Lane, Pflugerville, TX, 78660');

GO