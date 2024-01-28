CREATE TYPE AddressT AS OBJECT
(
  City VARCHAR(10),
  Street VARCHAR(10),
  ZipCode INTEGER
);

CREATE TYPE UserPhone AS VARRAY(3) OF REAL;

CREATE TYPE UserT AS OBJECT
(
  UsID integer,
  AGE integer,
  Address  AddressT,
  UsPhone UserPhone,
  MAP MEMBER FUNCTION get_idno RETURN NUMBER,
  MEMBER PROCEDURE display_address ( SELF IN OUT NOCOPY UserT ),
  MEMBER PROCEDURE display_phones ( SELF IN OUT NOCOPY UserT )
) NOT FINAL INSTANTIABLE;

CREATE TYPE BODY UserT AS
  MAP MEMBER FUNCTION get_idno RETURN NUMBER IS
  BEGIN
    RETURN UsID;
  END;

  MEMBER PROCEDURE display_address ( SELF IN OUT NOCOPY UserT ) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE(Address.Street);
    DBMS_OUTPUT.PUT_LINE(Address.City || ', '  || Address.ZipCode);   
  END;

  MEMBER PROCEDURE display_phones ( SELF IN OUT NOCOPY UserT ) IS
  BEGIN
    FOR l_index IN UsPhone.FIRST..UsPhone.LAST 
    LOOP
        dbms_output.put_line(UsPhone(l_index ));
    END LOOP;   
  END;
END;

Create Table Userr OF UserT
(
  CONSTRAINT UserID
  UNIQUE(UsID)
); 

Create TYPE AdminT UNDER UserT (
  Type VARCHAR(25)
);

Create TYPE CoachT UNDER UserT (
  Specilization VARCHAR(25)
);

CREATE TYPE BMI_T AS OBJECT
(
  height FLOAT,
  weight FLOAT
);


CREATE TYPE CustomerT UNDER UserT  (
BMI BMI_T
);

create TYPE AccountT AS OBJECT(
  Username VARCHAR(30),
  password VARCHAR(20),
  AccID REF UserT
) NOT FINAL INSTANTIABLE;

create table Account OF AccountT(
  CONSTRAINT AccountID
  UNIQUE(Username),
  AccID SCOPE IS Userr 
);

create TYPE AdminAccountT AS OBJECT(
  Username REF AccountT,
  Admin_ID REF UserT
) NOT FINAL INSTANTIABLE;

Alter TYPE AdminAccountT ADD ATTRIBUTE Admin_ID REF UserT CASCADE

Create Table AdminAccount of AdminAccountT (
  Username SCOPE IS Account,
  Admin_ID SCOPE IS Userr
);

CREATE TYPE SponsorPhone AS VARRAY(3) OF REAL;

create TYPE SponsorT AS OBJECT(
  SPID INTEGER,
  SponsoringTime VARCHAR(20),
  SponsorName VARCHAR(20),
  sPhone SponsorPhone,
  sEmail VARCHAR(50)
);

Create table Sponsor OF SponsorT(
  CONSTRAINT SponsorID
  UNIQUE(SPID)
);

create TYPE UserSponsorT AS OBJECT(
  UsID REF UserT,
  Sponsor_ID REF SponsorT
) NOT FINAL INSTANTIABLE;

create table UserSponsor OF UserSponsorT(
  UsID SCOPE IS Userr,
  Sponsor_ID SCOPE IS Sponsor
) ;

create TYPE AdvertismentT AS OBJECT(
  AID INTEGER,
  AType VARCHAR(20),
  ARealeasedDate VARCHAR(20),
  AName VARCHAR(20),
  Spons_ID REF SponsorT,
  Admin_ID REF UserT
) INSTANTIABLE;

create table Advertisment OF AdvertismentT(
  CONSTRAINT AdID
  UNIQUE(AID),
  Spons_ID SCOPE IS Sponsor ,
  Admin_ID SCOPE IS Userr
);

create Type WorkoutT AS OBJECT(
  WID INTEGER,
  workoutName VARCHAR(20),
  NumOfRounds INTEGER,
  WorkoutTime VARCHAR(20)
);

create table Workout OF WorkoutT(
  CONSTRAINT WORKID
  UNIQUE(WID)
);

create TYPE workoutCustomerT AS OBJECT(
  work_ID REF WorkoutT,
  Cust_ID REF UserT
) INSTANTIABLE;

create table workoutCustomer OF workoutCustomerT(
  work_ID SCOPE IS Workout,
  Cust_ID SCOPE IS Userr
);

create type workoutCoachT AS OBJECT(
  work_ID REF WorkoutT,
  Coach_ID REF UserT
) INSTANTIABLE;

create table workoutCoach OF workoutCoachT (
  work_ID SCOPE IS Workout,
  Coach_ID SCOPE IS Userr
);


create type DietProgramT AS OBJECT(
  DID INTEGER,
  Price FLOAT,
  DietName VARCHAR(20),
  StartDate VARCHAR(20),
  EndDate VARCHAR(20),
  Coach_ID REF UserT
);

create table DietProgram OF DietProgramT(
  CONSTRAINT DietProgID
  UNIQUE(DID),
  Coach_ID SCOPE IS Userr
);

create type DietCustomerT AS OBJECT(
  DID REF DietProgramT,
  Cust_ID REF UserT
);
 
create table DietCustomer OF DietCustomerT(
  DID SCOPE IS DietProgram,
  Cust_ID SCOPE IS Userr
);

create type itemT AS OBJECT(
  ItemID INTEGER,
  Diet_ID REF DietProgramT
) NOT FINAL INSTANTIABLE;

