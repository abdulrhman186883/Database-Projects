CREATE DATABASE OlobFInalPhase190008;

CREATE TABLE Customer(
Fname VARCHAR(20) NOT NULL,
Lname VARCHAR(20),
Sex CHAR,
Customer_Id INT NOT NULL,
Phone_Number INT NOT NULL,
Customer_Mail VARCHAR(40) NOT NULL,

CONSTRAINT cust_pk PRIMARY KEY(Customer_Id)
);

CREATE TABLE Restaurant(
Rest_Name VARCHAR(20) NOT NULL,
Restaurant_Id INT NOT NULL,
Rest_Location VARCHAR(20),

CONSTRAINT rest_pk PRIMARY KEY(Restaurant_Id)
);

CREATE TABLE Orders(
Order_Id INT NOT NULL,
Order_Date Date,
Destination VARCHAR(20),
Rest_Id INT NOT NULL,
Cust_Id INT NOT NULL,
Driver_Id INT,

CONSTRAINT order_pk PRIMARY KEY(Order_Id),

CONSTRAINT cust_order
FOREIGN KEY(Cust_Id) REFERENCES Customer(Customer_Id)
ON UPDATE CASCADE,

CONSTRAINT rest_order
FOREIGN KEY(Rest_Id) REFERENCES Restaurant(Restaurant_Id)
ON UPDATE CASCADE,
);

CREATE TABLE Payment(
Payment_Id INT NOT NULL,
Payment_Date DATE,
Payment_Type VARCHAR(20),
Total_Cost INT,
Custp_Id INT NOT NULL,

CONSTRAINT p_pk PRIMARY KEY(Payment_Id),

CONSTRAINT cust_p
FOREIGN KEY(Custp_Id) REFERENCES Customer(Customer_Id)
ON UPDATE CASCADE
);

CREATE TABLE Customer_CreditCard(
CreditCard_Number INT NOT NULL,
CustId INT NOT NULL,
Exp_Date DATE NOT NULL,
CVV INT NOT NULL,

CONSTRAINT credit_pk PRIMARY KEY(CreditCard_Number,CustID),

CONSTRAINT credit_cust
FOREIGN KEY(CustId) REFERENCES Customer(Customer_Id)
ON UPDATE CASCADE
);

CREATE TABLE OrderSummary(
OrderId INT NOT NULL,
Quantity INT NOT NULL,
Items VARCHAR(15),
RestID INT NOT NULL,
CONSTRAINT sum_pk PRIMARY KEY(OrderId,Quantity,Items),

CONSTRAINT sum_order
FOREIGN KEY(OrderId) REFERENCES Orders(Order_Id)
ON UPDATE CASCADE
);

CREATE TABLE CustomerAddress(
CustomersId INT NOT NULL,
ApartmentNo INT NOT NULL,
BuldingNo INT NOT NULL,
StreetName VARCHAR(20) NOT NULL,
Area VARCHAR(20),
CONSTRAINT address_pk PRIMARY KEY(CustomersId,ApartmentNo,BuldingNo,StreetName),
CONSTRAINT address_fk FOREIGN KEY(CustomersId) REFERENCES Customer(Customer_Id)
ON UPDATE CASCADE
);

ALTER TABLE Orders
ALTER COLUMN Order_Date VARCHAR(10);

ALTER TABLE Payment
ALTER COLUMN Payment_Date VARCHAR(10);

ALTER TABLE Customer_CreditCard
ALTER COLUMN Exp_Date VARCHAR(10);

ALTER TABLE OrderSummary
DROP COLUMN RestID;

INSERT INTO Customer(Fname,Lname,Sex,Customer_Id,Phone_Number,Customer_Mail)
VALUES('Ahmed','Abas','M','1','0154535','ahmed@gmail.com');
INSERT INTO Customer
VALUES('Mona','hesham','F','2','01232535','mona@bue.edu.eg');
INSERT INTO Customer
VALUES('Israa','osama','F','3','01848929','israa@gmail.com');
INSERT INTO Customer
VALUES('Noor','Bassem',NULL,'4','019000304','noor@yahoo.com');
INSERT INTO Customer
VALUES('Mohamed',NULL,'M','5','01003947522','moh@bue.edu.eg');
INSERT INTO Customer
VALUES('Abdulrahman','yousef','M','6','0199998324','abdo@yahoo.com');
INSERT INTO Customer
VALUES('Sara',' ','F','7','0920348294','sara@bue.edu.eg');

UPDATE Customer
SET Lname='Ahmed'
WHERE Customer_Id=7;

INSERT INTO Restaurant(Rest_Name,Restaurant_Id,Rest_Location)
VALUES('Buffalo','01','New Cairo');
INSERT INTO Restaurant
VALUES('Pizza Hut','02','ALRehab');
INSERT INTO Restaurant
VALUES('City Crepe','03','Al maadi');
INSERT INTO Restaurant
VALUES('Cinnabon','04',NULL);
INSERT INTO Restaurant
VALUES('KFC','05','Nasr City');
INSERT INTO Restaurant
VALUES('MAC','06','Nasr City');
INSERT INTO Restaurant
VALUES('Heart attack','07','Madinaty');

