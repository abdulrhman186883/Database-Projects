




Create Database Otlob2;



Create Table Employee(
Employee_ID INT NOT NULL,
Fname VARCHAR(20) NOT NULL,
Lname VARCHAR(20) NOT NULL,
Bdate VARCHAR(10),
Sex CHAR,
Salary INT NOT NULL,
Dno INT NOT NULL,
Constraint EmpPK Primary Key (Employee_ID),
);
Create Table EmployeeAddress(
EmployeeID int NOT NULL,
Street_Name Varchar(20),
BuildingNumber INT,
ApartmentNumber INT,
Constraint EmpAddressPK Primary Key (EmployeeID , ApartmentNumber),
CONSTRAINT EmpAddressFK FOREIGN KEY (EmployeeID) REFERENCES Employee (Employee_ID),
);
Create Table Customer(
Customer_ID Int Not Null,
Fname 			VARCHAR(20) 	NOT NULL,
Lname 		VARCHAR(20) 	NOT NULL,
PhoneNumber Int Not NUll,
CustomerEmail VARCHAR(50) Not NUll,
Sex 			CHAR,
Constraint CustomerPK Primary Key (Customer_ID),
);
Create Table CustomerCreditCard(
CustomerID int NOT NULL,
Credit_Card_Number INT NOT NULL,
Expiration_Date DATE,
CCV INT,
CONSTRAINT CustomerCC_PK PRIMARY KEY (CustomerID, Credit_Card_Number),
CONSTRAINT CustomerCC_FK FOREIGN KEY (CustomerID) REFERENCES Customer (Customer_ID),
);
Create Table CustomerAddress(
CustomerID int NOT NULL,
Street_Name Varchar(20),
BuildingNumber INT,
ApartmentNumber INT,
Constraint Cust_AddressPK Primary Key (CustomerID , ApartmentNumber),
CONSTRAINT Cust_AddressFK FOREIGN KEY (CustomerID) REFERENCES Customer (Customer_ID),
);
Create Table Orders(
OrderId Int Not Null,
OrderDate Date,
OrderDestination Varchar(20) NOT NULL,
EmployeeID INT,
CustomerID INT,
Constraint OrderPK Primary Key (OrderId),
Constraint EmpFK Foreign Key (EmployeeID) References Employee (Employee_ID),
Constraint CustomerFK Foreign Key (CustomerID) References Customer (Customer_ID),
);
Create Table Payment(
PaymentID int NOT NULL,
PaymentType varchar(20) Not Null,
TotalCost int,
PaymentDate Date,
CustomerID int,
Constraint PaymentPK Primary Key (PaymentID),
Constraint CustomerPaymentFK Foreign Key (CustomerID) References Customer (Customer_ID),
);
Create Table OrderSummary(
OrderID int NOT NULL,
Quantity int,
Items Varchar(30),
Constraint OrderSummaryPK Primary Key (OrderID , Quantity, Items),
Constraint SummaryFK Foreign Key (OrderID) References Orders (OrderId),
);
Alter Table EmployeeAddress
add Area Varchar(20);
Alter Table CustomerAddress
add Area Varchar(20);
Alter Table CustomerCreditCard DROP CONSTRAINT CustomerCC_PK;
Alter Table CustomerCreditCard Alter Column Credit_Card_Number varchar(30) NOT NULL;
Alter Table CustomerCreditCard Add Constraint CustomerCC_PK PRIMARY KEY (CustomerID, Credit_Card_Number);

INSERT INTO Employee Values (101, 'Kareem','Abed','26/5/1990', 'M', 50000, 01);
INSERT INTO Employee Values (102, 'Adham','Selim','14/1/1995', 'M', 10000, 01);
INSERT INTO Employee Values (103, 'Ahmed','Yasser','6/11/1994', 'M', 25000, 02);
INSERT INTO Employee Values (104, 'Saif','Haitham','15/9/1998', '', 15000, 01);
INSERT INTO Employee Values (105, 'Youssed','Ahmed','8/4/1991', 'M', 40000, 02);
INSERT INTO Employee Values (106, 'Hussein','Khaled','', 'M', 10000, 01);

