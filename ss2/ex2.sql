create database ex2;
use ex2;

create table student(
	student_id int unique auto_increment primary key,
    student_name varchar(50)
);

create table subject (
	subject_id int unique auto_increment primary key,
    subject_name varchar(50),
    subject_credit int check( subject_credit > 0)
);