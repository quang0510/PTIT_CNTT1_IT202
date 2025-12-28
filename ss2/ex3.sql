create database ex3;
use ex3;

create table student(
	student_id int unique auto_increment primary key,
    student_name varchar(50) not null
);

create table subject (
	subject_id int unique auto_increment primary key,
    subject_name varchar(50) not null,
    subject_credit int check( subject_credit > 0)
);

create table enrollment(
    student_id int ,
    subject_id int ,
    enrollment_date date,
    primary key (student_id , subject_id),
    foreign key (student_id) references student(student_id),
    foreign key (subject_id) references subject(subject_id)
);