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
('Collective Commuters of Central Ohio', 'Are you looking for transportation to work or school? Having trouble affording your daily driving? Collective Commuters of Central Ohio is here to connect drivers and those needing transportation for their daily trips into and out of the city.', 'https://s.yimg.com/ny/api/res/1.2/cvOtSEFOGaN8lqK_c4sdzA--/YXBwaWQ9aGlnaGxhbmRlcjt3PTk2MDtoPTUxNA--/https://s.yimg.com/uu/api/res/1.2/zfBiLU834jJUpeyfqlfOZQ--~B/aD0yODk0O3c9NTQwMDthcHBpZD15dGFjaHlvbg--/https://media.zenfs.com/en/the-columbus-dispatch/9cbb0f37291c0b1778a27183ac0e3a0e', '2022-09-01 00:00:00', '2023-09-01 00:00:00', 'Columbus', 'Ohio', 43204, '0 Broad St', 2),
('Holiday Hot Meal and Toy Giveaway', 'Free hot meal and toys to gift your children.', 'https://www.horsespiritartsgallery.com/wp-content/uploads/2022/01/Giving-Tree-EB-Event-Dec-21.jpg', '2022-12-16 17:00:00', '2022-12-16 19:00:00', 'Columbus', 'Ohio', '43206', '1100 Rhoads Ave.', 1),
('F3 Columbus Fitness for Men', 'F3 — our three Fs stand for Fitness, Fellowship and Faith — traces its roots to a free, participant-led boot camp workout held on Saturday mornings at a Charlotte, North Carolina park since 2006. The leaders of F3 launched their first Saturday workout on January 1, 2011 on the campus of A.G. Middle School in Charlotte.', 'https://f3columbus.files.wordpress.com/2017/08/f3cbus_circle_wht.jpg?w=300', '2022-12-19 05:30:00', '2022-12-19 06:15:00', 'Columbus', 'Ohio', 43221, '2100 Arlington Ave.', 1),
('The Nook Workout for Women by FiA Columbus', 'Our Mission: FiA stands for Females in Action, which is a community of women dedicated to making each other stronger in all areas of our lives through activities that include bodies, minds, and hearts. A FiA workout is a promise, always free, open to ALL women, held outdoors, and ends with a circle of trust.', 'https://fianation.com/wp-content/uploads/2021/03/Columbus.webp', '2022-12-19 06:00:00', '2022-12-19 06:45:00', 'Columbus', 'Ohio', 43221,'1880 Northam Rd', 1),
('Santa’s Wonderland and Santa Pictures at Cabela’s and Bass Pro Shops', 'Families will get a free 4×6 studio-quality photo. Additional photo packages are also available for purchase and print instantly at the store. Book your appointment now! Reservations are available to book 7 days in advance.', 'https://i0.wp.com/www.columbusonthecheap.com/lotc-cms/wp-content/uploads/2022/11/2022_SantasArrival-scaled.jpg?resize=768%2C720&ssl=1', '2022-11-5 17:00:00', '2022-12-24 17:00:00', 'Columbus', 'Ohio', 43240, '1650 Gemini Place', 2),
('Columbus Free Clinic', 'We are a student-run organization, providing educational opportunities for professional and undergraduate volunteers and quality, culturally competent healthcare to our community.', 'https://columbusfreeclinic.com/wp-content/uploads/2022/08/CFC-Logo-Primary.png', '2023-01-05 17:45:00', '2023-01-05 22:00:00', 'Columbus', 'Ohio', 43201, '2231 North High Street', 2),
('New Life Health and Wellness Center - Free Clinic', 'The Health and Wellness Center is open to anyone who needs to see a physician. They offer free basic medical services, including blood pressure monitoring, and other common illnesses. There is a team of volunteer physicians, nurses, pharmacists and prayer partners on duty when the Health & Wellness Center is open. No appointment is necessary.', 'https://www.freeclinics.com/gallery/25455_kvvzudkf.jpg', '2022-12-18 07:00:00', '2022-12-18 08:30:00', 'Columbus', 'Ohio', 43201, '25 W. 5th Ave.', 1),
('Columbus Career Fair', 'Join us for this exciting career fair! Meet face to face with recruiters and HR managers from local and Fortune 500 companies to learn about open career opportunities. Dress to impress and please bring an updated resume. 100% free event for job seekers to attend.', 'https://img.evbuc.com/https%3A%2F%2Fcdn.evbuc.com%2Fimages%2F298456009%2F183327965130%2F1%2Foriginal.20220607-091118?w=940&auto=format%2Ccompress&q=75&sharp=10&rect=0%2C31%2C992%2C496&s=29942dd1e228a7341b4ec6d96ad02ba4', '2023-01-18 09:30:00', '2023-01-18 12:30:00', 'Columbus', 'Ohio', 43215, '50 S. Front Street', 1),
('Columbus Museum of Art', 'Columbus Museum of Art’s mission is to create great experiences with great art for everyone. Whether we are presenting an exhibition, designing an art-making activity, or giving visitors directions, we are guided by a vision to connect people and art. CMA nurtures that connection and removes barriers between our community and our collection. There’s a willingness at CMA to try new things. We encourage curiosity about art, conversations about creativity, and connections with cultures. A community hub where ideas can be exchanged and different voices heard, the Museum nurtures creativity through building relationships with diverse partners and designing engaging experiences. Free admission on Sundays!', 'https://www.columbusmuseum.org/wp-content/uploads/2019/11/aa.jpg', '2022-12-18 10:00:00', '2022-12-18 17:00:00', 'Columbus', 'Ohio', 43215, '480 East Broad St', 2);

GO

CREATE TABLE event_tags (
	event_id int FOREIGN KEY REFERENCES [events](event_id),
	tag_name varchar(50) 

	CONSTRAINT PK_event_tags PRIMARY KEY (tag_name, event_id)
)

INSERT INTO event_tags (event_id, tag_name) 
VALUES (1000, 'fitness'),
(1001, 'food'),
(1001, 'free'),
(1002, 'housing'),
(1002, 'career services'),
(1003, 'transportation'),
(1004, 'food'),
(1004, 'giveaway'),
(1004, 'holiday'),
(1005, 'fitness'),
(1006, 'fitness'),
(1007, 'entertainment'),
(1007, 'kids'),
(1007, 'holiday'),
(1008, 'healthcare'),
(1008, 'free'),
(1009, 'free'),
(1009, 'healthcare'),
(1010, 'career services'),
(1010, 'free'),
(1011, 'entertainment');

GO
