CREATE DATABASE TavernDB;
GO;
USE TavernDB;
GO;
-------------------
--DROPPING TABLES--
-------------------
DROP TABLE IF EXISTS UserRoles;
DROP TABLE IF EXISTS Rats;
DROP TABLE IF EXISTS Taverns;
DROP TABLE IF EXISTS Roles;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Locations;

-------------------
--CREATING TABLES--
-------------------
CREATE TABLE Locations
(
    LocationID int IDENTITY (1, 1),
    LocationName       nvarchar(50)
);

CREATE TABLE Users
(
    UserID       int IDENTITY (1, 1),
    UserName     nvarchar(50),
    UserBirthday date
);

CREATE TABLE Roles
(
    RolesID  int IDENTITY (1, 1),
    RoleName nvarchar(50)
);

CREATE TABLE Taverns
(
    TavernID    int IDENTITY (1,1),
    TavernName  nvarchar(50),
    FloorsCount int,
    UserID      int,
    LocationID  int

);

CREATE TABLE Rats
(
    RatID   int IDENTITY (1,1),
    TavernID    int,
    RatName     nvarchar(50)
);

CREATE TABLE UserRoles
(
    UserID int,
    RoleID int
);

------------------
--SEEDING TABLES--
------------------
INSERT INTO Locations
    (LocationName)
VALUES
    ('New York City'),
    ('Philadelphia'),
    ('Boston'),
    ('Quahog'),
    ('Springfield');

INSERT INTO Users
    (UserName, UserBirthday)
VALUES
    ('Alwin', '1983-07-10'),
    ('Betsy', '1983-12-29'),
    ('Carl', '1984-02-14'),
    ('Danielle', '1958-08-19'),
    ('Eric', '2003-06-25'),
    ('Fran', '1998-11-30'),
    ('Giovanna', '2000-03-05'),
    ('Henry', '1960-04-17'),
    ('Isaac', '2002-03-29'),
    ('Jenna', '1986-05-21');

INSERT INTO Roles
    (RoleName)
VALUES
    ('Owner'),
    ('Bartender'),
    ('Host'),
    ('Cook'),
    ('Server'),
    ('Busboy');

INSERT INTO Taverns
    (TavernName, FloorsCount, UserID, LocationID)
VALUES
    ('Moe''s', 2, 3, 5),
    ('O''Lunney''s', 3, 1, 1),
    ('Chickie and Pete''s', 1, 2, 2),
    ('Drunken Clam', 1, 5, 4),
    ('Elle''s Steak and Beer', 3, 4, 3);

INSERT INTO Rats
    (TavernID, RatName)
VALUES
    (3, 'Jim'),
    (3, 'Tom'),
    (1, 'Pete'),
    (1, 'Chester'),
    (2, 'Phil');

--------------
--Homework 1--
--------------
DROP TABLE IF EXISTS Receivables;
DROP TABLE IF EXISTS Inventory;
DROP TABLE IF EXISTS Supplies;
DROP TABLE IF EXISTS ServiceStatus;
DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Services;

CREATE TABLE Services
(
    ServiceID   int,
    ServiceName nvarchar(50),
    ServicePrice    decimal(18,2)
);

CREATE TABLE Sales
(
    SalesID int,
    TavernID    int,
    ServiceID   int,
    DatePurchased   datetime,
    GuestName   nvarchar(50),
    Price   decimal(18,2),
    AmountPurchased int
);

CREATE TABLE ServiceStatus
(
    StatusID    int,
    StatusName  nvarchar(50),
    ServiceID   int
);

CREATE TABLE Supplies
(
    SupplyID    int,
    SupplyName  nvarchar(50),
    SupplyUnit  nvarchar(50)
);

CREATE TABLE Inventory
(
    InventoryID int,
    TavernID    int,
    SupplyID    int,
    DateUpdated date,
    Count       int
);

CREATE TABLE Receivables
(
    ReceivablesID   int,
    SupplyID        int,
    TavernID        int,
    Cost            decimal(18,2),
    AmountReceived  int,
    DateReceived    date
);

INSERT INTO Services
    (ServiceID, ServiceName, ServicePrice)
VALUES
    (1, 'Armor Polishing', 300.00),
    (2, 'Weapon Sharping', 250.00),
    (3, 'Gems and Jewelry', 100.00),
    (4, 'Pool', 50.00),
    (5, 'Weapon Forging', 100.50),
    (6, 'Buffet', 50.00),
    (7, 'Darts', 25.00);

INSERT INTO Sales
    (SalesID, TavernID, ServiceID, DatePurchased, GuestName, Price, AmountPurchased)
VALUES
    (1,2,2, '2020-03-05','Arthur Pendragon', 500.00, 2),
    (2, 3, 3, '2020-03-03','Cassandra Turtlefoot', 300.00, 3),
    (3, 1, 7, '2020-03-06', 'James Smith', 150.00, 6),
    (4, 5, 6, '2020-03-07', 'Alwin Kuruvilla', 50, 1);

INSERT INTO Supplies
    (SupplyID, SupplyName, SupplyUnit)
VALUES
    (1, 'Wildberry Ale', 'liters'),
    (2, 'Sharkbear Meat', 'kilograms'),
    (3, 'Squirrelrat Meat', 'kilograms'),
    (4, 'Purple Pumpkin Pie', 'pies'),
    (5, 'Tripleboot Ale', 'liters'),
    (6, 'Blue Forest Lager', 'liters'),
    (7, 'Pinefinger Nuts', 'bags');


INSERT INTO Inventory
    (InventoryID, TavernID, SupplyID, DateUpdated, Count)
VALUES
    (1, 2, 1, '2020-03-02', 5),
    (2, 3, 4, '2020-03-05', 2),
    (3, 2, 6, '2020-03-01', 6),
    (4, 4, 7, '2020-03-02', 3),
    (5, 5, 3, '2020-03-09', 5);

INSERT INTO Receivables
    (ReceivablesID, SupplyID, TavernID, Cost, AmountReceived, DateReceived)
VALUES
    (1, 1, 3, 60.00, 2, '2020-05-06'),
    (2, 4, 4, 58.25, 3, '2020-04-17'),
    (3, 2, 3, 48.26, 2, '2020-05-28'),
    (4, 1, 1, 100.36, 5, '2020-05-01'),
    (5, 2, 2, 154.03, 10, '2020-04-29');