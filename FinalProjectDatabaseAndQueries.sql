/* 
* Maritzabel Zarate Aguilar
*/


/*
* Part I: CREATE Statements and INSERT Statements
*/

-- Drop (if exists), Create (if not exist), and Use the database.

DROP DATABASE IF EXISTS FlowersAndJawn_DB;
CREATE DATABASE IF NOT EXISTS FlowersAndJawn_DB;
USE FlowersAndJawn_DB;


-- Create the table for a Person

CREATE TABLE IF NOT EXISTS Person
    (
        pNum                CHAR(5),
        name                VARCHAR(50) NOT NULL,
        phone               CHAR(11) NOT NULL,
        isCustomer          BOOLEAN NOT NULL,
        isStoreStaff        BOOLEAN NOT NULL,
        isDelivery          BOOLEAN NOT NULL,

        CONSTRAINT Person_PK PRIMARY KEY (pNum)
    );

-- Create the table for a Store_Staffs. 

CREATE TABLE IF NOT EXISTS Store_Staff
    (
        storeStaffID          CHAR(5),
        pNum_FK             CHAR(5) NOT NULL,
        startDate           DATE NOT NULL,

        CONSTRAINT Store_Staff_PK PRIMARY KEY (storeStaffID),

        CONSTRAINT Store_Staff_FK1 FOREIGN KEY (pNum_FK)
            REFERENCES Person(pNum)
    );


-- Create the table for a Delivery_Person. 

CREATE TABLE IF NOT EXISTS Delivery_Person
    (
        driverID            CHAR(5),
        pNum_FK             CHAR(5) NOT NULL,
        vModel              VARCHAR(25) NOT NULL,

        CONSTRAINT Delivery_Person_PK PRIMARY KEY (driverID),

        CONSTRAINT Delivery_Person_FK1 FOREIGN KEY (pNum_FK)
            REFERENCES Person(pNum)
    );


-- Crate table for Customer.

CREATE TABLE IF NOT EXISTS Customer
    (
        customerID          CHAR(5),
        pNum_FK             CHAR(5) NOT NULL,
        address             VARCHAR(100) NOT NULL,
        cEmail              VARCHAR(100) NOT NULL,

        CONSTRAINT Customer_PK PRIMARY KEY (customerID),

        CONSTRAINT Customer_FK1 FOREIGN KEY (pNum_FK)
            REFERENCES Person(pNum)
    );


-- Crate table for Flower.

CREATE TABLE IF NOT EXISTS Flower
    (
        flowerID            CHAR(5),    
        flowerName          VARCHAR(50) NOT NULL,
        inSeason            BOOLEAN NOT NULL,
        description         VARCHAR(100) NOT NULL,
        amountInStock       INT NOT NULL,

        CONSTRAINT Flower_PK PRIMARY KEY (flowerID)
    );


    -- Crate table for Vendor Information

CREATE TABLE IF NOT EXISTS Vendor
    (
        vendorID            CHAR(5),    
        vendorName          VARCHAR(50) NOT NULL,
        vPhone              CHAR(10) NOT NULL,
        vEmail              VARCHAR(100) NOT NULL,

        CONSTRAINT Vendor_Info_PK PRIMARY KEY (vendorID)
    );


-- Create table for Bouquet.

CREATE TABLE IF NOT EXISTS Bouquet
    (
        sku                 CHAR(7), 
        price               DOUBLE(50,2) NOT NULL, 
        description         VARCHAR(100) NOT NULL,

        CONSTRAINT Inventory_PK PRIMARY KEY (sku)

    );



-- Craete table for Flower Orders information.

CREATE TABLE IF NOT EXISTS Flower_Orders
    (
        orderNum        CHAR(5),
        storeStaffID    CHAR(5) NOT NULL,
        customerID_FK   CHAR(5) NOT NULL,
        driverID_FK   CHAR(5),
        datePlaced      DATE NOT NULL,
        oType           VARCHAR(10) NOT NULL,
        dateScheduled   DATE NOT NULL,
        sPaymentMethod  VARCHAR(50) NOT NULL,

        CONSTRAINT  Flower_Orders_PK PRIMARY KEY (orderNum),

        CONSTRAINT Flower_Orders_FK1 FOREIGN KEY (storeStaffID)
            REFERENCES Store_Staff(storeStaffID),

        CONSTRAINT Flower_Orders_FK2 FOREIGN KEY (customerID_FK)
            REFERENCES Customer(customerID),
        
        CONSTRAINT Flower_Orders_FK3 FOREIGN KEY (driverID_FK)
            REFERENCES Delivery_Person(driverID)

    );


-- Create table for Order_Item

