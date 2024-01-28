CREATE DATABASE otlob;

create table resturantt
(
rest_ID int not null,
rest_name varchar(20) not null,
rest_location varchar (30),
constraint reste_PK
primary key (rest_ID),
);
create table advertisment
(
Ads_iD int not null,
Ads_name varchar(20) not null,
Ads_type varchar(20),
Ads_date varchar(10),
rest_ID int not null,
constraint ads_PK
primary key (Ads_ID),
constraint unique_ads
unique (Ads_name),
constraint resturant_fk
foreign key (rest_ID) references resturantt (rest_ID)
);
create table customer(
cust_id int not null,
phone_number int not null,
cust_email varchar(30) not null,
constraint cust_Pk
primary key (cust_id),
constraint unique_phone
unique (phone_number)
);
create table cust_address(
 customer_address varchar(30) not null,
 cust_id int not null,
 constraint multiadress_Pk
 primary key (cust_id , customer_address),
  constraint cust_id_fk foreign key (cust_id) references customer (cust_id)
);
create table cust_credit_card(
 credit_card varchar(30) not null,
 cust_id int not null,
 constraint cust_credit_Pky
 primary key (cust_id , credit_card),
  constraint cust_id_fky foreign key (cust_id) references customer (cust_id)
);

create table ORDERR(
order_id int not null,
rest_ID int not null,
cust_id int not null,
destination varchar(20) not null,
order_date varchar(10) not null,
constraint order_PK
primary key (order_id),
constraint resturant_ORDER_FK
foreign key ( rest_ID) references resturantt (rest_ID),
constraint cust_order_fk 
 foreign key (cust_id) references customer (cust_id)
);

create table order_sammary(
quanatity int,
items varchar(50),
orderid int,
constraint ordersum_PK
primary key (orderid , items),
constraint cust_ordersumm_fk 
 foreign key (orderid) references ORDERR (order_id)
);

INSERT INTO resturantt
VALUES (1,'mac','5th installments');
INSERT INTO resturantt
VALUES (2,'cockdoor','medint nasr');
INSERT INTO resturantt
VALUES (3,'hadrmoot','alnozha');
INSERT INTO resturantt
VALUES (4,'bick','alf maskan');
INSERT INTO resturantt
VALUES (5,'mac','amar abn yasser');
INSERT INTO resturantt
VALUES (6,'mac','citystars');
INSERT INTO resturantt
VALUES (7,'mac','alex');


INSERT INTO advertisment
VALUES (1,'let it go','motivational', '22/7/2010', 1);
INSERT INTO advertisment
VALUES (2,'just do it ','motivational', '28/3/2012',2);
INSERT INTO advertisment
VALUES (3,'happy meal','food', '30/6/2016', 3);
INSERT INTO advertisment
VALUES (4,'chicken danger','food', '10/3/2017', 4);
INSERT INTO advertisment
VALUES (5,'yum yum ','food', '25/8/2019', 5);
INSERT INTO advertisment
VALUES (6,'zombie land  ','gaming', '29/8/2019', 5);


INSERT INTO customer
VALUES (1,'01017109118', 'ahmedmohmed@gmail.com');
INSERT INTO customer
VALUES (2,'01227109318', 'khaledmohmed@gmail.com');
INSERT INTO customer
VALUES (3,'01018121927', 'omaralaa@yahoo.com');
INSERT INTO customer
VALUES (4,'01012139456', 'zaks2456@hotmail.com');
INSERT INTO customer
VALUES (5,'01012782934', 'lol1234@bue.edu.eg');
INSERT INTO customer
VALUES (6,'01012782334', 'omar245@bue.edu.eg');

insert into cust_address
values ( ' al nozha ', 1)
insert into cust_address
values ( ' sherok company ',1)
insert into cust_address
values (' al marg ', 3)
insert into cust_address
values (' al tameer company ',3)
insert into cust_address
values ('masr al gdida',2)
insert into cust_address
values ('alex',4)
insert into cust_address
values ('shraton',4)
insert into cust_address
values ('shraton',6)

insert into cust_credit_card
values ('1125467980',1)
insert into cust_credit_card
values ('1125467456',1)
insert into cust_credit_card
values ('1123479803',2)
insert into cust_credit_card
values ('1128769803',3)
insert into cust_credit_card
values ('1234564803',4)
insert into cust_credit_card
values ('1998579803',5)
insert into cust_credit_card
values ('1123324503',6)

INSERT INTO ORDERR
VALUES (1,1,1,'masr al gdida', '22/7/2010');
INSERT INTO ORDERR
VALUES (2,2,2,'masr al gdida', '23/7/2010');
INSERT INTO ORDERR
VALUES (7,7,2,'masr al gdida', '23/7/2010');
INSERT INTO ORDERR
VALUES (3,3,3,'rehab', '22/9/2019');
INSERT INTO ORDERR
VALUES (4,4,4,'alex', '1/1/2015');
INSERT INTO ORDERR
VALUES (5,5,5,'shraton', '27/1/2012');
INSERT INTO ORDERR
VALUES (6,6,6,'shraton', '27/12/2019');

INSERT INTO order_sammary
VALUES ( 2 , 'BIG TASTY' , 1)
INSERT INTO order_sammary
VALUES ( 1 , 'CHICKEN MAGDO' , 2)
INSERT INTO order_sammary
VALUES ( 3, 'BIG TASTY' , 3)
INSERT INTO order_sammary
VALUES ( 4, 'ice cream' , 4)
INSERT INTO order_sammary
VALUES ( 5, 'small meal' , 5)
INSERT INTO order_sammary
VALUES ( 6, 'happy meal' , 6)

SELECT rest_name , rest_location
FROM resturantt
WHERE rest_name='mac';

SELECT *
FROM advertisment
WHERE Ads_type= 'motivational' OR Ads_type= 'gaming';

SELECT e.customer_address
FROM  cust_address e
WHERE e.customer_address in (SELECT destination 
FROM ORDERR
WHERE e.customer_address =
ORDERR.destination
AND (e.cust_id = cust_id));

SELECT items , quanatity
FROM order_sammary
LEFT JOIN customer
ON customer.cust_id = order_sammary.orderid;

SELECT COUNT(customer_address) as ' people live in shraton'
FROM cust_address
WHERE customer_address = 'shraton';

SELECT rest_name
FROM resturantt
WHERE EXISTS
(SELECT order_date   FROM ORDERR WHERE resturantt.rest_ID = ORDERR.rest_ID and order_id < 3);

create table trig_audit(
 cust_id int not null,
phone_number int,
cust_email varchar(30),
paudit varchar(50),
Temp date,
)

GO
CREATE TRIGGER Trig
ON customer
FOR INSERT
AS
declare @cust_id INT;
declare @phone_number int;
declare @cust_email varchar(30);
declare @paudit varchar(50);
select @cust_id = i.cust_id from inserted i;
select @phone_number = i.phone_number from inserted i; 
select @cust_email = i.cust_email from inserted i;
select @paudit = 'Insert trigger executed';
INSERT INTO trig_audit
VALUES (@cust_id,@phone_number,@cust_email,@cust_id,getdate());
PRINT 'Trigger successfully executed'

INSERT INTO customer
VALUES (7,'01223782334', 'jana@bue.edu.eg');

select *
from trig_audit