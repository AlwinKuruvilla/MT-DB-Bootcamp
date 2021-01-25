-- Add Primary and Foreign Keys to Existing Tables

ALTER TABLE  Locations ADD PRIMARY KEY (LocationID);

ALTER TABLE Users ADD PRIMARY KEY (UserID);

ALTER TABLE Roles ADD PRIMARY KEY (RolesID);

ALTER TABLE Taverns ADD PRIMARY KEY (TavernID);
ALTER TABLE Taverns ADD FOREIGN KEY (UserID) REFERENCES Users;
ALTER TABLE Taverns ADD FOREIGN KEY (LocationID) REFERENCES Locations;

DROP TABLE Rats;

ALTER TABLE UserRoles ADD FOREIGN KEY (UserID) REFERENCES Users;
ALTER TABLE UserRoles ADD FOREIGN KEY (RoleID) REFERENCES Roles;

ALTER TABLE Services ADD PRIMARY KEY (ServiceID);

ALTER TABLE Sales ADD PRIMARY KEY (SalesID);
ALTER TABLE Sales ADD FOREIGN KEY (TavernID) REFERENCES Taverns;
ALTER TABLE Sales DROP COLUMN ServiceID;

ALTER TABLE ServiceStatus ADD PRIMARY KEY (StatusID);
ALTER TABLE ServiceStatus ADD FOREIGN KEY (ServiceID) REFERENCES Services;

ALTER TABLE Supplies ADD PRIMARY KEY (SupplyID);

ALTER TABLE Inventory ADD PRIMARY KEY (InventoryID);
ALTER TABLE Inventory ADD FOREIGN KEY (TavernID) REFERENCES Taverns;
ALTER TABLE Inventory ADD FOREIGN KEY (SupplyID) REFERENCES Supplies;

ALTER TABLE Receivables ADD PRIMARY KEY (ReceivablesID);
ALTER TABLE Receivables ADD FOREIGN KEY (SupplyID) REFERENCES Supplies;
ALTER TABLE Receivables ADD FOREIGN KEY (TavernID) REFERENCES Taverns;

-- Create new tables
CREATE TABLE InventorySales
(
    InventorySalesID int IDENTITY (1, 1) PRIMARY KEY,
    TavernID int FOREIGN KEY REFERENCES Taverns,
    SalesID int FOREIGN KEY REFERENCES Sales
);

CREATE TABLE ServiceSales
(
    ServicesSalesID int IDENTITY (1, 1) PRIMARY KEY,
    ServiceID   int FOREIGN KEY REFERENCES Services,
    SalesID int FOREIGN KEY REFERENCES Sales
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

CREATE TABLE Level
(
    Level   int PRIMARY KEY
);

CREATE TABLE LevelClass
(
    LevelClassID int IDENTITY (1,1) PRIMARY KEY,
    Level int FOREIGN KEY REFERENCES Level,
    Class nvarchar(50) FOREIGN KEY REFERENCES Class
);

CREATE TABLE Guests
(
  GuestID   int IDENTITY (1, 1) PRIMARY KEY,
  GuestName nvarchar(50),
  GuestNotes nvarchar(50),
  GuestBirthday date,
  GuestCakeday  date,
  TavernID int FOREIGN KEY REFERENCES Taverns,
  StatusID  int FOREIGN KEY REFERENCES GuestStatus
);

CREATE TABLE GuestLevelClass
(
    GuestLevelClassID   int IDENTITY (1,1) PRIMARY KEY,
    GuestID int FOREIGN KEY REFERENCES Guests,
    LevelClassID int FOREIGN KEY REFERENCES LevelClass
);