create table item OF itemT (
  CONSTRAINT ItemNameID
  UNIQUE(ItemID),
  Diet_ID SCOPE IS DietProgram
);

create type CustomerItemT AS OBJECT(
  ItemID ref itemT,
  Cust_ID REF UserT
) NOT FINAL INSTANTIABLE;


create table CustomerItem OF CustomerItemT (
  Cust_ID SCOPE IS Userr,
  ItemID SCOPE IS item
);
create type itemSponserT AS OBJECT (
  ItemID ref itemT,
  spons_ID ref SponsorT
);

create table itemSponser OF itemSponserT (
  ItemID SCOPE IS item,
  spons_ID SCOPE IS Sponsor
);

Create TYPE FoodT UNDER itemT (
  FoodQuatity integer,
  FoodName varchar(30),
  Calories float,
  protein float,
  Carbohydrates float,
  Fats float
);

Create TYPE SupplementT UNDER itemT (
  SupplementName varchar(30),
  Dose float,
  SupplementQuantity float,
  ExpirationDate varchar (30)
);

create type PaymentT AS OBJECT(
  PID INTEGER,
  CreditCardNum varchar (30),
  CreditCardName varchar (30),
  PaymentDate varchar (30),
  PinCode varchar (4)
);

create table Payment OF PaymentT(
  CONSTRAINT PaymentID
  UNIQUE(PID)
);

Create type SubscrIptionT AS OBJECT(
  SID INTEGER,
  SType VARCHAR(20),
  PID REF PaymentT
) NOT FINAL ;

create table Subscription OF SubscrIptionT(
  CONSTRAINT SubcriptionID
  UNIQUE(SID),
  PID SCOPE IS Payment
);

Alter TYPE CustomerT ADD ATTRIBUTE
(SID REF SubscrIptionT ) CASCADE;

Create TYPE ReviewT AS OBJECT(
  RIDD INTEGER,
  Commentt VARCHAR(20),
  Cust_ID REF UserT,
  Rating FLOAT,
);


Create table Review OF ReviewT (
  CONSTRAINT ReviewID
  UNIQUE(RIDD),
  Cust_ID SCOPE IS Userr
);

create type AdminAdT AS OBJECT(
  Admin_ID ref UserT,
  ADID ref AdvertismentT 
);

create table AdminAd of AdminAdT (
  Admin_ID scope is Userr,
  ADID scope is Advertisment 
);

create type CustomerPaymentT AS OBJECT(
  customer_ID ref UserT,
  Payment_ID ref PaymentT 
);

create table CustomerPayment of CustomerPaymentT (
  customer_ID scope is Userr,
  Payment_ID scope is Payment 
);

---------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------

INSERT ALL 
INTO Userr VALUES (AdminT('1', '30', AddressT('Madinty', 'South park', '11234'), UserPhone('01201493395', '01000000000'), 'General'))
INTO Userr VALUES (AdminT('2', '35', AddressT('Shrouk', 'Waha St', '12237'), UserPhone('01201493395', '01000000000'), 'General'))
INTO Userr VALUES (CoachT('3', '27', AddressT('October', 'St', '12287'), UserPhone('01200000005', '01000000000'), 'Diet'))
INTO Userr VALUES (CoachT('4', '27', AddressT('Qena', 'St', '12287'), UserPhone('01200000005', '01000000000'), 'Diet'))
INTO Userr VALUES (CoachT('5', '27', AddressT('Isamilia', 'St', '12287'), UserPhone('01200000005', '01000000000'), 'Diet'))
INTO Userr VALUES (CoachT('6', '27', AddressT('Luxor', 'St', '12287'), UserPhone('01200000005', '01000000000'), 'Diet'))
SELECT * FROM DUAL; 

INSERT INTO Userr VALUES(CustomerT('7', '30', AddressT('Madinty', 'South park', '11834'), UserPhone('01201493395', '01000000000'),BMI_T('174.0','80.8'),(Select ref(S) from Subscription S WHERE S.SID = '100')))
INSERT INTO Userr VALUES (CustomerT('8', '30', AddressT('Madinty', 'South park', '11834'), UserPhone('01201493395', '01000000000'),BMI_T('174.0','80.8'),(Select ref(S) from Subscription S WHERE S.SID = '100')))
INSERT INTO Userr VALUES (CustomerT('9', '23', AddressT('Rehab', 'Talaat', '15634'), UserPhone('01204393395', '0100008900'),BMI_T('154.0','81.8'),(Select ref(S) from Subscription S WHERE S.SID = '200')))
INSERT INTO Userr VALUES (CustomerT('10', '30', AddressT('Heliopolis', 'Marghany', '11844'), UserPhone('01201493395', '01000000000'),BMI_T('170.0','60.9'),(Select ref(S) from Subscription S WHERE S.SID = '300')))


INSERT ALL
INTO Payment VALUES (PaymentT('10', '10001', 'Tom', '1/1/2020', '1234'))
INTO Payment VALUES (PaymentT('20', '20001', 'Tom', '1/1/2020', '1234'))
INTO Payment VALUES (PaymentT('30', '30001', 'Tom', '1/1/2020', '1234'))
INTO Payment VALUES (PaymentT('40', '40001', 'Tom', '1/1/2020', '1234'))
SELECT * FROM DUAL; 

INSERT
INTO Subscription Values (SubscrIptionT('100', 'Premium', (Select ref(P) from Payment P WHERE P.PID = '10')))

INSERT
INTO Subscription Values (SubscrIptionT('200', 'Premium', (Select ref(P) from Payment P WHERE P.PID = '10')))

INSERT
INTO Subscription Values (SubscrIptionT('300', 'Premium', (Select ref(P) from Payment P WHERE P.PID = '30')))
 
