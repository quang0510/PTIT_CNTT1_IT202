create database Ex06;
use Ex06;

create table Student(
	id int primary key auto_increment UNIQUE,
    name VARCHAR(30) NOT NULL
);

create TABLE Class (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20) NOT NULL
);

create TABLE Course(
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20) NOT NULL
);

create table teacher(
	id INT PRIMARY KEY auto_increment,
    name VARCHAR(30) NOT NULL ,
    email VARCHAR(100) NOT NULL UNIQUE
);

create TABLE Enrollment (
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    register_date DATE NOT NULL,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Student(id),
    FOREIGN KEY (course_id) REFERENCES Course(id)
);

create table Score(
	student_id INT NOT NULL,
    course_id INT NOT NULL,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Student(id),
    FOREIGN KEY (course_id) REFERENCES Course(id),
    process_score DECIMAL(4,2) CHECK(process_score >= 0),
    final_exam_score DECIMAL(4,2) CHECK(final_exam_score >= 0)
);