CREATE TABLE IF NOT EXISTS Order_Item
    (
        autoGen         int auto_increment,
        orderNum_FK     CHAR(5),
        sku_FK          CHAR(7),
    
        CONSTRAINT Order_Item PRIMARY KEY (autoGen),

        CONSTRAINT Order_Item_FK1 FOREIGN KEY (orderNum_FK)
            REFERENCES Flower_Orders(orderNum),

         CONSTRAINT  Order_Item_FK2 FOREIGN KEY (sku_FK)
            REFERENCES Bouquet(sku)
    );

-- Create table for Vendor_Transaction

CREATE TABLE IF NOT EXISTS VendorSuppliesFlowers
    (
        invoiceNum          CHAR(5),
        vendorID_FK         CHAR(5) NOT NULL,        
        flowerID_FK         CHAR(7) NOT NULL,
        amount              DOUBLE(50,2) NOT NULL,
        deliveryDate        DATE NOT NULL, 
        vPaymentMethod      VARCHAR(50) NOT NULL,

        CONSTRAINT  VendorSuppliesFlowers_PK PRIMARY KEY (invoiceNum),

        CONSTRAINT  VendorSuppliesFlowers_FK1 FOREIGN KEY (VendorID_FK)
            REFERENCES Vendor(vendorID), 

        CONSTRAINT  VendorSuppliesFlowers_FK2 FOREIGN KEY (flowerID_FK)
            REFERENCES Flower(flowerID)
    );

-- Create table for Vendor_Transaction

CREATE TABLE IF NOT EXISTS Bouquet_has
    (
        sku_FK              CHAR(7),      
        flowerID_FK         CHAR(7),
        

        CONSTRAINT Bouquet_has_PK PRIMARY KEY (sku_FK, flowerID_FK),

        CONSTRAINT Bouquet_has_FK1 FOREIGN KEY (sku_FK)
            REFERENCES Bouquet(sku),

        CONSTRAINT Bouquet_has_FK2 FOREIGN KEY (flowerID_FK)
            REFERENCES Flower(flowerID)
    );


-- This query is executed to visually confirm that all tables have been added

SHOW TABLES;

/* 
* Maritzabel Zarate Aguilar
* Course: CIS 205 950 Fall, 2021
* Final project: Flower Shop Database
*/

-- This statement will load the test data for the Person table
INSERT INTO Person (pNum, name, phone, isCustomer, isStoreStaff, isDelivery)

VALUES  ("00001", "Lee C.", 2674576771, 1, 0, 0),
        ("00002", "Marshall L.", 6109728528, 1, 0, 0),
        ("00003", "Jin M.", 6109600432, 1, 0, 0),
        ("00004", "Sergei D.", 8147880072, 1, 0, 0),
        ("00005", "Lei W.", 7246457914, 1, 0, 0),
        ("00006", "Nina W.", 8144427467, 0, 1, 1),
        ("00007", "Ling X.", 2676478323, 0, 1, 0),
        ("00008", "Bob S.", 8519379941, 0, 1, 0),
        ("00009", "Marcia R.", 2159474001, 0, 1, 0),
        ("00010", "Kim L.", 2679091276, 0, 1, 0),
        ("00011", "Dani A.", 2673677177, 0, 0, 1),
        ("00012", "PJ Z.", 6108844767, 0, 0, 1),
        ("00013", "Tom B.", 8141335525, 0, 0, 1),
        ("00014", "Albert P.", 2159183776, 0, 0, 1),
        ("00015", "James F.", 2152328823, 0, 0, 1)
;

-- This statement will load the test data for the Customer table
INSERT INTO Customer (customerID,pNum_FK,address,cEmail)

VALUES  ("30000", "00001", "9294 West Rockville Dr. Clarksburg, PA 15067", "duncand@live.com"),
        ("30001", "00002", "672 South Mayfair Avenue South Ozone Park, PA 19068", "andale@mac.com"),
        ("30002", "00003", "174 E. Oakland Lane Hackettstown, PA 15095", "facet@live.com"),
        ("30003", "00004", "7 Surrey Street Norfolk, PA 19032", "kewley@yahoo"),
        ("30004", "00005", "216 Walt Whitman Court West Deptford, PA 19050", "hillct@yahoo.com")  
;

-- This statement will load the test data for the Store_Staff table
INSERT INTO Store_Staff (storeStaffID,pNum_FK,startDate)

VALUES  ("10000", "00006", "2017/09/03"),
        ("10001", "00007", "2017/12/02"),
        ("10002", "00008", "2019/01/28"),
        ("10003", "00009", "2019/06/10"),
        ("10004", "00010", "2020/05/18")
