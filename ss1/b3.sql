Create table Student(
MSV int primary key,
name_student varchar(100),
date_of_birth datetime
);
Create table Course(
ID int primary key,
name_course varchar(100),
money varchar(100)
);
Create table Enrollment(
start_day datetime,
foreign key (MSV) references Student(MSV),
foreign key (ID_course) references Course(ID)
);