INSERT
INTO Subscription Values (SubscrIptionT('400', 'Premium', (Select ref(P) from Payment P WHERE P.PID = '20')))



INSERT
INTO DietProgram Values (DietProgramT('1000', '50.0', 'Keto', '1/1/2022', '1/2/2022', (Select ref(C) from Userr C WHERE C.UsID = '3')))

INSERT
INTO DietProgram Values (DietProgramT('2000', '100.0', 'Intermittent Fasting', '1/4/2022', '1/5/2022', (Select ref(C) from Userr C WHERE C.UsID = '4')))

INSERT
INTO DietProgram Values (DietProgramT('3000', '75.0', 'Plant-based diet', '22/1/2022', '16/2/2022', (Select ref(C) from Userr C WHERE C.UsID = '4')))

INSERT
INTO DietProgram Values (DietProgramT('4000', '50.0', 'Low Carb Diet', '15/3/2022', '15/5/2022', (Select ref(C) from Userr C WHERE C.UsID = '5')))

INSERT
INTO DietProgram Values (DietProgramT('5000', '50.0', 'DASH Diet', '16/6/2022', '22/8/2022', (Select ref(C) from Userr C WHERE C.UsID = '5')))

INSERT
INTO DietProgram Values (DietProgramT('6000', '150.0', 'MIND Diet', '17/4/2022', '30/6/2022', (Select ref(C) from Userr C WHERE C.UsID = '3')))

INSERT INTO Account Values ('Salma','1234',(Select ref(C) from Userr C WHERE C.UsID = '4'))
INSERT INTO Account Values ('Katy','1223', (Select ref(C) from Userr C WHERE C.UsID = '5'))
INSERT INTO Account Values ('Youssef','5673',(Select ref(C) from Userr C WHERE C.UsID = '6'))
INSERT INTO Account Values ('Zika','1134',(Select ref(A) from Userr A WHERE value(A) is of (AdminT) and A.UsID = '1'))
INSERT INTO Account Values ('Aly','1289',(Select ref(A) from Userr A WHERE A.UsID = '2'))
INSERT INTO Account Values ('Sara','1434',(Select ref(A) from Userr A WHERE A.UsID = '3'))


INSERT ALL 
INTO Workout VALUES ('11','Squats','3','15')
INTO Workout VALUES ('12','Push-ups','100','20')
INTO Workout VALUES ('13','Lunges','40','25')
SELECT * FROM DUAL;

INSERT INTO Review VALUES (ReviewT('111','Great',(Select ref(C) from Userr C WHERE C.UsID = '7'), '4.5'))
INSERT INTO Review VALUES (ReviewT('222','Average',(Select ref(C) from Userr C WHERE C.UsID = '8'), '3.2'))
INSERT INTO Review VALUES (ReviewT('333','Perfect Workout',(Select ref(C) from Userr C WHERE C.UsID = '9'), '5'))
INSERT INTO Review VALUES (ReviewT('444','Terrible',(Select ref(C) from Userr C WHERE C.UsID = '8'), '1'))

INSERT ALL
INTO item VALUES (FoodT('1111',(Select ref(D) from DietProgram D WHERE D.DID = '1000'),'10','Kiwi','60','20','4','1'))
INTO item VALUES (FoodT('2222',(Select ref(D) from DietProgram D WHERE D.DID = '2000'),'32','Rice Cake','200','20','50','4'))
INTO item VALUES (FoodT('3333',(Select ref(D) from DietProgram D WHERE D.DID = '3000'),'50','Brown Toast','320','10','70','3'))
INTO item VALUES (FoodT('4444',(Select ref(D) from DietProgram D WHERE D.DID = '1000'),'13','Apple','55','10','2','1'))
Select * from dual;

INSERT ALL
INTO item VALUES (SupplementT('5555',(Select ref(D) from DietProgram D WHERE D.DID = '1000'),'OptiFast','2','60','12/12/2024'))
INTO item VALUES (SupplementT('6666',(Select ref(D) from DietProgram D WHERE D.DID = '2000'),'Biotin','1','43','23/1/2024'))
INTO item VALUES (SupplementT('7777',(Select ref(D) from DietProgram D WHERE D.DID = '3000'),'Lovaza','2','35','4/4/2025'))
INTO item VALUES (SupplementT('8888',(Select ref(D) from DietProgram D WHERE D.DID = '1000'),'Vitamin D','3','60','3/3/2022'))
Select * from dual;


INSERT ALL
INTO Sponsor Values (SponsorT('51','year','Nestle',SponsorPhone('01003380000','01003389999'),'NestleEgyp@outlook.com'))
INTO Sponsor Values (SponsorT('52','3 years','EvaPharm',SponsorPhone('01003284300','01223385199','01268980710'),'evapharma@outlook.com'))
INTO Sponsor Values (SponsorT('53','5 month','Rich Bake',SponsorPhone('01293370000','01003389019','01263381000'),'EditaEgy@outlook.com'))
INTO Sponsor Values (SponsorT('54','2 years','Seoudi',SponsorPhone('01003392121','01003351111','0124309999'),'nestleegyp@outlook.com'))
Select * from dual;


INSERT INTO Advertisment Values(AdvertismentT('01','Flyers','23/5/2021','BeFit',(Select ref(S) from Sponsor S WHERE S.SPID = '51'),(Select ref(A) from Userr A WHERE A.UsID = '1')))
INSERT INTO Advertisment Values(AdvertismentT('02','TV AD','10/7/2021','BeFit',(Select ref(S) from Sponsor S WHERE S.SPID = '52'),(Select ref(A) from Userr A WHERE A.UsID = '2')))
INSERT INTO Advertisment Values(AdvertismentT('03','Billboard','6/6/2021','Fitita',(Select ref(S) from Sponsor S WHERE S.SPID = '53'),(Select ref(A) from Userr A WHERE A.UsID = '3')))