;

-- This statement will load the test data for the Delivery_Person table
INSERT INTO Delivery_Person (driverID,pNum_FK,vModel)

VALUES  ("20000", "00011", "ZX2"),
        ("20001", "00012", "Excursion"),
        ("20002", "00013", "Aspire"),
        ("20003", "00014", "Territory"),
        ("20004", "00015", "Fusion")
;

-- This statement will load the test data for the Flower table
INSERT INTO Flower (flowerID,flowerName,inSeason,description,amountInStock)

VALUES  ("40000", "Rose of Sharon", 1, "Hibiscus syriacus", 132),
        ("40001", "Muscari", 0, "Muscari", 54),
        ("40002", "Sunflower", 1, "Helianthus", 71),
        ("40003", "Lilies", 0, "Hosta", 52),
        ("40004", "Painted Daisy", 1, "Tanacetum coccineum", 21),
        ("40005", "Goldenrod", 0, "Solidago", 13)

    ;

-- This statement will load the test data for the Vendor table
INSERT INTO Vendor (vendorID,vendorName,vPhone,vEmail)

VALUES  ("50000", "Sunshine Florist", 6105362420, "sflorist@me.com"),
        ("50001", "The Watering Can", 4122009390, "wateringC@aol.com"),
        ("50002", "Fabulous Flowers", 4846466416, "fabflowers@verizon.net"),
        ("50003", "Over the Moon Florist", 2159090428, "moonflorist@comcast.net"),
        ("50004", "Happy Stems Florist", 8142784930, "happystems@msn.com"),
        ("50005", "Bonzai Florist", 6103694172, "bonzaiflorist@gmail.com"),
        ("50006", "Infinity Flowers", 7242514304, "infinityflowers@yahoo.com")
;

-- This statement will load the test data for the Self_Bouquet table
INSERT INTO Bouquet (sku,price,description)

VALUES  ("Mu/APer", 149.99, "Viola tricolor var. hortensis"),
        ("Re/SptS", 49.00, "Papaver orientale"),
        ("Wh/TwWk", 62.50, "Sanguinaria"),
        ("Pi/JuFr", 114.99, "Gladiolus"),
        ("Ye/Annu", 79.00, "Ursinia"),
        ("Bl/JuAu", 55.50, "Centaurea cyanus")
    
      
;

-- This statement will load the test data for the Flower_Orders table
INSERT INTO Flower_Orders (orderNum, storeStaffID, customerID_FK, driverID_FK, datePlaced,
 oType, dateScheduled, sPaymentMethod)

VALUES  ("00008","10000", "30000", "20000", "2017-03-04", "Delivery", "2017-03-06", "Cash"),
        ("00009","10001", "30001", "20001", "2017-11-15", "Delivery", "2017-11-17", "Credit"),
        ("00010","10002", "30002", NULL, "2018-05-01", "Pickup", "2018-05-03", "Debit"),
        ("00011","10003", "30003", NULL, "2018-08-12", "Pickup", "2018-08-14", "Cash"),
        ("00012","10004", "30004", "20004", "2019-06-08", "Delivery", "2019-06-10", "Cash"),
        ("00013","10002", "30002", "20002", "2019-09-21", "Delivery", "2019-09-23", "Debit"),
        ("00014","10002", "30004", "20000", "2017-03-04", "Delivery", "2017-03-04", "Debit"),
        ("00015","10000", "30003", NULL, "2018-08-24", "Pickup", "2018-08-25", "Cash"),
        ("00016","10002", "30000", "20000", "2018-01-04", "Delivery", "2018-01-06", "Debit")
;

-- This statement will load the test data for the Order_Item table
INSERT INTO Order_Item (orderNum_FK,sku_FK,autoGen)

VALUES  ("00008", "Mu/APer", "1"),
        ("00009", "Re/SptS", "2"),
        ("00010", "Wh/TwWk", "3"),
        ("00011", "Pi/JuFr", "4"),
        ("00012", "Ye/Annu", "5"),
        ("00013", "Bl/JuAu", "6"), 
        ("00014", "Pi/JuFr", "7"),
        ("00015", "Mu/APer", "8"),
        ("00016", "Mu/APer", "9")

;

-- This statement will load the test data for the VendorSuppliesFlowers table
INSERT INTO VendorSuppliesFlowers (invoiceNum,vendorID_FK,flowerID_FK,amount,
deliveryDate,vPaymentMethod)