INSERT INTO EmployeeAddress Values (101,'Omar Ibn Al Khattab',14,22,'Rehab' );
INSERT INTO EmployeeAddress Values (101,'Abbas el Akkad',98,31,'Nasr City' );
INSERT INTO EmployeeAddress Values (102,'Ibrahim El Orabi',19,11,'Nozha' );
INSERT INTO EmployeeAddress Values (102,'El Zohour',180,21,'Mohandessin' );
INSERT INTO EmployeeAddress Values (103,'Ibrahim El Orabi',19,11,'El Nozha' );
INSERT INTO EmployeeAddress Values (104,'Omar Ibn Al Khattab',185,32,'Almaza' );
INSERT INTO EmployeeAddress Values (105,'Omar Ibn Al Khattab',14,32,'Rehab' );
INSERT INTO EmployeeAddress Values (106,'Abbas el Akkad',190,21,'Nasr City' );

INSERT INTO Customer Values (201, 'Mohamed','Sherif',01297887991,'Mohamed@gmail.com','M');
INSERT INTO Customer Values (202, 'Youssed','Zayed',01231556095,'Youssed@gmail.com','');
INSERT INTO Customer Values (203, 'Zeyad','Ossama',01182773974,'Zeyad@yahoo.com','M');
INSERT INTO Customer Values (204, 'Adham','Megahed',01251667032,'Adham@gmail.com','M');
INSERT INTO Customer Values (205, 'Kareem','Mohamed',01997887991,'Kareem@gmail.com','M');

INSERT INTO CustomerAddress Values (201,'Othman Ibn Affan',91,32,'Rehab' );
INSERT INTO CustomerAddress Values (201,'Ibrahim El Orabi',150,31,'El Nozha' );
INSERT INTO CustomerAddress Values (202,'Ibrahim El Orabi',85,12,'El Nozha' );
INSERT INTO CustomerAddress Values (202,'Omar Ibn Al Khattab',14,31,'Rehab' );
INSERT INTO CustomerAddress Values (203,'Abbas El Akkad',99,41,'Nasr City' );
INSERT INTO CustomerAddress Values (204,'Omar Ibn Al Khattab',185,32,'Almaza' );
INSERT INTO CustomerAddress Values (205,'Othamn Ibn Affan',91,32,'Rehab' );
INSERT INTO CustomerAddress Values (205,'Abbas el Akkad',44,42,'Nasr City' );

INSERT INTO CustomerCreditCard Values (201,'4645796860481833','12/10/2019', 994);
INSERT INTO CustomerCreditCard Values (201,'4447096704314138','8/7/2023', 288);
INSERT INTO CustomerCreditCard Values (202,'4395333439185703','1/2/2022', 249);
INSERT INTO CustomerCreditCard Values (203,'4089549995429567','3/9/2024', 547);
INSERT INTO CustomerCreditCard Values (205,'4418234865335304','12/12/2019', 980);
INSERT INTO CustomerCreditCard Values (205,'4230030470020950','1/4/2022', 360);
INSERT INTO CustomerCreditCard Values (205,'4955314796464335','', 780);

INSERT INTO Orders Values (4366 , '2/11/2019' , 'Rehab' , 101 , 201);
INSERT INTO Orders Values (5416 , '11/11/2019' , 'Nasr City' , 101 , 203);
INSERT INTO Orders Values (9185 , '2/11/2019' , 'El Nozha' , 102 , 202);
INSERT INTO Orders Values (8871 , '10/5/2019' , 'Rehab' , 104 , 205);
INSERT INTO Orders Values (1010 , '2/11/2019' , 'Almaza' , 104 , 204);

