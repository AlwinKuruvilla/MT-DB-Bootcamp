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
DROP TABLE IF EXISTS Supplies;
DROP TABLE IF EXISTS Inventory;
DROP TABLE IF EXISTS ServiceStatus;
DROP TABLE IF EXISTS Services;
DROP TABLE IF EXISTS Sales;

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

CREATE TABLE Services
(
    ServiceID   int,
    ServiceName nvarchar(50),
    ServicePrice    decimal(18,2)
);

CREATE TABLE ServiceStatus
(
    StatusID    int,
    StatusName  nvarchar(50),
    ServiceID   int
);

CREATE TABLE Inventory
(
    InventoryID int,
    TavernID    int,
    SupplyID    int,
    DateUpdated date,
    Count       int
);

CREATE TABLE Supplies
(
    SupplyID    int,
    SupplyName  nvarchar(50),
    SupplyUnit  nvarchar(50)
)

CREATE TABLE Receivables
(
    ReceivablesID   int,
    SupplyID        int,
    TavernID        int,
    Cost            decimal(18,2),
    AmountReceived  int,
    DateReceived    date
)