VALUES  ("60000", "50000", "40001", 514.00, "2017/03/07", "Debit"),
        ("60001", "50001", "40005", 230.50, "2017/11/18", "Cash"),
        ("60002", "50002", "40002", 311.99, "2018/05/04", "Credit"),
        ("60003", "50003", "40003", 125.00, "2018/08/15", "Debit"),
        ("60004", "50004", "40004", 98.50, "2019/06/11", "Credit"),
        ("60005", "50005", "40003", 416.99, "2019/09/24", "Cash"),
        ("60006", "50006", "40003", 815.00, "2021/10/20", "Debit")
;

-- This statement will load the test data for Bouquet_has table
INSERT INTO Bouquet_has(sku_FK, flowerID_FK)

VALUES  ("Mu/APer", "40000"),
        ("Pi/JuFr", "40001"),
        ("Ye/Annu", "40003"),
        ("Wh/TwWk", "40005"),
        ("Bl/JuAu", "40005"),
        ("Re/SptS", "40002")

        ;






/*
* Maritzbel Zarate Aguilar
* CIS 205 950 Fall, 2021
* Final Project Part II
* Last edited:  December 15, 2021
*/

/* 
* LINES 453, 475, 491, 512, 545, 472, AND 588  HAVE EXIT STATEMENTS
* USER WILL HAVE TO SIGN IN USING ROOT CREDENTIALS
* AND CREDENTIALS FROM NEW USERS CREATED: 
*
* username: Maritzabel@localhost
* password: ToughPass2!
* and
* username: nina@localhost
* password: ToughPass2!
*/



/*  
* 1: UNION CLAUSE
* In this section the query will perform a UNION on one the main tables to another table
*/

-- This query returns in the UNION of the Customer Table and Vendor Table
SELECT cEmail AS "Email Address for Customers and Vendors"
FROM Customer
UNION ALL
SELECT vEmail
FROM Vendor;

/*  
* 2: INTERSECTION CLAUSE
* In this section, a new table called Full_Time_Employee
* will be created for the puspose of using an INTERSECT CLAUSE to
* produce a result set containing the instances that match in two different tables.
* data from Delivery_Person table and Store_Staff will be inserted into new table
* that represents employees who work full time hours. 
*/

-- Create table that stores data for Full TIme Employees
CREATE TABLE Full_Time_Employee
    (
        ftEmployeeID        CHAR(5),
        pNum_FK             CHAR(5) NOT NULL,
        
        CONSTRAINT Full_Time_Employee_PK PRIMARY KEY (ftEmployeeID),

        CONSTRAINT Full_Time_Employee_FK1 FOREIGN KEY (pNum_FK)
            REFERENCES Person(pNum)
    );

-- This table is executed to visually confirm the table has been added
SHOW TABLES;

-- INSERT data from Delivery_Person table into Full_Time_Employee table 
INSERT INTO Full_Time_Employee
(
    SELECT driverID, pNum_FK
    FROM Delivery_Person
    LIMIT 3

);

-- INSERT data from Store_Staff table into Full_Time_Employee table 
INSERT INTO Full_Time_Employee
(
    SELECT storeStaffID, pNum_FK
    FROM Store_Staff
    LIMIT 2
);

-- This table is executed to visually confirm the contents in the Full_Time_Employee table
SELECT *
FROM Full_Time_Employee;

-- This query returns the delivery people who are also full-time employees using the INTERSECT Clause
SELECT driverID
FROM Delivery_Person
INTERSECT 
SELECT ftEmployeeID
FROM Full_Time_Employee;

/*  
* 3: DIFFERENCE OPERATION
* In this section the new table called Full_Time_Employee
* will be used for the puspose of using the DIFFRENCE OPERATION to
* produce a result set containing the instances from one of the main tables 
* that do not match instances in the other table. 
*/

-- This query returns the delivery people who are not full time employees using a
-- Difference Operation on Delivery_Person table from Full_Time_Employee table
SELECT DISTINCT driverID
FROM Delivery_Person
WHERE (driverID) NOT IN 
(SELECT ftEmployeeID 
FROM Full_Time_Employee);

-- This query returns the full-time employees who are not delivery people using a
-- Difference Operation on Full_Time_Employee table to Delivery_Person table
SELECT ftEmployeeID
FROM Full_Time_Employee
WHERE (ftEmployeeID) NOT IN
(SELECT driverID
FROM Delivery_Person);

-- Drop Full_Time_Employee table: 
DROP TABLE Full_Time_Employee;

-- This query is executed to visually confirm that Full_Time_Employee table has been dropped
SHOW TABLES;

/*  
* 4: JOIN
* In this section the common attributes of two tables with a relationship
* will be used to JOIN the tables together
*/


-- This query retuns customerID, name, phone by using a JOIN Clause between the Customer table 
-- and the Person table
SELECT customerID, name, phone
FROM Customer c
JOIN Person p ON p.pNum = c.pNum_FK;