INSERT INTO OrderSummary Values (4366 , 5 , 'McRoyale');
INSERT INTO OrderSummary Values (4366 , 1 , 'Milkshake');
INSERT INTO OrderSummary Values (4366 , 2 , 'Big Tasty');
INSERT INTO OrderSummary Values (5416 , 1 , 'King Mo Offer');
INSERT INTO OrderSummary Values (9185 , 2 , 'Chichken Ranch');
INSERT INTO OrderSummary Values (9185 , 1 , 'Chicken BBQ');
INSERT INTO OrderSummary Values (1010 , 1 , 'Big Mac');

INSERT INTO Payment Values (5159 , 'Cash' , 119 ,'2/11/2019' ,204);
INSERT INTO Payment Values (6078 , 'Credit Card' , 180 ,'2/11/2019' ,201);
INSERT INTO Payment Values (1151 , 'Cash' , 75 ,'2/11/2019' ,201);
INSERT INTO Payment Values (5431 , 'Credit Card' , 240 , '10/5/2019' ,205);
INSERT INTO Payment Values (0934 , 'Cash' , 100 ,'2/11/2019',202);

/* Drivers who delivered more than 1 order */
select Fname , Lname, count(EmployeeID) AS 'Number of Deliveries'
from Employee , Orders
Where Employee_ID = EmployeeID 
Group By Fname , Lname
Having COUNT(EmployeeID) > 1;

/*Customers Who Have Credit Cards */
select Fname , Lname , PhoneNumber
from Customer
Where Exists ( select *
from CustomerCreditCard
Where Customer_ID = CustomerID) ;

/*Max Salary of Driver who delivered to Rehab*/
Select MAX(Salary) AS 'Salary'
from Employee
Where Employee_ID IN ( select EmployeeID
from Orders 
WHERE Employee_ID = EmployeeID AND OrderDestination = 'Rehab' );

/*Shows customers and their credit card number(s) if available*/
select Fname , Lname , Customer_ID, Expiration_Date , Credit_Card_Number
from Customer left outer join CustomerCreditCard
ON Customer.Customer_ID = CustomerCreditCard.CustomerID;

/*Got the order summary of the customer with a yahoo email */
select OrderID , Items , Quantity 
from OrderSummary
where OrderID IN ( select OrderId
from Orders
where CustomerID IN (select Customer_ID
from Customer
where CustomerEmail like '%yahoo.com'));

/* Tirgger */
Create Table Auditing(
Customer_ID INT,
FName VARCHAR(20),
LName VARCHAR(20),
PhoneNumber INT,
CustomerEmail varchar(50),
Sex char,
Audit_msg VARCHAR(50),
Audit_date Date
);
GO
 CREATE TRIGGER Trig
ON Customer

AFTER INSERT
AS
declare @Customer_ID INT;
declare @Fname VARCHAR(20);
declare @Lname VARCHAR(20);
declare @PhoneNumber INT;
declare @CustomerEmail VARCHAR(50);
declare @Sex Char;
declare @paudit VARCHAR(50);
select @Customer_ID = i.Customer_ID from inserted i;
select @Fname = i.Fname from inserted i;
select @Lname = i.Lname from inserted i;
select @PhoneNumber = i.PhoneNumber from inserted i;
select @CustomerEmail = i.CustomerEmail from inserted i;
select @Sex = i.Sex from inserted i;
select @paudit = 'Insert trigger executed';
INSERT INTO Auditing
VALUES (@Customer_ID,@Fname,@Lname,@PhoneNumber,@CustomerEmail,@Sex,@paudit,getdate());
PRINT 'Trigger successfully executed' 

INSERT INTO Customer Values (208, 'Ahmed','Mohamed',01187556987,'AMOHAMED@gmail.com','M');

/* VIEW */
Create View CustomerPaid 
AS SELECT Fname , Lname , TotalCost , PaymentType
from Customer , Payment
WHERE Customer.Customer_ID = Payment.CustomerID;

select * from CustomerPaid;


