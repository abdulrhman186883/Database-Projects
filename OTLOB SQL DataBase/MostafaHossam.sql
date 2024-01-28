create database otlobfinal;

create table Department (
Dname varchar(40) not null,
Department_ID int not null,
Department_location varchar(70) not null,
mgr_ssn int,
constraint Dep_pk primary key (Department_ID),
);

create table Employee (
Fname varchar (20) not null,
Lname varchar(20)not null,
adress varchar(40) not null,
salary int not null,
sex varchar(12) not null,
super_ssn int not null,
startdate varchar (30) ,
Emp_ID int not null,
Dept_ID int not null,
constraint Emp_pk  primary key (Emp_ID),
constraint Emp_fk foreign key (super_ssn) References Employee(Emp_ID)
);

alter table Department
ADD CONSTRAINT emp_fk220
foreign key (mgr_ssn) References Employee (Emp_ID);

create table finance (
Department_ID int not null,
groosprofit int not null,
netprofit int not null,
theyear int not null,
constraint Dep_pkk primary key (Department_ID,theyear),
constraint Dep_pk1 foreign key (Department_ID) References Department( Department_ID)
);
create table Equipment (
Equip_ID int not null,
Equip_type  varchar(60) not null ,
Equip_price int not null ,

constraint Equipment_pk primary key (Equip_ID));
create table uses(
Equipment_ID int not null,
Employee_ID int not null,
date int ,
constraint uses_pk primary key (Equipment_ID,Employee_ID),
constraint uses_fk foreign key (Equipment_ID) References Equipment(Equip_ID),
constraint uses1_fk foreign key (Employee_ID) References Employee(Emp_ID)
);
INSERT INTO Department
values ( 'HR','1','nozha','30');
iNSERT INTO Department
values ('pr','2','maadie','40');
INSERT INTO Department
values ('security','3','rehab','50');
INSERT INTO Department
values ('Technical','4','down town','70');

INSERT INTO Department
values('IT','5','alex','');
INSERT INTO Department
values ('IS','6','mansora','88');

INSERT INTO Department
values ('delivery','80','masr elgdida','');

INSERT INTO Department
values ('finance','10','new cairo','100');






INSERT INTO Employee 
values ( 'mostafa','hossam','heleopls ','4000','m','1','20/8/2017','1','10');
INSERT INTO Employee
values('omar ','osama','madenty','3500','m','1','20/10/2019' ,'2','20');                                              
INSERT INTO Employee
values('mohab','osama','nasr city','2000','m','1','12/9/2017','3','30' );                                                                     
INSERT into Employee
values(  'bassnt','hazem','giza','4500','f','2','13/8/2016','4','40');                                                                   
INSERT INTO Employee
values('norhan','gmal','al obor','2500','f','3','13/8/2016','18', '10'  );

INSERT INTO Employee
values(   'mohamed','mostafa','nasr city','2300','m', '18', '20/8/2019','32','5');

INSERT INTO Employee
values('ali','omar','heleopls','2000','m','18','12/7/2015','47','80');


INSERT INTO Employee
values ('hassn','mohamed','zamalek','3800','m','3','17/9/2014','77','6');
INSERT INTO Employee
values('salma','hossam','new cairo','10000','f','1','8/10/2012','17','10');
INSERT INTO Employee
values('mohamed','amr','sheton','3000','m','4','7/4/2013','66','80');
INSERT INTO finance 
values(10,2000000,1000000,2015);

INSERT INTO finance 
values(10,2200000,110000,2016);

INSERT INTO finance 
values(10,2400000,1200000,2017);

INSERT INTO finance 
values(10,2500000,1250000,2018);

INSERT INTO finance 
values(10,2800000,1500000,2019);




INSERT INTO Equipment
values(300,'bike',2000);

INSERT INTO Equipment
values(301,'bike',2000);

INSERT INTO Equipment
values(400,'motocycle',25000);

INSERT INTO Equipment
values(412,'motocycle',25000);

INSERT INTO Equipment
values(511,'box',500);

INSERT INTO Equipment
values(600,'box',500);

INSERT INTO Equipment
values(700,'motocycle',15000);
INSERT INTO Equipment
values(650,'motocycle',15500);


iNSERT INTO uses
values(412,66);
INSERT INTO uses
values(700,3);
INSERT INTO uses
values(300,47);
INSERT INTO uses
values(301,66);
INSERT INTO uses
values(600,66);


select Fname,avg(salary)as 'avg salary'
from Employee
where sex='f'
group by Fname;

SELECT Dept_ID, AVG (Salary)as'salary'
FROM Employee
GROUP BY Dept_ID
HAVING AVG (Salary) > 3000



SELECT Fname, Lname
FROM Employee JOIN Department
ON Employee.Dept_ID=Department.Department_ID
WHERE Dname = 'IT'
AND Sex = 'm';select Fname ,Lname as 'full name',Dname as 'job'from Employee,Departmentwhere Dname in (select Dname from Department where Department_ID=Dept_IDand Dname='delivery');
SELECT Fname, Lname
FROM Employee
WHERE EXISTS (SELECT *
FROM Department
WHERE mgr_ssn = super_ssn);