/*  
* 5: ALTER
* In this section two tables will be altered. Each alter statement
* is preceeded by a statement that describest the table that is being
* altered and followed by a statement that shows the changes
*/

-- This query is executed to visually confirm the current tables before performing 
-- and ALTER statement on the database
SHOW TABLES;


-- This query uses an ALTER Statement to change the name of the table Store_Staff 
-- to Florist_Emp
ALTER TABLE Store_Staff
RENAME Florist_Emp;


-- This query is executed to visually confirm the table has been altered
SHOW TABLES;


-- This query is executed to visually confirm the current attributes for the Flower_Orders table
-- before performing an ALTER statement.
DESCRIBE Flower_Orders;


--This query uses an ALTER Statement to add the attribute occasion to the Flower_Orders table
ALTER TABLE Flower_Orders
ADD occasion VARCHAR(100);


-- This query is executed to visually confirm the table has been altered
DESCRIBE Flower_Orders;

/*  
* 6: UPDATE
* In this section two tables will be updated. Each update statement
* is preceeded by a statement that describest the table the entry that is 
* being updated. 
*/

-- This query is executed to visually confirm the occasion currently set for
-- the flower order schedulded on 2019-09-23
SELECT orderNum, oType, dateScheduled, occasion
FROM Flower_Orders
WHERE dateScheduled = "2019-09-23"; 


-- This query uses an UPDATE Statement to change the occasion for the order number scheduled on
-- 2019-09-23
UPDATE Flower_Orders
SET occasion = "Wedding"
WHERE dateScheduled = "2019-09-23"; 


-- This query is to visually confirm the UPDATE statement has been properly executed
SELECT orderNum, oType, dateScheduled, occasion
FROM Flower_Orders
WHERE dateScheduled = "2019-09-23"; 


-- This query is executed to visually confirm the current name for Person with pNum 00001
SELECT pNum, name, cEmail
FROM Person p
JOIN Customer c ON p.pNum = c.pNum_FK
WHERE p.pNum = 00001;


-- This query uses an UPDATE Statement to change the email addresss for Person with pNum 00001
UPDATE Customer
SET cEmail = "lee.duncand@gmail.com"
WHERE pNum_FK = 00001;


-- This query is to visually confirm the UPDATE statement has been properly executed
SELECT pNum, name, cEmail
FROM Person p
JOIN Customer c ON p.pNum = c.pNum_FK
WHERE p.pNum = 00001;

/*  
* 7: DELETE
* In this section two different categories of rows will be deleged.
* Each delete statement is preceeded by a statement that describes the entry that is 
* being deleted and followed by a statement that proves the deletion is completed. 
*/

-- This query is executed to visually confirm the Bouquet_has table in its current state
SELECT * FROM Bouquet_has;


-- This query uses a DELETE Statement to remove row where flowerID_FK = 40005
DELETE FROM Bouquet_has
WHERE flowerID_FK = 40005;


-- This query is executed to visually confirm that row has been deleted
SELECT * FROM Bouquet_has;


-- This query is executed to visually confirm the VendorSuppliesFlowers table in its current state
SELECT * FROM VendorSuppliesFlowers; 


-- This query uses a DELETE Statement to remove rowS where amount is less than 250
DELETE FROM VendorSuppliesFlowers
WHERE amount < 250; 


-- This query is executed to visually confirm that row has been deleted
SELECT * FROM VendorSuppliesFlowers;

/*  
* 8: AGGREGATE FUNCTIONS
* In this section there are two queries that perform aggregate functions
*/

-- This query uses an AGGREGATE Function to find the average price for a bouquet
SELECT AVG(price) AS "Average Bouquet Price"
FROM Bouquet;


-- This query uses an AGGREGATE Function to find the total number of delivery order 
SELECT COUNT(*) AS "Total delivery orders"
FROM Flower_Orders
WHERE oType = "Delivery";

/*  
* 9: HAVING
* This section will return two queries that use only the HAVING Clause
*/

-- This query will return flower'S used in bouquet with stock less than 55
SELECT sku, b.description AS "Bouquet Description", flowerID, amountInStock AS "FLOWER STOCK"
FROM Bouquet b
JOIN Bouquet_has bh ON bh.sku_FK = b.sku
JOIN Flower f ON bh.flowerID_FK = f.flowerID
HAVING  amountInStock < 55;

-- This query will return vendors that have supplied flower ID 40003
SELECT vendorID_FK, vendorName, flowerID_FK
FROM VendorSuppliesFlowers vsf
JOIN Vendor v ON v.vendorID = vsf.vendorID_FK
HAVING flowerID_FK = 40003;