INSERT INTO Orders(Order_Id,Order_Date,Destination,Rest_Id,Cust_Id,Driver_Id)
VALUES('101','14/2/2019','AlRehab','05','7',NUll);
INSERT INTO Orders
VALUES('102','25/10/2019','New Cairo','02','2',NULL);
INSERT INTO Orders
VALUES('103','6/3/2018','Nasr City','06','7','92');
INSERT INTO Orders
VALUES('104','22/9/2018','Nasr City','07','6','92');
INSERT INTO Orders
VALUES('105','22/6/2019','Nasr city','04','7','93');
INSERT INTO Orders
VALUES('106','30/11/2017','Al maadi','03','1','94');
INSERT INTO Orders
VALUES('107','9/1/2017','Nasr City','05','4','92');

UPDATE Orders
SET Cust_Id=7
WHERE Order_Id=101;

UPDATE Orders
SET Cust_Id=2
WHERE Order_Id=102;

UPDATE Orders
SET Destination='Madinaty'
WHERE Order_Id=102;

UPDATE Orders
SET Destination='Ramsis'
WHERE Order_Id=107;


INSERT INTO Payment(Payment_Id,Payment_Date,Payment_Type,Total_Cost,Custp_Id)
VALUES ('1001','10/10/2019','Credit Card','150','7');
INSERT INTO Payment
VALUES ('1002','7/6/2019','Credit Card','180','5');
INSERT INTO Payment
VALUES ('1003','27/3/2019','Cash','90','3');
INSERT INTO Payment
VALUES ('1004','25/4/2018',NULL,'80','6');
INSERT INTO Payment
VALUES ('1005','24/3/2018','Cash','130','7');
INSERT INTO Payment
VALUES ('1006','7/7/2017','Credit Card','75','1');
INSERT INTO Payment
VALUES ('1007','15/12/2017','Cash',' ','4');

INSERT INTO Customer_CreditCard(CreditCard_Number,CustId,Exp_Date,CVV)
VALUES ('3505120','5','10/10/2021','324');
INSERT INTO Customer_CreditCard
VALUES ('3505004','7','15/8/2020','569');
INSERT INTO Customer_CreditCard
VALUES ('35505778','7','17/9/2021','409');
INSERT INTO Customer_CreditCard
VALUES ('35055055','1','5/2/2020','322');
INSERT INTO Customer_CreditCard
VALUES ('3501239','6','22/7/2022','179');
INSERT INTO Customer_CreditCard
VALUES ('35550382','6','17/6/2020','891');
INSERT INTO Customer_CreditCard
VALUES ('34440911','1','9/1/2021','423');

INSERT INTO OrderSummary(OrderId,Quantity,Items)
VALUES ('103','5','Big Mac')
INSERT INTO OrderSummary
VALUES ('106','3','Crepe');
INSERT INTO OrderSummary
VALUES ('107','2','Rizo');
INSERT INTO OrderSummary
VALUES ('104','4','Burgers');
INSERT INTO OrderSummary
VALUES ('101','4','Twister');
INSERT INTO OrderSummary
VALUES ('105','2','Cinnabon');
INSERT INTO OrderSummary
VALUES ('102','1','Pizza');

UPDATE OrderSummary
SET Items='Burgers'
WHERE OrderId=103;

INSERT INTO CustomerAddress(CustomersId,ApartmentNo,BuldingNo,StreetName,Area)
VALUES('1','03','25','9 St','Al maadi');
INSERT INTO CustomerAddress
VALUES('2','10','26','ElWaha St','Madinaty');
INSERT INTO CustomerAddress
VALUES('7','04','27','ELkhattab St','AlRehab');
INSERT INTO CustomerAddress
VALUES('4','08','28','Ramsis St',NUll);
INSERT INTO CustomerAddress
VALUES('5','07','29','Abass St','Nasr City');
INSERT INTO CustomerAddress
VALUES('6','09','30','Makram St','Nasr City');
INSERT INTO CustomerAddress
VALUES('7','04','25','Makram St','Nasr City');

SELECT DISTINCT Fname as 'First Name'
FROM Customer,CustomerAddress,Restaurant,Orders
WHERE Customer_Id IN (SELECT CustomersId
FROM CustomerAddress
WHERE Area='Nasr City')
AND Restaurant_Id IN(SELECT Rest_Id
FROM Orders,Restaurant
WHERE Destination='Nasr City')
AND Restaurant_Id IN (SELECT Rest_Id
FROM Restaurant,Orders
WHERE Rest_Location='Nasr City')



SELECT Lname as 'Last name', Payment_Type As 'Payment Type'
FROM Customer RIGHT OUTER JOIN Payment
ON Customer_Id=Custp_Id
WHERE Sex!='F' AND
Payment_Type!='Cash';

 
SELECT DISTINCT Order_Date  as 'Date of order', Order_Id
FROM Orders
WHERE Order_Id IN( SELECT OrderId
FROM OrderSummary
WHERE Items='Burgers')



SELECT COUNT(*) as 'Num of orders', Order_Id
FROM Orders
WHERE Cust_Id IN ( SELECT Customer_Id
FROM Customer
WHERE Fname='Sara')
GROUP BY Order_Id

SELECT Fname as 'Name of Customers'
FROM Customer
WHERE Customer_Id IN (SELECT Cust_Id
FROM Orders
WHERE Driver_Id='92')

