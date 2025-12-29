create database ss3_ex4;

use ss3_ex4;

create table subject (
	subject_id int primary key,
    subject_name varchar(30) not null,
    credit int check(credit > 0)
);

create table Student (
	student_id int primary key,
    full_name varchar(30) not null,
    date_of_birth date,
    email varchar(50) not null
);

create table enrollment (
	enrollment_id int primary key,
    enrol_date date not null,
    student_id int,
    subject_id int,
    
	unique(student_id,subject_id),
    foreign key(student_id) references student(student_id),
    foreign key(subject_id) references subject(subject_id)
);


insert into student (student_id, full_name,date_of_birth, email) values 
(3,'quang','2002-10-15','quang@gmail.com'),
(2,'huy','2002-10-15','huy@gmail.com') ,
(5,'le','2002-10-15','le@gmail.com') 
 ;

insert subject value 
(1,'cấu trúc dữ liệu giải thuật',3),
(2,'csdl',4),
(3,'abbcd',2);

insert into enrollment (enrollment_id, enrol_date,student_id,subject_id)

values (1,'2002-10-15',1,1),
(2,'2002-10-15',2,3) ,
(3,'2002-10-15',3,1) 
 ;

select * from enrollment where enrollment_id = 1;