/*  
* 10: HAVING and GROUP BY
* This querey will return two queries that return only the GROUP BY Clause and 
* two queries that use the GROUP BY and HAVING CLAUSE together
*/

-- This query uses a GROUP BY  Clause to find the total sales made for each YEAR
SELECT 
    YEAR(datePlaced) AS year,
    (COUNT(orderNum) * price) AS total
FROM
    Flower_Orders o
JOIN Order_Item i ON i.orderNum_FK = o.orderNUM
JOIN Bouquet b ON b.sku = i.sku_FK
GROUP BY 
    YEAR(datePlaced);

-- This query uses a GROUP BY  Clause to find the total sales made for each YEAR
-- in which sales were over 200
SELECT YEAR(datePlaced) AS year, (COUNT(orderNum) * price) AS total
FROM Flower_Orders o
JOIN Order_Item i ON i.orderNum_FK = o.orderNUM
JOIN Bouquet b ON b.sku = i.sku_FK
GROUP BY YEAR(datePlaced)
HAVING total > 300;

-- This query uses a GROUP BY and HAVING Clause to find the delivery people with more than 3
-- delivery orders assigned to them. 
SELECT 
    driverID_FK, name, COUNT(orderNum) AS totalDeliveries, oType
FROM Flower_Orders o
JOIN Delivery_Person d ON d.driverID = o.driverID_FK
JOIN Person p ON p.pNum = d.pNum_FK
GROUP BY driverID_FK;

-- This query uses a GROUP BY and HAVING Clause to find the delivery people with more than 3
-- delivery orders assigned to them. 
SELECT 
    driverID_FK, name, COUNT(orderNum) AS totalDeliveries, oType
FROM Flower_Orders o
JOIN Delivery_Person d ON d.driverID = o.driverID_FK
JOIN Person p ON p.pNum = d.pNum_FK
GROUP BY driverID_FK
HAVING 
    totalDeliveries > 2 AND
    oType = "Delivery";


/*  
* 11: ASCENDING and DESCENDING order
*/

-- This query uses an ORDER BY Statement to return the amount paid to each vendor in ascending order. 
SELECT vendorID, vendorName, amount
FROM Vendor v
JOIN VendorSuppliesFlowers vs ON vs.vendorID_FK = v.vendorID
ORDER BY (amount) ASC;

-- This query uses an ORDER BY Statement to list the flowers in stock in desceding order
SELECT flowerID, flowerName, amountInStock
FROM Flower
ORDER BY (amountInStock) DESC;

/*  
* 12: VIEW TABLE
*/

-- This query creates a VIEW TABLE to return all the customers who paid in cash. 
CREATE VIEW customerPayingCash AS
SELECT customerID, name, sPaymentMethod
FROM Flower_Orders o
JOIN Customer c ON o.customerID_FK = c.customerID
JOIN Person p ON p.pNum = c.pNum_FK
WHERE sPaymentMethod = "Cash";

-- This query is executed to visually confirm that the VIEW statement above has been created
-- It will return the view table 
select * FROM customerPayingcash;

--This query creates a VIEW TABLE to return the sale total for each flower order in descending order
CREATE VIEW saleTotal AS
SELECT orderNum, (COUNT(orderNum) * (price)) AS total
FROM Flower_Orders o 
JOIN Order_Item i ON i.orderNum_FK = o.orderNum
JOIN Bouquet b ON b.sku = i.sku_FK
GROUP by orderNum
ORDER BY total DESC;

-- This query is executed to visually confirm that the VIEW statement above has been created
select * FROM saleTotal;

/*  
* 13: STORED PROCEDURE
* 
*/

-- This query uses a STORED PROCEDURE to describe the attributes of the Person, Boutique_has, 
-- and VendorSuppliesFlowers table. 
DELIMITER //
CREATE PROCEDURE describeProjectTables()
BEGIN
    DESCRIBE Person;
    DESCRIBE Bouquet_has;
    DESCRIBE VendorSuppliesFlowers;
END //
DELIMITER ;

-- This query is executed to visually confirm that the STORED PROCEDURE above has been created
CALL describeProjectTables;

-- This query uses a STORED PROCEDURE and takes 1 IN parameter and 1 OUT parameter
-- to return the total number of orders by order Type: Delivery or Pick up
DELIMITER $$

CREATE PROCEDURE GetOrderCountByType (
	IN  orderType VARCHAR(25),
	OUT total INT
)
BEGIN
	SELECT COUNT(orderNum)
	INTO total
	FROM Flower_Orders
	WHERE oType = orderType;
END $$

DELIMITER ;

