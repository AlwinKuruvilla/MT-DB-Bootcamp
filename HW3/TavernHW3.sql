USE TavernDB;
GO;
-- 1. The system should also be able to track Rooms. Rooms should have a status and an associated tavern. There should be a way to track Room Stays which will contain a sale, guest, room, the date it was stayed in and the rate

DROP TABLE IF EXISTS RoomStays;
DROP TABLE IF EXISTS Rooms;
DROP TABLE IF EXISTS RoomStatus;

CREATE TABLE RoomStatus (
    RoomStatusID int PRIMARY KEY,
    RoomStatusName nvarchar(50),
);


CREATE TABLE Rooms (
    RoomID int IDENTITY (1, 1) PRIMARY KEY ,
    RoomNumber int NOT NULL ,
    RoomStatusID int FOREIGN KEY REFERENCES RoomStatus,
    TavernID int FOREIGN KEY REFERENCES Taverns,
);

CREATE TABLE RoomStays (
    RoomStayID int IDENTITY (1, 1) PRIMARY KEY ,
    SaleID int FOREIGN KEY REFERENCES Sales(SalesID),
    GuestID int FOREIGN KEY REFERENCES Guests (GuestID),
    RoomID int FOREIGN KEY REFERENCES Rooms (RoomID),
    --(TavernID, RoomNumber) int FOREIGN KEY REFERENCES Rooms(TavernID, RoomNumber), -- Why doesn't this work.
    CheckIn date,
    CheckOut date,
    Rate decimal (10,2)
);

INSERT INTO RoomStatus
    (RoomStatusID, RoomStatusName)
VALUES
    (1, 'Occupied'),
    (2, 'Vacant'),
    (3, 'Being Cleaned'),
    (4, 'Maintenance Issue'),
    (5, 'Closed Permentantly');

INSERT INTO Rooms
    (RoomNumber, RoomStatusID, TavernID)
VALUES
    (101, 2, 3),
    (101, 2, 4),
    (202, 1, 1),
    (104, 3, 2),
    (108, 5, 3),
    (204, 2, 4),
    (201, 5, 2),
    (208, 3, 1),
    (202, 1, 3);

INSERT INTO RoomStays
    (SaleID, GuestID, RoomID, CheckIn, CheckOut, Rate)
VALUES
    (1, 1, 1, '2012-04-12', '2012-04-15', 32.25),
    (2, 4, 4, '2012-10-20', '2012-10-25', 45.00),
    (4, 3, 2, '2012-05-10', '2012-05-12', 60.00),
    (3, 5, 2, '2012-07-11', '2012-07-28', 300.00),
    (1, 1, 5, '2012-10-31', '2012-11-05', 80.00);

-- 2. Write a query that returns guests with a birthday before 2000.
SELECT *
FROM Guests
WHERE GuestBirthday < '2000-01-01';

-- 3. Write a query to return rooms that cost more than 100 gold a night
SELECT *
FROM RoomStays
WHERE Rate > 100;

-- 4.Write a query that returns UNIQUE guest names.
SELECT DISTINCT GuestName
FROM Guests;

-- 5. Write a query that returns all guests ordered by name (ascending) Use ASC or DESC after your ORDER BY [col]
SELECT *
FROM Guests
ORDER BY GuestName ASC;

-- 6. Write a query that returns the top 10 highest price sales
SELECT TOP (10) Price
FROM Sales
ORDER BY Price DESC;

-- 7. Write a query to return all the values stored in all Lookup Tables - Lookup tables are the tables we reference typically with just an ID and a name. This should be a dynamic combining of all of the tables
SELECT RolesID, RoleName
FROM Roles
UNION ALL
SELECT UserID, UserName
FROM Users
UNION ALL
SELECT LocationID, LocationName
FROM Locations
UNION ALL
SELECT ServiceID, ServiceName
FROM Services
UNION ALL
SELECT SupplyID, SupplyName
FROM Supplies
UNION ALL
SELECT ClassID, ClassName
FROM Class
UNION ALL
SELECT StatusID, StatusName
FROM GuestStatus

-- 8. Write a query that returns Guest Classes with Levels and Generate a new column with a label for their level grouping (lvl 1-10, 10-20, etc)
SELECT GuestName, ClassName, ClassLevel,
    CASE
        WHEN ClassLevel >= 1 AND ClassLevel <= 10 THEN '1-10'
        WHEN ClassLevel >= 11 AND ClassLevel <= 20 THEN '11-20'
        WHEN ClassLevel >= 21 AND ClassLevel <= 30 THEN '21-30'
        WHEN ClassLevel >= 31 AND ClassLevel <= 40 THEN '31-40'
        WHEN ClassLevel >= 41 AND ClassLevel <= 50 THEN '41-50'
        WHEN ClassLevel >= 51 AND ClassLevel <= 60 THEN '51-60'
        WHEN ClassLevel >= 61 AND ClassLevel <= 70 THEN '61-70'
        ELSE 'MAXED OUT'
    END AS LevelGroup
FROM GuestLevelClass AS glc
    JOIN Guests AS g ON glc.GuestID = g.GuestID
    JOIN Class C on glc.ClassID = C.ClassID;

/*
9. Write a series of INSERT commands that will insert the statuses of one table into another of your choosing using SELECT statements (See our lab in class - The INSERT commands should be generated). It’s ok if the data doesn’t match or make sense! :)
* Remember, INSERT Commands look like: INSERT INTO Table1 (column1, column2) VALUES (column1, column2)
 */
CREATE TABLE GuestInfo (
    GuestName nvarchar(50),
    ClassName nvarchar(50),
    ClassLevel int,
    TavernName nvarchar(50)
);
INSERT INTO GuestInfo
SELECT GuestName, ClassName, ClassLevel, TavernName
FROM GuestLevelClass AS glc
    JOIN Guests AS g ON glc.GuestID = g.GuestID
    JOIN Class C on glc.ClassID = C.ClassID
    JOIN Taverns T on T.TavernID = g.TavernID
;