INSERT INTO itemSponser VALUES (itemSponserT((Select ref(T) from Item T WHERE T.itemid = '1111'), (Select ref(T) from Sponsor T WHERE T.Spid = '51')))
INSERT INTO itemSponser VALUES (itemSponserT((Select ref(T) from Item T WHERE T.itemid = '1111'), (Select ref(T) from Sponsor T WHERE T.Spid = '52')))
INSERT INTO itemSponser VALUES (itemSponserT((Select ref(T) from Item T WHERE T.itemid = '2222'), (Select ref(T) from Sponsor T WHERE T.Spid = '53')))
INSERT INTO itemSponser VALUES (itemSponserT((Select ref(T) from Item T WHERE T.itemid = '3333'), (Select ref(T) from Sponsor T WHERE T.Spid = '54')))

INSERT INTO DietCustomer VALUES (DietCustomerT((Select ref(D) from DietProgram D WHERE D.DID = '1000'), (Select ref(C) from Userr C WHERE C.UsID = '7')))
INSERT INTO DietCustomer VALUES (DietCustomerT((Select ref(D) from DietProgram D WHERE D.DID = '2000'), (Select ref(C) from Userr C WHERE C.UsID = '8')))
INSERT INTO DietCustomer VALUES (DietCustomerT((Select ref(D) from DietProgram D WHERE D.DID = '3000'), (Select ref(C) from Userr C WHERE C.UsID = '9')))
INSERT INTO DietCustomer VALUES (DietCustomerT((Select ref(D) from DietProgram D WHERE D.DID = '4000'), (Select ref(C) from Userr C WHERE C.UsID = '7')))

INSERT INTO WorkoutCustomer VALUES (WorkoutCustomerT((Select ref(W) from Workout W WHERE W.WID = '11'), (Select ref(C) from Userr C WHERE C.UsID = '7')))
INSERT INTO WorkoutCustomer VALUES (WorkoutCustomerT((Select ref(W) from Workout W WHERE W.WID = '22'), (Select ref(C) from Userr C WHERE C.UsID = '8')))
INSERT INTO WorkoutCustomer VALUES (WorkoutCustomerT((Select ref(W) from Workout W WHERE W.WID = '33'), (Select ref(C) from Userr C WHERE C.UsID = '9')))


INSERT INTO WorkoutCustomer VALUES (WorkoutCustomerT((Select ref(W) from Workout W WHERE W.WID = '11'), (Select ref(C) from Userr C WHERE C.UsID = '4')))
INSERT INTO WorkoutCustomer VALUES (WorkoutCustomerT((Select ref(W) from Workout W WHERE W.WID = '11'), (Select ref(C) from Userr C WHERE C.UsID = '5')))
INSERT INTO WorkoutCustomer VALUES (WorkoutCustomerT((Select ref(W) from Workout W WHERE W.WID = '11'), (Select ref(C) from Userr C WHERE C.UsID = '6')))

INSERT INTO AdminAd VALUES (AdminAdT((Select ref(A) from Userr A WHERE A.UsID = '1'), (Select ref(A) from Advertisment A WHERE A.AID = '01')))
INSERT INTO AdminAd VALUES (AdminAdT((Select ref(A) from Userr A WHERE A.UsID = '1'), (Select ref(A) from Advertisment A WHERE A.AID = '02')))
INSERT INTO AdminAd VALUES (AdminAdT((Select ref(A) from Userr A WHERE A.UsID = '2'), (Select ref(A) from Advertisment A WHERE A.AID = '03')))

INSERT INTO AdminAccount VALUES (AdminAccountT((Select ref(U) from Account U WHERE U.Username = 'Zika'), (Select ref(A) from Userr A WHERE A.UsID = '1')))
INSERT INTO AdminAccount VALUES (AdminAccountT((Select ref(U) from Account U WHERE U.Username = 'Sara'), (Select ref(A) from Userr A WHERE A.UsID = '2')))
INSERT INTO AdminAccount VALUES (AdminAccountT((Select ref(U) from Account U WHERE U.Username = 'Aly'), (Select ref(A) from Userr A WHERE A.UsID = '3')))

INSERT INTO CustomerPayment VALUES (CustomerPaymentT((Select ref(C) from Userr C WHERE C.UsID = '7'),(Select ref(P) from Payment P WHERE P.PID = '10')))
INSERT INTO CustomerPayment VALUES (CustomerPaymentT((Select ref(C) from Userr C WHERE C.UsID = '8'),(Select ref(P) from Payment P WHERE P.PID = '20')))
INSERT INTO CustomerPayment VALUES (CustomerPaymentT((Select ref(C) from Userr C WHERE C.UsID = '9'),(Select ref(P) from Payment P WHERE P.PID = '30')))

---------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------

DECLARE
  U UserT;
BEGIN
  U:= UserT('2', '21', AddressT('Madinty', 'South park', '11234'), UserPhone('012', '014'));
  U.display_address();  
  U.display_phones();
END;

DECLARE
  U UserT;
BEGIN
  SELECT VALUE(e) INTO U FROM Userr e WHERE e.UsID = 1;
  U.display_address();
END;

SELECT T1.UsID, T2.COLUMN_VALUE AS Phone
FROM Userr T1, TABLE(T1.UsPhone) T2 


SELECT  DEREF(s.PID).PID AS PID, s.SID, STYPE
FROM subscription s

SELECT DEREF (T.ItemID).ItemID as Item_ID, DEREF (T.spons_ID).SPID AS SPONSOR_ID
FROM itemSponser T