-- This query is executed to visually confirm that the STORED PROCEDURE above has been created.
-- It will return the total amount of delivery orders from the Flower_Orders Table
CALL GetOrderCountByType("Delivery", @total);
SELECT @total;

/*
* 14: Write Stored Triggers
* This query will create two STORED TRIGGERS. The first will be 
* to save data of any UPDATE statements ran in the VendorSuppliesFlowers table
* and the second will be to save data of any DELETE Statements ran in the 
* VendorSuppliesFlowers table. Each Storred Trigger will save the data to two
* new tables that have been created for the purpose of holding this infomarion.
* 
* UPDATE Statements and DELETE Statements are used to trigger each of the new 
* STORED TRIGGERS
*/

-- This querys will CREATE a new table to keep track of vendor invoices that are updated for audit
-- purposes
CREATE TABLE vendorInvoiceAudit
(
    id INT AUTO_INCREMENT PRIMARY KEY,
    invoiceNum CHAR (5) NOT NULL,
    vendorID CHAR(5) NOT NULL,
    flowerID CHAR(7) NOT NULL,
    amount DOUBLE(50,2) NOT NULL,
    deliveryDate DATE NOT NULL, 
    vPaymentMethod VARCHAR(50) NOT NULL,
    changedat DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
);

-- This query will  CREATE a STORED TRIGGER to be invoked BEFORE  an UPDATE is made to the 
-- VendorSuppliesFlowers table
CREATE TRIGGER before_vendorSupplies_update 
    BEFORE UPDATE ON VendorSuppliesFlowers
    FOR EACH ROW 
 INSERT INTO vendorInvoiceAudit
 SET action = 'update',
    invoiceNum = OLD.invoiceNum,
    vendorID = OLD.vendorID_FK,
    flowerID = OLD.flowerID_FK,
    amount = OLD.amount,
    deliveryDate = OLD.deliveryDate, 
    vPaymentMethod = OLD.vPaymentMethod,
    changedat = NOW();

-- This query is executed to visually confirm that the STORED TRIGGER above has been created
SHOW TRIGGERS;

-- This query will return the row from VendorSuppliesFlowers with invoice number 60002
-- to visually confirm the current information
SELECT * 
FROM VendorSuppliesFlowers
WHERE invoiceNum = 60002;

-- This query qill update the set amount for invoice number 60002
UPDATE VendorSuppliesFlowers
SET amount = 234.97
WHERE invoiceNum = 60002;

-- This query is executed to vissualy confirm the updates for the previous query
SELECT * 
FROM VendorSuppliesFlowers
WHERE invoiceNum = 60002;

-- This query will return all the data from the vendorInvoiceUpdateAudit to ensure 
-- storred trigger is working properly
SELECT * FROM vendorInvoiceAudit;

-- This query will  CREATE a STORED TRIGGER to be invoked BEFORE  an DELETE Statment is ran  in the 
-- VendorSuppliesFlowers table
DELIMITER $$

CREATE TRIGGER before_vendorSupplies_delete 
    BEFORE DELETE ON VendorSuppliesFlowers
    FOR EACH ROW 
BEGIN
    INSERT INTO vendorInvoiceAudit
    SET action = 'delete',
        invoiceNum = OLD.invoiceNum,
        vendorID = OLD.vendorID_FK,
        flowerID = OLD.flowerID_FK,
        amount = OLD.amount,
        deliveryDate = OLD.deliveryDate, 
        vPaymentMethod = OLD.vPaymentMethod,
        changedat = NOW();
END $$

DELIMITER ;

-- This query is executed to visually confirm that the STORED TRIGGER above has been created
SHOW TRIGGERS;


-- This query returns data from invoiceNum 60002 from the VendorSuppliesFlower to 
-- visually confirm that it exists in the database
SELECT * 
FROM VendorSuppliesFlowers
WHERE invoiceNum = 60002;

-- This query delete the information from invoiceNum 60002 from the VendorSuppliesFlower
-- table
DELETE FROM VendorSuppliesFlowers
WHERE invoiceNum = 60002;

-- This query visually confirms that invoceNum 60002 was deleted from the VendorSuppliesFlower 
-- table 
SELECT * 
FROM VendorSuppliesFlowers;

-- This query visually confirms that the STORED TRIGGER executed properly and saved the 
-- DELETED invoice to the vendorInvoiceDeleteAudit table
SELECT * FROM vendorInvoiceAudit;

/*
* 15: Create New Users
* This query will create two new user, grant them permissions,
* test the permission, remove permissions granted, and cofirm that 
* permissions have been revoked. New users are:
* 
* username: Maritzabel@localhost
* password: ToughPass2!
* and
* username: nina@localhost
* password: ToughPass2!
* 
*/

