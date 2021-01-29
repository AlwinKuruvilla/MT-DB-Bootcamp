-- Add Primary and Foreign Keys to Existing Tables

ALTER TABLE Locations ADD PRIMARY KEY (LocationID);

ALTER TABLE Users ADD PRIMARY KEY (UserID);

ALTER TABLE Roles ADD PRIMARY KEY (RolesID);

ALTER TABLE Taverns ADD PRIMARY KEY (TavernID);
ALTER TABLE Taverns ADD FOREIGN KEY (UserID) REFERENCES Users;
ALTER TABLE Taverns ADD FOREIGN KEY (LocationID) REFERENCES Locations;

DROP TABLE Rats;

ALTER TABLE UserRoles ADD FOREIGN KEY (UserID) REFERENCES Users;
ALTER TABLE UserRoles ADD FOREIGN KEY (RoleID) REFERENCES Roles;

ALTER TABLE Services ALTER COLUMN ServiceID int NOT NULL;
GO-- Do I need to add "GO" after this?
ALTER TABLE Services ADD PRIMARY KEY (ServiceID);

ALTER TABLE Sales ALTER COLUMN SalesID int NOT NULL;
GO
ALTER TABLE Sales ADD PRIMARY KEY (SalesID);
ALTER TABLE Sales ADD FOREIGN KEY (TavernID) REFERENCES Taverns;
ALTER TABLE Sales DROP COLUMN ServiceID;

ALTER TABLE ServiceStatus ALTER COLUMN StatusID int NOT NULL;
GO
ALTER TABLE ServiceStatus ADD PRIMARY KEY (StatusID);
ALTER TABLE ServiceStatus ADD FOREIGN KEY (ServiceID) REFERENCES Services;

ALTER TABLE Supplies ALTER COLUMN SupplyID int NOT NULL;
GO
ALTER TABLE Supplies ADD PRIMARY KEY (SupplyID);

ALTER TABLE Inventory ALTER COLUMN InventoryID int NOT NULL;
GO
ALTER TABLE Inventory ADD PRIMARY KEY (InventoryID);
ALTER TABLE Inventory ADD FOREIGN KEY (TavernID) REFERENCES Taverns;
ALTER TABLE Inventory ADD FOREIGN KEY (SupplyID) REFERENCES Supplies;

ALTER TABLE Receivables ALTER COLUMN ReceivablesID int NOT NULL;
GO
ALTER TABLE Receivables ADD PRIMARY KEY (ReceivablesID);
ALTER TABLE Receivables ADD FOREIGN KEY (SupplyID) REFERENCES Supplies;
ALTER TABLE Receivables ADD FOREIGN KEY (TavernID) REFERENCES Taverns;


--Drop tables for HW2
DROP TABLE IF EXISTS GuestLevelClass;
DROP TABLE IF EXISTS Guests;
DROP TABLE IF EXISTS LevelClass;
DROP TABLE IF EXISTS Level;
DROP TABLE IF EXISTS Class;
DROP TABLE IF EXISTS GuestStatus;
DROP TABLE IF EXISTS ServiceSales;
DROP TABLE IF EXISTS InventorySales;

-- Create tables for HW2
CREATE TABLE InventorySales
(
    InventorySalesID int IDENTITY (1, 1) PRIMARY KEY,
    TavernID int FOREIGN KEY REFERENCES Taverns(TavernID),
    SalesID int FOREIGN KEY REFERENCES Sales(SalesID)
);

CREATE TABLE ServiceSales
(
    ServicesSalesID int IDENTITY (1, 1) PRIMARY KEY,
    ServiceID   int FOREIGN KEY REFERENCES Services(ServiceID),
    SalesID int FOREIGN KEY REFERENCES Sales(SalesID)
);

CREATE TABLE GuestStatus
(
    StatusID int IDENTITY (1, 1) PRIMARY KEY,
    StatusName nvarchar(50)
);

CREATE TABLE Class
(
    ClassID int IDENTITY (1, 1) PRIMARY KEY,
    ClassName nvarchar(50)
);

CREATE TABLE Guests
(
  GuestID   int IDENTITY (1, 1) PRIMARY KEY,
  GuestName nvarchar(50),
  GuestNotes nvarchar(50),
  GuestBirthday date,
  GuestCakeday  date,
  TavernID int FOREIGN KEY REFERENCES Taverns(TavernID),
  StatusID  int FOREIGN KEY REFERENCES GuestStatus(StatusID)
);

CREATE TABLE GuestLevelClass
(
    GuestID int FOREIGN KEY REFERENCES Guests(GuestID),
    ClassID int FOREIGN KEY REFERENCES Class(ClassID),
    ClassLevel int
    CONSTRAINT PK_GuestLevelClass PRIMARY KEY (GuestID, ClassID, ClassLevel)
);

-- Insertions for new tables
INSERT INTO InventorySales
    (TavernID, SalesID)
VALUES
    (1, 1),
    (1, 2),
    (1, 4),
--     (2, 5), --Fails because SalesID=5 does not exist
--     (6, 1), --Fails because TavernID=6 does not exist
    (2, 4),
    (2, 3);

INSERT INTO ServiceSales
    (ServiceID, SalesID)
VALUES
    (7, 1),
    (5, 1),
    (2, 4),
    (3, 4),
    (4, 1),
    (4, 2),
--     (8, 2), -- Fails because ServiceID=8 does not exist
--     (1, 5), --Fails becaues SalesID=5 does not exist
    (1, 3);

INSERT INTO GuestStatus
    (StatusName)
VALUES
    ('Fine'),
    ('Sick'),
    ('Hangry'),
    ('Raging'),
    ('Placid'),
    ('Damp');

INSERT INTO Class
    (ClassName)
VALUES
    ('Barbarian'),
    ('Crusader'),
    ('Demon Hunter'),
    ('Monk'),
    ('Wizard'),
    ('Witch Doctor'),
    ('Necromancer');


INSERT INTO Guests
    (GuestName, GuestNotes, GuestBirthday, GuestCakeday, TavernID, StatusID)
VALUES
    ('Hyperion', 'Strong and Stoic', '1525-02-16', '1550-03-12', 2, 4),
    ('Freya', 'Bold and Beautiful', '1527-07-10', '1550-03-12', 2, 3),
    ('Michael', 'Patient and Righteous', '1526-08-17', '1549-06-19', 4, 1),
    ('Joan', 'Thoughtful and Devote', '1530-04-15', '1552-01-05', 3, 5),
    ('Van', 'Quick and Cunning', '1525-10-25', '1545-12-25', 1, 2),
    ('Artemis', 'Agile and Sly', '1531-12-21', '1543-06-02', 1, 5),
    ('Apollo', 'Quiet and Resolute', '1502-01-25', '1522-02-28', 5, 5),
    ('Athena', 'Tenacious and Powerful', '1505-03-03', '1530-11-10', 5, 5);

INSERT INTO GuestLevelClass
    (GuestID, ClassID, ClassLevel)
VALUES
    --(8, 8, 25),
    --(9, 8, 12),
    (1, 1, 56),
    (2, 1, 38),
    (3, 2, 50),
    (4, 2, 61),
    (4, 3, 42),
    (5, 3, 9);

DROP TABLE GuestLevelClass