select S.SID, S.SType, DEREF(S.PID).PID
from Subscription S

------------------------------------------ Procedures -------------------------------------
-------------------------------------------------------------------------------------------

ALTER TYPE SubscrIptionT ADD
MEMBER PROCEDURE Choose_Package(subscription_type VARCHAR2) cascade;

ALTER TYPE SubscrIptionT ADD
CONSTRUCTOR FUNCTION SubscrIptionT (SELF IN OUT NOCOPY SubscrIptionT SID, SType, PID)
RETURN SELF AS RETURN;

drop TYPE BODY SubscrIptionT


------------ Choose Package -----------
CREATE TYPE BODY SubscrIptionT AS
  CONSTRUCTOR FUNCTION SubscrIptionT (SELF IN OUT NOCOPY SubscrIptionT, SID, SType, PID)
   RETURN SELF AS RESULT RETURN 
   BEGIN 
   SELF.SID := SID;
   SELF.SType := Stype;
   SELF.PID := PID;
   RETURN;
   END;

  MEMBER PROCEDURE Choose_Package(subscription_type VARCHAR2) IS

    TYPES VARCHAR2(20);
    ID NUMBER;

    BEGIN
     ID := SID;

     SELECT S.SType INTO TYPES
     FROM Subscription S
     where S.SID = ID;
   
     dbms_output.put_line ('Your current subscription type is: ' || TYPES);

     if subscription_type = TYPES
     THEN 
       dbms_output.put_line('You already subscribed to ' || subscription_type);
     ELSE
       if subscription_type = 'Premium' 
       THEN
         UPDATE Subscription S
         SET S.SType = 'Premium'
         where S.SID = ID;

         dbms_output.put_line ('You changed your subscription type to: Premium');

     ELSE
       UPDATE Subscription S
       SET S.SType = 'Standard'
       where S.SID = ID;

       dbms_output.put_line ('You changed your subscription type to: Standard');
       END IF;
     END IF;
   END;
END;

----- Try it -----
DECLARE
sub SubscrIptionT;
BEGIN
sub := SubscrIptionT('100', 'Standard', NULL);
sub.Choose_Package('Standard');
END;

----------------- TO GET DETAILED COMPILATION ERRORS -------------
SELECT *
FROM USER_ERRORS
WHERE NAME = 'SUBSCRIPTIONT'

--------------------------------------------------------------------------------

------------ Choose Diet --------
------------------------------------------------ PACKAGE 1 ------------------------------------------

create or replace package PKG_PROC_PKG 
as 
 PROCEDURE Choose_Diet(Dname VARCHAR);
end; 

create or replace package body PKG_PROC_PKG 
as 
 PROCEDURE Choose_Diet(Dname VARCHAR) IS
  D_ID INT;
  Diet_Name VARCHAR(20);
  Total FLOAT;

  CURSOR DietProgram_Records IS
   SELECT DID , Price
   FROM DietProgram;
  
  Dcontainer DietProgram_Records%ROWTYPE;

  BEGIN
    open DietProgram_Records;
    LOOP 
      FETCH DietProgram_Records
      INTO Dcontainer;
    EXIT WHEN DietProgram_Records%NOTFOUND;

    SELECT d.DID ,Price,DietName INTO D_ID, Total, Diet_Name 
    FROM DietCustomer dc,DietProgram d
    Where d.DID=DEREF(dc.DID).DID  
    AND d.DietName = Dname;
    
    IF Dcontainer.DID IS NOT NULL
    THEN 
      dbms_output.put_line('Your chosen Diet is ' || Dname || ' and its price is '|| Total );
      EXIT;
    END IF;
    END LOOP;
    CLOSE DietProgram_Records;

  EXCEPTION 
    WHEN no_data_found THEN 
      dbms_output.put_line('No such Diet!'); 
END Choose_Diet;
end; 
 
DROP PROCEDURE Choose_Diet

----------- TRY IT ------------
BEGIN
  PKG_PROC_PKG.Choose_Diet('Keto');
END;

--------------------------------------------------------------------------------

------------ PACKAGE 2 --------
create or replace package GEN_RVW_REP_PKG 
as 
 PROCEDURE ViewReviews;
 FUNCTION DisplayCustomerReviews(ID IN NUMBER) RETURN SYS_REFCURSOR;
end; 

create or replace package body GEN_RVW_REP_PKG 
  as 
    PROCEDURE ViewReviews IS
    R VARCHAR(20);
    Com VARCHAR(20);
    UID INTEGER;
    agge VARCHAR(20);
    Ratings VARCHAR(20);

  BEGIN
    dbms_output.put_line('ID');
    for row in (SELECT RIDD as Review_ID, Commentt, DEREF(Cust_ID).UsID as User_ID, DEREF(Cust_ID).age as User_Age, Rating
       INTO R, Com, UID, agge, Ratings
       FROM Review
       ORDER BY RIDD)
    loop
       dbms_output.put_line(row.Review_ID||' '||row.Commentt ||' '||row.User_ID ||' '||row.User_Age ||' '||row.Rating);
    end loop;
  
  END ViewReviews;
 
  -------------- ADVANCED FUNCTION ---------------------
  FUNCTION DisplayCustomerReviews(ID IN NUMBER)
    RETURN SYS_REFCURSOR
  IS
    l_rc SYS_REFCURSOR;
    R VARCHAR(20);
    Com VARCHAR(20);
    UID INTEGER;
    agge VARCHAR(20);
    Ratings VARCHAR(20);
  BEGIN
    OPEN l_rc for
     SELECT RIDD as Review_ID, Commentt, DEREF(Cust_ID).UsID as User_ID, DEREF(Cust_ID).age as User_Age, Rating
     INTO R, Com, UID, agge, Ratings
     FROM Review
     WHERE DEREF(Cust_ID).UsID = ID
     ORDER BY RIDD;
  RETURN l_rc;
  END;
