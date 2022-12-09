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
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('user','Jg45HuwT7PZkfuKTz6IB90CtWY4=','LHxP4Xh7bN0=','admin');

--Nancy/password
INSERT INTO users (username, password_hash, salt, user_role) VALUES ('admin','YhyGVQ+Ch69n4JMBncM4lNF/i9s=', 'Ar/aB2thQTI=','admin');

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
VALUES ('snackums', 'get your free snackums', 'https://images.freshop.com/00038000417405/0c14512451238be71bb6a5f7ef26304c_large.png', '2022-12-30 07:00:00', '2023-01-07 17:00:00', 'city city', 'hawaii', '11111', '1234 address street', '1');

INSERT INTO events (name, description, img_url, start_time, end_time, city, state, zip, address, user_id)
VALUES ('pants', 'why you no pants', 'https://www.helikon-tex.com/media/catalog/product/cache/6/image/9df78eab33525d08d6e5fb8d27136e95/s/p/sp-pgm-dc-11.jpg', '2022-12-30 07:00:00', '2023-01-07 19:00:00', 'My city', 'my state', '22222', '111 street place or smthn', '1');

INSERT INTO events (name, description, img_url, start_time, end_time, city, state, zip, address, user_id)
VALUES ('poplock danceoff', 'pop and lock all the way to the moon', 'https://i.ytimg.com/vi/Cg6u8WbOOdA/hqdefault.jpg', '2022-12-26 19:00:00', '2022-12-26 22:00:00', 'Columbus', 'OH', '867509', '1337 ITSLITFAM road', '2');

INSERT INTO events (name, description, img_url, start_time, end_time, city, state, zip, address, user_id)
VALUES ('USA Fit Pflugerville Resolution Race',
	'Stay on track on your new year’s resolutions and help us fight hunger by registering for the USA Fit Resolution Half & Austin Subaru 5K race benefiting the Food Bank. The race kicks off on January 8, 2023 at Lake Pflugerville this new year. The race will feature New Year’s themed festivities at the start and at the finish line. Register today to help families in need start the year off right with healthy meals.',
	'https://s3.amazonaws.com/runguides2/events/flyers/000/007/960/original/data?1637718078',
	'2023-01-08 07:30:00', '2023-01-08 23:59:59', 'Pflugerville','TX', '78660', '18216 Weiss Lane', '2');

GO

CREATE TABLE tags (
	name varchar(50) NOT NULL,

	CONSTRAINT PK_tag PRIMARY KEY (name)
)

INSERT INTO tags (name) VALUES ('clothing');
INSERT INTO tags (name) VALUES ('school supplies');
INSERT INTO tags (name) VALUES ('food');
INSERT INTO tags (name) VALUES ('grooming');
INSERT INTO tags (name) VALUES ('technology');
INSERT INTO tags (name) VALUES ('health');
INSERT INTO tags (name) VALUES ('education');
INSERT INTO tags (name) VALUES ('childcare');

GO

CREATE TABLE event_tags (
	event_id int FOREIGN KEY REFERENCES events(event_id),
	tag_name varchar(50) FOREIGN KEY REFERENCES tags(name),

	CONSTRAINT PK_event_tags PRIMARY KEY (tag_name, event_id)
)

INSERT INTO event_tags (event_id, tag_name) VALUES (1000, 'food');
INSERT INTO event_tags (event_id, tag_name) VALUES (1001, 'clothing');
INSERT INTO event_tags (event_id, tag_name) VALUES (1002, 'technology');
INSERT INTO event_tags (event_id, tag_name) VALUES (1003, 'food');
INSERT INTO event_tags (event_id, tag_name) VALUES (1003, 'health');

GO