-- Shows users that are in the database management systerm 
SELECT user 
FROM mysql.user;  

-- Create an additional user in Mariadb named bob
CREATE USER maritzabel@localhost
IDENTIFIED by 'ToughPass2!';

-- Shows users that are in the database management systerm 
SELECT user 
FROM mysql.user;  

-- show new user privilages
SHOW GRANTS FOR maritzabel@localhost;

 -- Grant SELECT privileges on employees table
GRANT SELECT, INSERT
ON Person
TO maritzabel@localhost; 

-- show new user privilages
SHOW GRANTS FOR maritzabel@localhost;

-- EXIT program
exit; 

-- open new mysql terminal and login as new user
mysql -u maritzabel -p

-- enter password
ToughPass2!

-- use database 
USE FlowersAndJawn_DB;

-- SELECT all from Person Table
SELECT * FROM Person;

-- insert statement
INSERT INTO Person (pNum, name, phone, isCustomer, isStoreStaff, isDelivery)
VALUES  ("00016", "Amanda B.", 2675519778, 1, 0, 0) ;

-- SELECT all from Person Table to visually confirm INSERT Statement was
-- sucessfull
SELECT * FROM Person;

-- exit
exit;

-- Login as root user
mysql -u root -p

-- ENTER YOUR ROOT PASSWORD


-- use database 
USE FlowersAndJawn_DB;

-- revoke statement 
REVOKE INSERT
ON Person
FROM maritzabel@localhost;

-- show new user privilages
SHOW GRANTS FOR maritzabel@localhost;

-- exit
exit; 

-- open new mysql terminal and login as new user
mysql -u maritzabel -p

-- enter password
ToughPass2!

-- use database 
USE FlowersAndJawn_DB;

-- SELECT all from Person Table
SELECT * FROM Person;

-- insert statement
INSERT INTO Person (pNum, name, phone, isCustomer, isStoreStaff, isDelivery)
VALUES  ("00017", "Eddy S.", 6105519328, 0, 1, 0) ;

-- user will be DENIED from using INSERT Statement of Person table

-- exit database
exit;

-- Loggin as root user
mysql -u root -p

-- ENTER YOUR ROOT PASSWORD

-- use database 
USE FlowersAndJawn_DB;

-- Shows users that are in the database management systerm 
SELECT user 
FROM mysql.user;  

-- Create an additional user in Mariadb named bob
CREATE USER nina@localhost
IDENTIFIED by 'ToughPass2!';

-- Shows users that are in the database management systerm 
SELECT user 
FROM mysql.user;  

-- show new user privilages

SHOW GRANTS FOR nina@localhost;

-- Grant SELECT privileges on employees table
GRANT SELECT, UPDATE
ON Person
TO nina@localhost; 

-- show new user privilages
SHOW GRANTS FOR nina@localhost;

-- EXIT program
exit; 

-- open new mysql terminal and login as new user
mysql -u nina -p

-- enter password
ToughPass2!

-- use database 
USE FlowersAndJawn_DB;

-- SELECT all from pNum 00011 in Person table
SELECT * 
FROM Person
WHERE pNum = "00011";

-- update statement
UPDATE Person
SET name = "Danielle A."
WHERE pNum = "00011";

-- SELECT all from pNum 00011 in Person table to visually confirm
-- UPDATE statement has been successful
SELECT pNum, name 
FROM Person
WHERE pNum = "00011";

-- exit
EXIT;

-- Loggin as root user
mysql -u root -p

-- ENTER YOUR ROOT PASSWORD


-- use database 
USE FlowersAndJawn_DB;

-- revoke Insert Grant from new user
REVOKE UPDATE
ON Person
FROM nina@localhost;

-- show new user privilages
SHOW GRANTS FOR nina@localhost;

-- EXIT program
exit; 

-- open new mysql terminal and login as new user
mysql -u nina -p

-- enter password
ToughPass2!

-- use database 
USE FlowersAndJawn_DB;

-- SELECT all from pNum 00012 in Person table
SELECT * 
FROM Person
WHERE pNum = "00012";

-- Attempt an UPDATE statement
UPDATE Person
SET name = "Pedro Z."
WHERE pNum = "00011";

-- UPDATE Statement attempt will be DENIED

-- exit
exit;

-- Loggin as root user
mysql -u root -p

-- ENTER YOUR ROOT PASSWORD


-- use database 
USE FlowersAndJawn_DB;

-- drop users
DROP USER maritzabel@localhost;
DROP USER nina@localhost;

-- Shows users that are in the database management systerm 
SELECT user 
FROM mysql.user;  