end;

----------- Test 1 --------
BEGIN
  GEN_RVW_REP_PKG.ViewReviews();
END;

---------- TEST 2 ---------
DECLARE
  ELL SYS_REFCURSOR;
  R VARCHAR(20);
  Com VARCHAR(20);
  UID INTEGER;
  agge VARCHAR(20);
  Ratings VARCHAR(20);
BEGIN
  ELL:= GEN_RVW_REP_PKG.DisplayCustomerReviews(8);
  LOOP
  FETCH ELL into R, Com, UID , agge, Ratings;
    EXIT WHEN  ELL%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Review ID: ' || R || ', ' || 'Comment: ' || Com || ', ' ||  'User ID: ' || UID || ', ' || 'Age: ' || agge || ', ' || 'Rating: ' || Ratings);
  END LOOP;
END;


--------------------------------------------------------------------------------

------------ Cancel Package --------
ALTER TYPE SubscrIptionT add
MEMBER PROCEDURE Cancel_Package(PKG_ID INT) cascade;

CREATE OR REPLACE TYPE BODY SubscrIptionT AS
  MEMBER PROCEDURE Choose_Package(subscription_type VARCHAR2) IS

    TYPES VARCHAR2(20);
    ID NUMBER;

    BEGIN
     ID := SID;

     SELECT S.SType INTO TYPES
     FROM Subscription S
     where S.SID = ID;
   
     dbms_output.put_line ('Your current subscription type is: ' || TYPES);

     if subscription_type = TYPES
     THEN 
       dbms_output.put_line('You already subscribed to ' || subscription_type);
     ELSE
       if subscription_type = 'Premium' 
       THEN
         UPDATE Subscription S
         SET S.SType = 'Premium'
         where S.SID = ID;

         dbms_output.put_line ('You changed your subscription type to: Premium');

     ELSE
       UPDATE Subscription S
       SET S.SType = 'Standard'
       where S.SID = ID;

       dbms_output.put_line ('You changed your subscription type to: Standard');
       END IF;
     END IF;
   END;


  MEMBER PROCEDURE Cancel_Package(PKG_ID INT) IS
    ID NUMBER;
  BEGIN
    
    IF PKG_ID = 0
    THEN ID := SID;
    ELSE ID := PKG_ID;
    END IF;

    DELETE FROM Subscription S
    WHERE S.SID = ID;
  END;
     
END;


DECLARE
  sub SubscrIptionT;
BEGIN
  sub := SubscrIptionT('7000', 'premium', NULL);
  sub.Cancel_Package(400);
END;



--- ************************************************************************ ---
--------------------------------------------------------------------------------
------------------------------------ FUNCTIONS ---------------------------------

-------------- GetReviewsAVG ----------
CREATE OR REPLACE FUNCTION GetReviewsAVG 
  RETURN FLOAT
IS
  Average FLOAT;
BEGIN
  SELECT AVG(Rating) INTO Average
  FROM Review;
  RETURN Average;
END;

Declare 
  ans FLOAT ;
BEGIN
  SELECT GetReviewsAVG() INTO ans
  FROM dual;
  IF ans < 3
    THEN dbms_output.put_line ('Alarming Rating, check the provided services');
  ELSE dbms_output.put_line ('Good job');
  END IF;
END;

--------------------------------------------------------------------

-------------- ApproveAd ----------
CREATE OR REPLACE Function ApproveAd (Aidd IN Integer)
Return Integer
IS
   AdName Varchar(20); 
   adType Varchar(20); 
   A_id INTEGER;

BEGIN

Select a.AID ,a.AName INTO  A_id,AdName
         from Advertisment a
         Where a.AID=Aidd;

IF A_id IS NOT NULL
THEN
dbms_output.put_line('The advertisement '|| AdName||'is approved');
RETURN 1;
END IF;

EXCEPTION 
   WHEN no_data_found THEN 
      dbms_output.put_line('Unfound Advertisement !'); 
      return 0;
END  ApproveAd;

Declare 
  AD INTEGER ;
BEGIN
  SELECT ApproveAd('1') INTO AD
  FROM dual;
  IF AD <3
    THEN dbms_output.put_line ('Stated by the Admin');
  ELSE dbms_output.put_line ('Advertisment is not added ');
  END IF;
END;

-------------------------------------------------------------------
-------------------------------------------------------------------

-------------------------------------------------------------
ALTER TYPE itemT ADD
MEMBER FUNCTION ShowItems RETURN VARCHAR2 cascade;

ALTER TYPE FoodT ADD
OVERRIDING MEMBER FUNCTION ShowItems RETURN VARCHAR2 cascade;

ALTER TYPE SupplementT ADD
OVERRIDING MEMBER FUNCTION ShowItems RETURN VARCHAR2 cascade;


------------------ OVERRIDING -------------------
CREATE OR REPLACE TYPE BODY itemT
AS
  MEMBER FUNCTION ShowItems RETURN VARCHAR2
IS
  BEGIN
    RETURN 'ID: ' || TO_CHAR(itemID);
  END;
END;

CREATE OR REPLACE TYPE BODY FoodT
AS
  OVERRIDING MEMBER FUNCTION ShowItems RETURN VARCHAR2
IS
  BEGIN
    RETURN (self AS itemT).ShowItems || ' Food Name: ' || FoodName || ', Calories: ' || Calories || ', Protein: ' || Protein || ', Carbohydtares: ' || Carbohydrates ||', Fats: ' || Fats;
  END;
