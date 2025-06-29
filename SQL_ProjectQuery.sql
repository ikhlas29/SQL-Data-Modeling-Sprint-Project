Create database SQL_Project

Use SQL_Project


--Trainee--
Create table Trainee ( 
     Trainee_id int primary key,
	 Trainee_name varchar(80),
	 Gender varchar(20),
	 Trainee_email varchar(100),
	 Background varchar(100)
)

--Trainer--
Create table Trainer ( 
     Trainer_id int primary key,
	 Trainer_name varchar(80),
	 Specialty varchar(100),
	 Trainer_email varchar(100),
	 Phone varchar(20),
)

--Course--
Create table Course ( 
     Course_id int primary key,
	 Title varchar(100),
	 Category varchar(50),
	 Duration_hours int,
	 Course_level varchar(20)
)

--Schedule--
Create table Schedule ( 
     Schedule_id int primary key,
	 St_date date,
	 Ed_date date,
	 Time_slot varchar(20)
)

--Enrollment--
Create table Enrollment (
      Enrollment_id int primary key,
	  Enrollment_date date
)


-- Schedule table alteration --
Alter table Schedule
Add Course_id int

Alter table Schedule
Add Foreign key (Course_id) References Course(Course_id)

Alter table Schedule
Add Trainer_id int

Alter table Schedule
Add Foreign key (Trainer_id) References Trainer(Trainer_id) ---done 

-- Enrollment table alteration --
Alter table Enrollment
Add trainee_id int

Alter table Enrollment
Add Foreign key (trainee_id) References Trainee(trainee_id)

Alter table Enrollment
Add Course_id int

Alter table Enrollment
Add Foreign key (course_id) References Course(course_id)

---------- ALTER Column Proj_name VARCHAR(50) not null;---------------

--- Data insert ---

--- Trainee
Insert into Trainee(Trainee_id, Trainee_name, Gender, Trainee_email, Background) Values
(1,'Aisha Al-Harthy','Female','aisha@example.com','Engineering'),
(2,'Sultan Al-Farsi','Male','sultan@example.com','Business'),
(3,'Mariam Al-Saadi','Female','mariam@example.com','Marketing'),
(4,'Omar Al-Balushi','Male','omar@example.com','Computer Science'),
(5,'Fatma Al-Hinai','Female','fatma@example.com','Data Science')


--- Trainers 
Insert into Trainer(Trainer_id, Trainer_name, Specialty, Phone, Trainer_email) Values
(1,'Khalid Al-Maawali','Databases','96891234567','khalid@example.com'),
(2,'Noura Al-Kindi','Web Development','96892345678','noura@example.com'),
(3,'Salim Al-Harthy','Data Science','96893456789','salim@example.com')


--- Course
Insert into Course(Course_id, Title, Category, Duration_hours, Course_level) Values
(1,'Database Fundamentals','Databases',20,'Beginner'),
(2,'Web Development Basics','Web',30,'Beginner'),
(3,'Data Science Introduction','Data Science',25,'Intermediate'),
(4,'Advanced SQL Queries','Databases',15,'Advanced')


--- Schedule 
Insert into Schedule(Schedule_id, Course_id, Trainer_id, St_date, Ed_date, Time_slot) Values
(1,1,1,'2025-07-01','2025-07-10','Morning'),
(2,2,2,'2025-07-05','2025-07-20','Evening'),
(3,3,3,'2025-07-10','2025-07-25','Weekend'),
(4,4,1,'2025-07-15','2025-07-22','Morning')


--- Enrollment
Insert into Enrollment(Enrollment_id, Trainee_id, Course_id, Enrollment_date) Values
(1,1,1,'2025-06-01'),
(2,2,1,'2025-06-02'),
(3,3,2,'2025-06-03'),
(4,4,3,'2025-06-04'),
(5,5,3,'2025-06-05'),
(6,1,4,'2025-06-06')


---Query
---Trainee Perspective 
---Query Challenges 
---1. Show all available courses (title, level, category) 
Select Title, Course_level, Category
From Course

---2. View beginner-level Data Science courses 
Select Category, Course_level, 
From Course
Where Category='Data Science' and Course_level='Beginner'
 
