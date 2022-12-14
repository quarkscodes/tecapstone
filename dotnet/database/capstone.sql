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
VALUES ('YMCA Hilltop', 'Welcome to the YMCA of Central Ohio. We are an inclusive organization of men, women and children joined together by a shared commitment to nurturing the potential of kids, promoting healthy living and fostering a sense of social responsibility.', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTd2I-dWGDQLBV_e-UMxGOwPew_PTl7MQIKPw&usqp=CAU', '2022-01-01 12:00:00', '2024-01-01 12:00:00', 'Columbus', 'Ohio', 43204, '2879 Valleyview Dr', 1),
('Central Community House Free Dinner', 'Serves free, hot dinner to the Near East community on the last Wednesday of each month. First come, first serve.', 'https://i0.wp.com/beacononlinenews.com/wp-content/uploads/2022/11/A01-CH-shilretha.jpg?fit=1920%2C1440&ssl=1', '2022-12-28 18:00:00', '2022-12-28 19:00:00', 'Columbus', 'Ohio', 43205, '1150 E. Main St.', 1),
('Alvis Reentry Services', 'As part of our Residential Reentry program, we offer a comprehensive range of services designed to help people who are transitioning from the corrections system back into the community. We provide these services in safe, supportive environments, so clients receive the guidance they need to navigate the challenges of finding employment and reconnecting with family members. Our clients work, attend school and do community service, while participating in treatment and programs that help them rebuild their lives, strengthen their families and become contributing members of the community.', 'https://www.psi92.com/wp-content/uploads/ALVIS.png', '2022-01-01 00:00:00', '2024-01-01 00:00:00', 'Columbus', 'Ohio', 43215, '2100 Stella Court', 2),
('Collective Commuters of Central Ohio', 'Are you looking for transportation to work or school? Having trouble affording your daily driving? Collective Commuters of Central Ohio is here to connect drivers and those needing transportation for their daily trips into and out of the city.', 'https://s.yimg.com/ny/api/res/1.2/cvOtSEFOGaN8lqK_c4sdzA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTk2MDtoPTUxNA--/https://s.yimg.com/uu/api/res/1.2/zfBiLU834jJUpeyfqlfOZQ--~B/aD0yODk0O3c9NTQwMDthcHBpZD15dGFjaHlvbg--/https://media.zenfs.com/en/the-columbus-dispatch/9cbb0f37291c0b1778a27183ac0e3a0e', '2022-09-01 00:00:00', '2023-09-01 00:00:00', 'Columbus', 'Ohio', 43204, '0 Broad St', 2);
GO

CREATE TABLE event_tags (
	event_id int FOREIGN KEY REFERENCES [events](event_id),
	tag_name varchar(50) 

	CONSTRAINT PK_event_tags PRIMARY KEY (tag_name, event_id)
)

INSERT INTO event_tags (event_id, tag_name) 
VALUES (1000, 'fitness'),
(1000, 'health'),
(1001, 'food'),
(1001, 'free'),
(1002, 'housing'),
(1002, 'career services'),
(1003, 'transportation');

GO