END;

CREATE OR REPLACE TYPE BODY SupplementT
AS
  OVERRIDING MEMBER FUNCTION ShowItems RETURN VARCHAR2
IS
  BEGIN
    RETURN (self AS itemT).ShowItems || ' Suuplement Name: ' || SupplementName || ', Dose: ' || Dose || ', Supplement Quantity: ' || SupplementQuantity || ', Expiration Date: ' || ExpirationDate;
  END;
END;


SELECT T.ShowItems() as Details
FROM item T;

------------------------- PAY Procedure ------------------
CREATE OR REPLACE PROCEDURE makePayment(custID INTEGER,ID INTEGER,ccNum INTEGER, ccName VARCHAR2, pDate VARCHAR2, pCode VARCHAR2)
IS

  IDD INTEGER;

BEGIN
  SELECT P.PID INTO IDD
  FROM Payment P
  WHERE P.PID = ID;

  IF IDD = NULL
  THEN 

    dbms_output.put_line ('this payment does not exist');
    INSERT INTO Payment VALUES (PaymentT(ID,ccNum, ccName , pDate, pCode));
    INSERT INTO CustomerPayment VALUES (CustomerPaymentT((Select ref(C) from Userr C WHERE C.UsID = custID),(Select ref(P) from Payment P WHERE P.PID = PID)));
    dbms_output.put_line ('And new payment done with this the new ID');

  ELSE
    dbms_output.put_line('Payment done successfully');
  END IF;
END;


DECLARE   
  cust INTEGER;
  ID INTEGER;
  num INTEGER;
  name VARCHAR(20);
  date VARCHAR(20);
  code VARCHAR(4);
BEGIN 
  cust := '6';
  ID := '10'; 
  num:= '8954884';
  name:= 'katy';
  date := '1/1/2021';
  code := '8951';
  makePayment(cust,ID, num, name, date, code);
END;

--------------------------------------------------------
CREATE OR REPLACE FUNCTION totalPriceDietProgram (NAME VARCHAR2)
  RETURN FLOAT
AS
  PPrice FLOAT;
  TOTAL  FLOAT;

  CURSOR DietProgram_Records IS

  SELECT DietName, Price
  FROM DietProgram;

  Dcontainer DietProgram_Records%ROWTYPE;

BEGIN
  TOTAL := 0;
  OPEN DietProgram_Records;
  LOOP
    FETCH DietProgram_Records INTO Dcontainer;
  EXIT WHEN DietProgram_Records%NOTFOUND;

  SELECT D.Price INTO PPrice
  FROM DietProgram D
  WHERE D.DietName = NAME;

  IF Dcontainer.Price IS NOT NULL
  THEN

  TOTAL := TOTAL + PPrice;

  EXIT;
  END IF;
  END LOOP;
CLOSE DietProgram_Records;
RETURN TOTAL;

EXCEPTION 
   WHEN no_data_found THEN 
      dbms_output.put_line('No such Diet!'); 
END totalPriceDietProgram;

declare
  name varchar(20);
  total float;
begin
  name := 'Keto';
  total := totalPriceDietProgram(name);
  dbms_output.put_line('total price is ' || total);
end;
------------------------------------------------------------ZKA
create or replace procedure CHANGE_WORKOUT3
(wid IN NUMBER,
name IN VARCHAR2,
rounds IN NUMBER,
time IN VARCHAR2)
is
begin
     UPDATE Workout S
     SET S.WorkoutName = name,
      S.NumOfRounds = rounds,
      S.WorkoutTime = time
     WHERE S.WID = wid;
     
dbms_output.put_line ('You changed your subscription type to:' ||name);
end;?

DECLARE 
  name VARCHAR2(50);
  wid NUMBER;
  rounds NUMBER;
  date  VARCHAR(50);
BEGIN 
  wid :=3;
  rounds := 10;
  name := 'Squat';
  date := '22/9/2022';
  change_workout3(wid,name,rounds,date);
END;

------------------------------------------------
 
create or replace procedure CHANGE_PASSWORD
(usernames IN VARCHAR2,
passwords IN VARCHAR2,
newpassword IN VARCHAR2)
is
Password VARCHAR(50);


BEGIN

SELECT C.password  INTO Password
FROM  Account C
Where C.Username = usernames;

if  passwords = Password

THEN
     UPDATE Account S
     SET S.password = newpassword
     WHERE S.Username = usernames;
ELSE
dbms_output.put_line('you did not enter right id');

END IF;
EXCEPTION 
    WHEN no_data_found THEN 
      dbms_output.put_line('User Not Found');
END;

DECLARE 
  username VARCHAR2(50);
  password VARCHAR2(50);
  newpassword VARCHAR(50);

BEGIN 
  username := 'Zika';
  password := '1134';
  newpassword := 'newpass';

  change_password(username,password,newpassword);
END;


-----------------------------

---------------------------------------

create or replace function CalcWorkoutRound(w_name in Varchar2)    
return INTEGER   
is     
 total INTEGER := 0;  
BEGIN  
   SELECT sum(NumOfRounds) into total  
   FROM Workout w 
   WHERE w.workoutName =w_name; 
   RETURN total;  
END;  

DECLARE  
   w INTEGER;  
BEGIN  
   w := CalcWorkoutRound('Squats') ;  
   dbms_output.put_line('Total no. of Workout Rounds is : ' || w);  
END;  

--------------------------
---------------------------------------- KK
ALTER TYPE SupplementT ADD
MEMBER FUNCTION CalculateNumberOfDays(ID INTEGER) RETURN FLOAT cascade;

DROP TYPE BODY SupplementT

