create database otlob2 ;

CREATE TABLE TRIG_audit(
food_ID int not null ,
food_type varchar (40),
food_name varchar (40),
paudit varchar (50),
CREATION date,
)

GO
CREATE TRIGGER TRIG
ON MENUU
FOR INSERT 
AS 
declare @food_ID int ;
declare @food_type varchar (40);
declare @food_name varchar (40);
declare @paudit varchar(50);
select @food_ID=i.food_ID from inserted i;
select @food_type=i.food_type from inserted i;
select @food_name=i.food_name from inserted i;
select @paudit ='insert trigger executed';
insert into TRIG_audit 
values (@food_ID,@food_type,@food_name ,GETDATE());
print 'trigger successfully executed';

insert into MENUU 
values(118,'fast food','Elbake');

create table EMPLOYEEE (
Fname varchar (30) not null,
Lname varchar (30) not null,
startDate varchar (30),
salary int ,
emp_ID int not null ,
emp_add varchar (50),
emp_sex varchar (10) not null,
constraint emp_pkk primary key (emp_ID),
);

insert into EMPLOYEEE(Fname,Lname,startDate,salary,emp_ID,emp_add,emp_sex)
values ('Yousef','Adel','2019',10000,123,'benha','male');

insert into EMPLOYEEE(Fname,Lname,startDate,salary,emp_ID,emp_add,emp_sex)
values ('Mostafa','Hossam','2019',10000,124,'Cairo','male');

insert into EMPLOYEEE(Fname,Lname,startDate,salary,emp_ID,emp_add,emp_sex)
values ('Omar','Mohmed','2019',12000,125,'cairo','male');

insert into EMPLOYEEE(Fname,Lname,startDate,salary,emp_ID,emp_add,emp_sex)
values ('Kareem','Abed','2019',13000,126,'Mansoura','male');

insert into EMPLOYEEE(Fname,Lname,startDate,salary,emp_ID,emp_add,emp_sex)
values ('Abdulrahman','Zakaria','2019',14000,127,'Cairo','male');

insert into EMPLOYEEE(Fname,Lname,startDate,salary,emp_ID,emp_add,emp_sex)
values ('Shehab','Hesham','2019',10000,128,'Cairo','male');

insert into EMPLOYEEE(Fname,Lname,startDate,salary,emp_ID,emp_add,emp_sex)
values ('Marawan','Hassan','2019',10000,129,'Cairo','male');

UPDATE EMPLOYEEE SET salary =11000 WHERE emp_ID =123;
UPDATE EMPLOYEEE SET salary =18000 wHERE emp_ID=126;

create table EmployeeAddress(
Employee_ID int not null ,
Street_name varchar (30),
Building_number int ,
Apartment_number int ,
Area varchar (40),
constraint Emp_Add_pkk primary key (Employee_ID,Building_number,Apartment_number),
constraint Emp_Add_fkk foreign key (Employee_ID) references EMPLOYEEE (emp_ID)
on update cascade
);

insert into EmployeeAddress (Employee_ID,Street_name,Building_number,Apartment_number,Area)
values (123,'Omar Ibn elkhattab st',15,2,null)

insert into EmployeeAddress (Employee_ID,Street_name,Building_number,Apartment_number,Area)
values (124,'Omar Ibn elkhattab st',15,3,null)

insert into EmployeeAddress (Employee_ID,Street_name,Building_number,Apartment_number,Area)
values (125,'Omar Ibn elkhattab st',15,4,null)

insert into EmployeeAddress (Employee_ID,Street_name,Building_number,Apartment_number,Area)
values (126,'naser st',16,5,null)

insert into EmployeeAddress (Employee_ID,Street_name,Building_number,Apartment_number,Area)
values (127,'ahmed st',17,6,null)

insert into EmployeeAddress (Employee_ID,Street_name,Building_number,Apartment_number,Area)
values (128,'mohmed st',18,7,null)

insert into EmployeeAddress (Employee_ID,Street_name,Building_number,Apartment_number,Area)
values (129,'ibrahem st',19,8,null)


create table RESTAURANTT(
restaurant_id int not null,
restaurant_name varchar (40) not null ,
restaurant_loc varchar (50) not null ,
constraint rest_pkk primary key (restaurant_id),
);

insert into RESTAURANTT(restaurant_id,restaurant_name,restaurant_loc)
values (100,' McDonald’s','Heliopolis');

insert into RESTAURANTT(restaurant_id,restaurant_name,restaurant_loc)
values (101,' Hadramout','Helwan');

insert into RESTAURANTT (restaurant_id,restaurant_name,restaurant_loc)
values (102,' Cheese House','Masr El Gedida');

