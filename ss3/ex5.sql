create database ss3_ex5;

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

create table score (
    student_id int,
    subject_id int,
    mid_score decimal check (mid_score >= 0 or mid_score <= 10),
    final_score decimal check (final_score >= 0 or final_score <= 10),
    
	unique(student_id,subject_id),
    foreign key(student_id) references student(student_id),
    foreign key(subject_id) references subject(subject_id)
);


insert into student values 
(3,'quang','2002-10-15','quang@gmail.com'),
(2,'huy','2002-10-15','huy@gmail.com') ,
(5,'le','2002-10-15','le@gmail.com') 
 ;

insert into subject value 
(1,'cấu trúc dữ liệu giải thuật',3),
(2,'csdl',4),
(3,'abbcd',2);


insert into score 
values (1,1,7,7), (2,3,9,9);


select * from score;

select * from score where final_score >= 8;