CREATE OR REPLACE FUNCTION CalculateNumberOfDays(ID IN INTEGER)
  RETURN FLOAT
IS

  DOSE FLOAT;
  QUANTITY FLOAT;
  NumOfDays FLOAT;

BEGIN

  NumOfDays := 0; 

--------------------- TREAT KeyWORD ------------------
  SELECT TREAT(value(T) AS SupplementT).Dose Dose, TREAT(value(T) AS SupplementT).SupplementQuantity SupplementQuantity INTO DOSE, QUANTITY
  FROM item T
  WHERE itemID = ID;

  NumOfDays := QUANTITY / DOSE;

  RETURN NumOfDays;
END;

DECLARE
  ID INTEGER;
  CALCULATE FLOAT;
BEGIN
  ID := '7777';
  CALCULATE := CalculateNumberOfDays(ID);
  dbms_output.put_line(CALCULATE);
END;

CREATE OR REPLACE FUNCTION AvgCustomersAge
  RETURN FLOAT
IS
  Average FLOAT;
BEGIN
  SELECT AVG(age) as Average_Age into Average FROM userr e where value(e) is of (CustomerT);
  RETURN Average;
END;

DECLARE 
  Ag float;
BEGIN
  Ag := AvgCustomersAge();
  dbms_output.put_line('Customer average age is: ' || Ag);



CREATE OR REPLACE Procedure ManageDietProgram (DD IN INT)IS
Sdate Varchar(50);
eDate Varchar(50);
dPrice FLOAT;
Dname Varchar(20);
BEGIN 
   SELECT  d.DietName,d.StartDate,d.EndDate,d.Price INTO Dname,Sdate,eDate,dPrice 
   FROM DietProgram d
   WHERE d.DID=DD;
   dbms_output.put_line('Diet Program '||Dname|| ' has been updated to new start date : '|| Sdate|| ' new end date : '|| eDate || ' new price :'|| dPrice);

    dbms_output.put_line ('Your editing in Diet Program: ' || Dname);
    IF  Dname='Low Carb Diet'
    THEN
    
        UPDATE DietProgram d
	SET 
                d.StartDate = Sdate,
                d.EndDate = eDate,
                d.Price = dPrice
                WHERE d.DID =DD;
        
dbms_output.put_line('Diet Program '||Dname|| ' has been updated to new start date : '|| Sdate|| ' new end date :'|| eDate || ' new price : '|| dPrice);
      
   ELSIF Dname='Keto'
   THEN
   UPDATE DietProgram d
   SET 
                d.StartDate = Sdate,
                d.EndDate = eDate,
                d.Price = dPrice
                WHERE d.DID =DD;
    dbms_output.put_line('Diet Program'||Dname|| ' has been updated '|| ' to new start date : '|| Sdate|| ' new end date :'|| eDate || ' new price : '|| dPrice);
    
  ELSIF Dname='Intermittent Fasting'
   THEN
   UPDATE DietProgram d
   SET 
                d.StartDate = Sdate,
                d.EndDate = eDate,
                d.Price = dPrice
                WHERE d.DID =DD;

 dbms_output.put_line('Diet Program '||Dname|| ' has been updated '|| ' to new start date : '|| Sdate|| ' new end date :'|| eDate || ' new price :'|| dPrice);

 ELSIF Dname='Plant-based diet'
   THEN
   UPDATE DietProgram d
   SET 
                d.StartDate = Sdate,
                d.EndDate = eDate,
                d.Price = dPrice
                WHERE d.DID =DD;

 dbms_output.put_line('Diet Program'||Dname|| ' has been updated '|| ' to new start date : '|| Sdate|| ' new end date : '|| eDate || ' new price : '|| dPrice);

 ELSIF Dname='DASH Diet'
   THEN
   UPDATE DietProgram d
   SET 
                d.StartDate = Sdate,
                d.EndDate = eDate,
                d.Price = dPrice
                WHERE d.DID =DD;

 dbms_output.put_line('Diet Program'||Dname|| ' has been updated '|| ' to new start date : '|| Sdate|| ' new end date : '|| eDate || ' new price : '|| dPrice);

ELSIF Dname='MIND Diet'
   THEN
   UPDATE DietProgram d
   SET 
                d.StartDate = Sdate,
                d.EndDate = eDate,
                d.Price = dPrice
                WHERE d.DID =DD;

 dbms_output.put_line('Diet Program'||Dname|| ' has been updated '|| ' to new start date : '|| Sdate|| ' new end date : '|| eDate || ' new price :'|| dPrice);

ELSE
dbms_output.put_line('Diet Program is not available');
 
   END IF;
   END;
	


call the function 

	DECLARE 
        
 
        Sdate varchar(20);
        eDate varchar(20);
        dPrice float;
		
	BEGIN 
                Sdate:= '5/5/2022'; 
                eDate := '5/6/2022';
                dPrice:= '3500';
		ManageDietProgram ('4000');
	END;


CREATE OR REPLACE FUNCTION DecreaseDose (ID IN INTEGER, amount IN Float)
  RETURN FLOAT
IS
  Current Float;
  Result FLOAT;

BEGIN
--------------------- TREAT KeyWORD ------------------
  SELECT TREAT(value(T) AS SupplementT).Dose Dose INTO Current
  FROM item T
  WHERE itemID = ID;

  Result := Current - amount;
 
  RETURN Result;
  
END;

DECLARE
  ID INTEGER;
  CALCULATE FLOAT;
BEGIN
  CALCULATE := DecreaseDose('5555', '1');
  IF CALCULATE < 0 THEN
  dbms_output.put_line('WRONG OPERATION');
  ELSE 
  dbms_output.put_line('NEW DOSE: ' || CALCULATE);
  END IF;
END;
