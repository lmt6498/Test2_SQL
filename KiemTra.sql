create database test2;
use test2;

create table students (
studentid int primary key,
studentname varchar (50),
age int,
email varchar (50)
);

create table classes(
classid int primary key,
classname varchar (30)
);

create table classstudent(
studentid int,
classid int,
foreign key (studentid) references students (studentid),
foreign key (classid) references classes (classid)
);

create table subjects (
subjectid int primary key,
subjectname varchar(30)
);


create table marks (
mark int,
subjectid int,
studentid int,
foreign key (subjectid) references subjects (subjectid),
foreign key (studentid) references students (studentid)
);
drop table marks;
insert into students
values (1,'Nguyen Quang An',18,'an@yahoo.com'),
(2,'Nguyen Cong Vinh',20,'vinh@gmail.com'),
(3,'Nguyen Van Quyen',19,'quyen'),
(4,'Pham Thanh Binh',25,'binh@com'),
(5,'Nguyen Van Tai Em',30,'taiem@sport.vn');
insert into classes
values (1,'C0706L'),
(2,'C0708G');

insert into classstudent
values (1,1),
(2,1),
(3,2),
(4,2),
(5,2);

insert into subjects
values (1,'SQL'),
(2,'Java'),
(3,'C'),
(4,'Visual Basic');

insert into marks
values (8,1,1),
(4,2,1),
(9,1,1),
(7,1,3),
(3,1,4),
(5,2,5),
(8,3,3),
(1,3,5),
(3,2,4);

-- Hien thi danh sach tat ca cac hoc vien 
select * from students;

-- Hien thi danh sach tat ca cac mon hoc
select * from subjects;

-- Tinh diem trung binh 
select students.studentid,students.studentname,avg(mark) as "diem trung binh"
from marks
inner join students on marks.studentid = students.studentid
inner join subjects on marks.subjectid = subjects.subjectid
group by students.studentid;

-- Hien thi mon hoc nao co hoc sinh thi duoc diem cao nhat
select subjects.*,students.studentname
from marks
inner join subjects on subjects.subjectid = marks.subjectid
inner join students on students.studentid = marks.studentid
where marks.mark >= all (select mark from marks);

-- Danh so thu tu cua diem theo chieu giam
select * from marks
order by mark desc;

-- Thay doi kieu du lieu cua cot SubjectName trong bang Subjects thanh nvarchar(max)
ALTER TABLE subjects 
MODIFY  subjectname varchar(200);

-- Cap nhat them dong chu « Day la mon hoc «  vao truoc cac ban ghi tren cot SubjectName trong bang Subjects
drop table subjects;
drop table marks;
insert into subjects
values (1,' Day la mon hoc SQL'),
(2,'Day la mon hoc Java'),
(3,'Day la mon hoc C'),
(4,'Day la mon hoc Visual Basic');

-- Viet Check Constraint de kiem tra do tuoi nhap vao trong bang Student yeu cau Age >15 va Age < 50
ALTER TABLE students
ADD CONSTRAINT rang_buoc check (age > 15 and age < 50);

-- Loai bo tat ca quan he giua cac bang
ALTER TABLE classstudent
DROP CONSTRAINT classstudent_ibfk_1;
ALTER TABLE classstudent
DROP CONSTRAINT classstudent_ibfk_2;
ALTER TABLE marks
DROP CONSTRAINT marks_ibfk_1;
ALTER TABLE marks
DROP CONSTRAINT marks_ibfk_2;

-- Xoa hoc vien co StudentID la 1
delete from students
where studentid = 1;

-- Trong bang Student them mot column Status co kieu du lieu la Bit va co gia tri Default la 1
alter table students
add status bit default 1;

-- Cap nhap gia tri Status trong bang Student thanh 0
update students
set status = 0
where studentid between 1 and 6;
set sql_safe_updates =0;


