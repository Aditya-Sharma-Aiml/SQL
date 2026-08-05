create DATABASE IF NOT EXISTS college;
use college;
CREATE TABLE instructors (
    instructor_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    department VARCHAR(50)
);

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    course_code VARCHAR(20) UNIQUE,
    instructor_id INT,
    credits INT,

    CONSTRAINT fk_course_instructor
    FOREIGN KEY (instructor_id)
    REFERENCES instructors(instructor_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    grade VARCHAR(5),

    CONSTRAINT fk_enrollment_student
    FOREIGN KEY (student_id)
    REFERENCES students(student_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT fk_enrollment_course
    FOREIGN KEY (course_id)
    REFERENCES courses(course_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

INSERT INTO students (student_id, first_name, last_name, date_of_birth, email) VALUES
(1, 'Aman', 'Khan', '2002-05-12', 'aman.khan@gmail.com'),
(2, 'Riya', 'Sharma', '2001-11-23', 'riya.sharma@yahoo.com'),
(3, 'Sohel', 'Mohammed', '2000-08-08', 'sohel.m@gmail.com'),
(4, 'Arjun', 'Patel', '2003-01-15', 'arjun.patel@gmail.com'),
(5, 'Fatima', 'Sheikh', '2002-09-20', 'fatima.sheikh@hotmail.com'),
(6, 'Kiran', 'Rao', '2001-03-14', 'kiran.rao@gmail.com'),
(7, 'Neha', 'Gupta', '2002-07-21', 'neha.gupta@gmail.com'),
(8, 'Vikram', 'Singh', '2000-12-09', 'vikram.singh@gmail.com'),
(9, 'Aisha', 'Ali', '2003-02-18', 'aisha.ali@gmail.com'),
(10, 'Rohit', 'Kumar', '2001-10-11', 'rohit.kumar@gmail.com'),
(11, 'Meena', 'Joshi', '2002-04-25', 'meena.joshi@gmail.com'),
(12, 'Tarun', 'Das', '2000-09-30', 'tarun.das@gmail.com'),
(13, 'Pallavi', 'Reddy', '2003-06-05', 'pallavi.reddy@gmail.com'),
(14, 'Nikhil', 'Mishra', '2001-08-19', 'nikhil.mishra@gmail.com'),
(15, 'Sara', 'Begum', '2002-01-27', 'sara.begum@gmail.com');

INSERT INTO instructors (instructor_id, first_name, last_name, email, department) VALUES
(101, 'Rahul', 'Sharma', 'rahul.sharma@college.edu', 'Computer Science'),
(102, 'Sneha', 'Verma', 'sneha.verma@college.edu', 'Mathematics'),
(103, 'Imran', 'Khan', 'imran.khan@college.edu', 'Computer Science'),
(104, 'Pooja', 'Reddy', 'pooja.reddy@college.edu', 'Physics'),
(105, 'Anil', 'Kumar', 'anil.kumar@college.edu', 'Chemistry'),
(106, 'Priyanka', 'Shah', 'priyanka.shah@college.edu', 'Biology'),
(107, 'Suresh', 'Patil', 'suresh.patil@college.edu', 'Mathematics'),
(108, 'Deepa', 'Nair', 'deepa.nair@college.edu', 'English'),
(109, 'Vivek', 'Gupta', 'vivek.gupta@college.edu', 'Computer Science'),
(110, 'Lakshmi', 'Iyer', 'lakshmi.iyer@college.edu', 'Physics'),
(111, 'Rajesh', 'Yadav', 'rajesh.yadav@college.edu', 'Commerce'),
(112, 'Kavya', 'Rao', 'kavya.rao@college.edu', 'Economics'),
(113, 'Manish', 'Verma', 'manish.verma@college.edu', 'Statistics'),
(114, 'Swathi', 'Reddy', 'swathi.reddy@college.edu', 'Electronics');

INSERT INTO courses (course_id, course_name, course_code, instructor_id, credits) VALUES
(201, 'Database Management Systems', 'CS101', 101, 4),
(202, 'Data Structures', 'CS102', 101, 3),
(203, 'Calculus', 'MA101', 102, 4),
(204, 'Operating Systems', 'CS103', 103, 4),
(205, 'Quantum Physics', 'PH101', 104, 3),
(206, 'Computer Networks', 'CS104', 109, 4),
(207, 'Software Engineering', 'CS105', 109, 3),
(208, 'Linear Algebra', 'MA102', 107, 4),
(209, 'Organic Chemistry', 'CH101', 105, 3),
(210, 'Micro Biology', 'BI101', 106, 4),
(211, 'English Literature', 'EN101', 108, 3),
(212, 'Corporate Finance', 'CO101', 111, 4),
(213, 'Economics', 'EC101', 112, 3),
(214, 'Probability & Statistics', 'ST101', 113, 4),
(215, 'Digital Electronics', 'EL101', 114, 3);

INSERT INTO enrollments (enrollment_id, student_id, course_id, enrollment_date, grade) VALUES
(1, 1, 201, '2024-01-10', 'A'),
(2, 1, 202, '2024-01-15', 'B'),
(3, 2, 201, '2024-02-05', 'A'),
(4, 3, 203, '2024-03-02', 'B+'),
(5, 4, 202, '2024-04-20', NULL),
(6, 4, 204, '2024-04-22', 'A-'),
(7, 5, 201, '2024-05-10', NULL),
(8, 6, 206, '2024-05-15', 'A'),
(9, 7, 207, '2024-05-18', 'B+'),
(10, 8, 208, '2024-05-20', 'A'),
(11, 9, 209, '2024-05-25', 'B'),
(12, 10, 210, '2024-05-28', 'A-'),
(13, 11, 211, '2024-06-01', 'A'),
(14, 12, 212, '2024-06-05', 'B+'),
(15, 13, 213, '2024-06-08', NULL);