---3. Show courses this trainee is enrolled in
Select Title 
From Course C
Join Enrollment E on C.Course_id = E.Course_id
Where E.Trainee_id = '1'

---4. View the schedule (start_date, time_slot) for the trainee's enrolled courses 
Select St_date, Time_slot
From Schedule S
join Enrollment E on S.Course_id = E.Course_id
Where E.Trainee_id='2'

---5. Count how many courses the trainee is enrolled in 
Select count(Course_id) as Course_num, Trainee_id
From Enrollment
Group by Trainee_id
 
---6. Show course titles, trainer names, and time slots the trainee is attending 
Select Title, Trainer_name, Time_slot, Trainee_id
From Enrollment E, Schedule S, Trainer Tr, Course C
Where E.Course_id = C.Course_id and S.Course_id = C.Course_id and S.Trainer_id = Tr.Trainer_id

--------------------------------------------------------------------------------------------------
---Trainer Perspective 
---Query Challenges 
---1. List all courses the trainer is assigned to 
Select C.Title, S.Trainer_id
From Course C, Trainer Tr, Schedule S
Where C.Course_id = S.Course_id and Tr.Trainer_id = S.Trainer_id

---2. Show upcoming sessions (with dates and time slots) 
Select Title, St_date, Ed_date, Time_slot
From Course C, Schedule S
Where Trainer_id='1' and C.Course_id = S.Course_id

---3. See how many trainees are enrolled in each of your courses 
Select count(E.Trainee_id)as Tr_count, C.Title
From Course C, Trainer Tr, Enrollment E, Schedule S
Where C.Course_id = S.Course_id and S.Trainer_id = Tr.Trainer_id and E.Course_id = C.Course_id and Tr.Trainer_id=2
Group by C.Title

---4. List names and emails of trainees in each of your courses 
Select Te.Trainee_name, Te.Trainee_email, C.Title
From Enrollment E , Trainee Te, Course C, Schedule S, Trainer Tr
where E.Course_id = C.Course_id and Te.Trainee_id = E.Trainee_id and C.Course_id = S.Course_id
and S.Trainer_id = Tr.Trainer_id and Tr.Trainer_id = 2

---5. Show the trainer's contact info and assigned courses
Select Tr.Trainer_id, Phone, Trainer_email, Title
From Trainer Tr, Course C, Schedule S
Where Tr.Trainer_id = S.Trainer_id and C.Course_id = S.Course_id and Tr.Trainer_id = 1

---6. Count the number of courses the trainer teaches 
Select Count(distinct C.Course_id) as Course_num
From Course C , Schedule S
Where C.Course_id = S.Course_id and S.Trainer_id = 1

------------------------------------------------------------------------------------------
---Admin Perspective 
---Query Challenges 
---1. Add a new course (INSERT statement)  
Insert into Course(Course_id, Title, Category, Duration_hours, Course_level) Values
(5,'Telecommuniation Engineering','Engineering',20,'Intermediate')

---2. Create a new schedule for a trainer 
Insert into Schedule(Schedule_id, Course_id, Trainer_id, St_date, Ed_date, Time_slot) Values
(5,2,2,'2025-07-15','2025-07-20','Morning')

---3. View all trainee enrollments with course title and schedule info 
Select trainee_id, Enrollment_id, Title, St_date, Ed_date, Time_slot
From Schedule S, Course C, Enrollment E
Where E.Course_id = C.Course_id and S.Course_id = C.Course_id

---4. Show how many courses each trainer is assigned to 
Select count(Course_id) as Course_count, Trainer_id
From Schedule
Group by trainer_id

---5. List all trainees enrolled in "Data Basics" 
Select Trainee_name, Trainee_email
From Trainee T, Course C, Enrollment E
Where T.Trainee_id = E.Trainee_id and E.Course_id = C.Course_id and C.Title='Data Basics'

---6. Identify the course with the highest number of enrollments 
Select top 1 count(Enrollment_id) as E_num, Title -- Top 1 to display the highest --- 
From Enrollment E, Course C
Where C.Course_id = E.Course_id
Group by C.Title
Order by E_num Desc

---7. Display all schedules sorted by start date 
Select * From Schedule
Order by St_date Asc