insert into RESTAURANTT(restaurant_id,restaurant_name,restaurant_loc)
values (103,' Ramadan Grill','Nasr city');

insert into RESTAURANTT (restaurant_id,restaurant_name,restaurant_loc)
values (104,'Happy Cake','Zamalek');

insert into RESTAURANTT (restaurant_id,restaurant_name,restaurant_loc)
values (105,'Shader El Samak','Sheraton');

insert into RESTAURANTT (restaurant_id,restaurant_name,restaurant_loc)
values (106,'Sushi House','Zamalek');


create table "ORDERR"(
Destanation varchar (50) not null,
order_date varchar (40) not null,
order_ID int not null,
rest_id int ,
driver_id int,
constraint order_pkk primary key (order_ID),
constraint emp_order_fkk foreign key (driver_id) references EMPLOYEEE(emp_ID)
on update cascade,
constraint rest_order_fkk foreign key (rest_id) references RESTAURANTT(restaurant_id) 
on update cascade,
);

insert into "ORDERR"(Destanation,order_date,order_ID,rest_id,driver_id)
values ('Sheraton','10/12/2019',111,100,123);

insert into "ORDERR"(Destanation,order_date,order_ID,rest_id,driver_id)
values ('Sheraton','10/5/2019',112,101,124);

insert into "ORDERR"(Destanation,order_date,order_ID,rest_id,driver_id)
values ('Zamalek','13/10/2019',113,102,125);

insert into "ORDERR"(Destanation,order_date,order_ID,rest_id,driver_id)
values ('Masr El Gedida','11/1/2019',114,103,126);

insert into "ORDERR"(Destanation,order_date,order_ID,rest_id,driver_id)
values ('Nasr city','10/2/2019',115,104,127);

insert into "ORDERR"(Destanation,order_date,order_ID,rest_id,driver_id)
values ('Heliopolis','1/12/2019',116,105,128);

insert into "ORDERR"(Destanation,order_date,order_ID,rest_id,driver_id)
values ('Helwan','11/12/2019',117,106,129);


create table MENUU(
food_ID int not null ,
food_type varchar (40),
food_name varchar (40),
RESTO_id int ,
constraint menu_pkk primary key (food_ID),
constraint rest_menu_fkk foreign key (RESTO_id) references  RESTAURANTT(restaurant_id)
on update cascade,
);

insert into MENUU(food_ID,food_name,food_type,RESTO_id)
values (10,'Big Mac','Fast Food',101);

insert into MENUU(food_ID,food_name,food_type,RESTO_id)
values (20,null,'lunch',102);

insert into MENUU(food_ID,food_name,food_type,RESTO_id)
values (30,null,'Fast Food',103);

insert into MENUU(food_ID,food_name,food_type,RESTO_id)
values (40,null,'Diner',104);

insert into MENUU(food_ID,food_name,food_type,RESTO_id)
values (50,null,'lunch',105);

insert into MENUU(food_ID,food_name,food_type,RESTO_id)
values (60,null,'Fast Food',106);

insert into MENUU(food_ID,food_name,food_type,RESTO_id)
values (70,null,'Fast Food',107);

create table order_summary (
order_id int not null,
Quantity int not null,
items varchar(100) not null,
constraint order_sum_pk primary key (order_id ,Quantity,items) ,
constraint Summary_order_fk foreign key (order_id) references "ORDERR" (order_ID)
on update cascade,
);
 insert into order_summary (order_id,Quantity,items)
 values (111,2,'Hadramout')

  insert into order_summary (order_id,Quantity,items)
 values (112,5,'Cheese House')

  insert into order_summary (order_id,Quantity,items)
 values (113,4,'Shader El Samak')

  insert into order_summary (order_id,Quantity,items)
 values (114,7,'Happy Cake')

  insert into order_summary (order_id,Quantity,items)
 values (115,1,'Ramadan Grill')

  insert into order_summary (order_id,Quantity,items)
 values (116,8,'McDonald’s')

  insert into order_summary (order_id,Quantity,items)
 values (117,11,'Sushi House')

SELECT COUNT (*) 
FROM EMPLOYEEE
WHERE Lname LIKE 'H%'

SELECT restaurant_name ,restaurant_loc
FROM RESTAURANTT left outer join MENUU on restaurant_id= RESTO_id
WHERE food_type='FAST FOOD'

 SELECT Fname ,Lname 
 FROM EMPLOYEEE
 WHERE salary< ALL (SELECT salary
 FROM EMPLOYEEE
 WHERE salary>10000);

 SELECT DISTINCT (restaurant_name),Destanation 
 FROM ORDERR,RESTAURANTT
 WHERE order_ID=111;




 select *
 from TRIG_audit