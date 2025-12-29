create database ss3_ex6;
use ss3_ex6;

create table student (
	student_id int auto_increment primary key,
    full_name varchar(30) not null,
    date_of_birth date not null,
    email varchar(50) unique not null
); 

create table subject (
	subject_id int auto_increment primary key ,
    subject_name varchar(50) not null unique,
    credit int check (credit > 0)
);

create table Enrollment (
	Student_id int not null,
    Subject_id int not null,
    Enroll_date date not null,
    primary key(Student_id , Subject_id ),
    foreign key (Student_id ) references student(student_id),
    foreign key (Subject_id ) references subject(subject_id)
);

create table score (
	student_id int not null,
    subject_id int not null,
    mid_score decimal(4,2) check (mid_score >= 0 and mid_score <= 10),
    final_score decimal(4,2) check (final_score >= 0 and final_score <= 10),
	primary key(student_id , subject_id ),
	foreign key (student_id ) references student(student_id),
    foreign key (subject_id ) references subject(subject_id)
);

insert into student (full_name, date_of_birth ,email ) values 
('Nguyen Dang Quang ', '1-1-2025' , 'ndq0510@gmail.com');

insert into subject (subject_name , credit) values 
('CSDL' , 3 ),
('ABC' , 1);

insert into score (student_id, subject_id, mid_score, final_score) values
(1, 1, 7.5, 8.0),
(1, 2, 6.0, 7.0);

insert into enrollment (student_id, subject_id, enroll_date) values
(1, 1, '2025-01-10'),
(1, 2, '2025-01-10');


update score
set mid_score = 8.0,
    final_score = 8.5
where student_id = 1 and subject_id = 1;


delete from score
where student_id = 2 and subject_id = 2;

delete from enrollment
where student_id = 2 and subject_id = 2;

select
    student.full_name,
    subject.subject_name,
    score.mid_score,
    score.final_score
from student, subject, score
where student.student_id = score.student_id and subject.subject_id = score.subject_id;



