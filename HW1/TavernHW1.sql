DROP TABLE IF EXISTS Sales
DROP TABLE IF EXISTS Inventory
DROP TABLE IF EXISTS Supplies
DROP TABLE IF EXISTS BasementRats
DROP TABLE IF EXISTS Services
DROP TABLE IF EXISTS ReceivedGoods
DROP TABLE IF EXISTS Status
DROP TABLE IF EXISTS UserRoles
DROP TABLE IF EXISTS Roles
DROP TABLE IF EXISTS Taverns
DROP TABLE IF EXISTS Users
DROP TABLE IF EXISTS Locations

CREATE TABLE [Locations]
(
    [LocationID]    int IDENTITY (1, 1) PRIMARY KEY ,
    [Name]          nvarchar(50)
);
INSERT INTO Locations
    (Name)
VALUES
    ('McDonald''s')

CREATE TABLE [Users]
(
    [UserID]    int IDENTITY (1, 1) PRIMARY KEY ,
    [UserName]  nvarchar(50),
    [UserBirthday]  datetime
);

CREATE TABLE [Taverns]
(
    [TavernID]      int IDENTITY (1,1) PRIMARY KEY ,
    [TavernName]    nvarchar(50),
    [FloorsCount]   int,
    [UserID]        int FOREIGN KEY REFERENCES [Users],
    [LocationID]    int FOREIGN KEY REFERENCES [Locations]

);

CREATE TABLE [Roles]
(
    [RolesID]   int IDENTITY (1, 1) PRIMARY KEY ,
    [RoleName]  nvarchar(50)
);

CREATE TABLE [UserRoles]
(
    [UserID]    int FOREIGN KEY REFERENCES [Users],
    [RoleID]    int FOREIGN KEY REFERENCES [Roles]
);

CREATE TABLE [Status]
(
    [StatusID]      int IDENTITY (1, 1) PRIMARY KEY,
    [StatusName]    nvarchar(50),
    ServiceID       int
);

CREATE TABLE ReceivedGoods
(
    [ReceivedID]    int IDENTITY (1, 1) PRIMARY KEY,
    [TavernID]      int,
    [SupplyID]      int,
    [AmtReceived]   nvarchar(50),
    [DateReceived]  datetime
);

CREATE TABLE [Services]
(
    [ServiceID]     int IDENTITY (1, 1) PRIMARY KEY ,
    [ServiceName]   nvarchar(50),
    [ServicePrice]  money
);

CREATE TABLE [BasementRats]
(
    [RatID]    int IDENTITY (1, 1) PRIMARY KEY ,
    [TavernID] int,
    [RatName]  nvarchar(50)
);

CREATE TABLE [Supplies]
(
    [SupplyID]      int IDENTITY (1, 1) PRIMARY KEY ,
    [SupplyName]    nvarchar(50),
    [SupplyUnit]    nvarchar(50),
    [TavernID]      int FOREIGN KEY REFERENCES [Taverns]
);

CREATE TABLE [Inventory]
(
    [InventoryID]   int IDENTITY (1, 1) PRIMARY KEY,
    [SupplyID]      int FOREIGN KEY REFERENCES [Supplies],
    [DateUpdated]   datetime,
);


CREATE TABLE [Sales]
(
    [SalesID]       int IDENTITY (1, 1) PRIMARY KEY ,
    [UserID]        int FOREIGN KEY REFERENCES [Users],
    [TavernID]      int FOREIGN KEY REFERENCES [Taverns],
    [ServiceID]     int FOREIGN KEY REFERENCES [Services],
    [DatePurchased] datetime
)

CREATE TABLE [Classes]
(
    [Class] nvarchar(50) UNIQUE
)

CREATE TABLE [Guests]
(
    [GuestID]   int IDENTITY (1, 1) PRIMARY KEY,
    [GuestName] nvarchar(50),
    [GuestBirthday] datetime,
    [GuestCakeday]  datetime,
    [GuestStatus]   nvarchar(50),
)

CREATE TABLE [GuestClass]
(
    [GuestClassID] int IDENTITY (1, 1),
    [Class] int FOREIGN KEY REFERENCES [Classes](Class),
    [Level] int
)

DROP TABLE IF EXISTS [BasementRats]