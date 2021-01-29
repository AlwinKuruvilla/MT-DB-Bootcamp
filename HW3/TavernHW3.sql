,DROP TABLE IF EXISTS RoomStays;
DROP TABLE IF EXISTS Rooms;
DROP TABLE IF EXISTS RoomStatus;

CREATE TABLE RoomStatus (
    RoomStatusID int PRIMARY KEY,
    RoomStatusName nvarchar(50),
);


CREATE TABLE Rooms (
    RoomNumber int,
    RoomStatusID int FOREIGN KEY REFERENCES RoomStatus,
    TavernID int FOREIGN KEY REFERENCES Taverns,
    CONSTRAINT PK_Rooms PRIMARY KEY (TavernID, RoomNumber)
);

CREATE TABLE RoomStays (
    RoomStayID int PRIMARY KEY,
    SaleID int FOREIGN KEY REFERENCES Sales(SalesID),
    GuestID int FOREIGN KEY REFERENCES Guests,
    PK_Rooms int FOREIGN KEY REFERENCES Rooms,
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
    (101, 2, 4)

/*
 1. The system should also be able to track Rooms. Rooms should have a status and an associated tavern. There should be a way to track Room Stays which will contain a sale, guest, room, the date it was stayed in and the rate

2. Write a query that returns guests with a birthday before 2000.

3. Write a query to return rooms that cost more than 100 gold a night

4.Write a query that returns UNIQUE guest names.

5. Write a query that returns all guests ordered by name (ascending) Use ASC or DESC after your ORDER BY [col]

6. Write a query that returns the top 10 highest price sales

7. Write a query to return all the values stored in all Lookup Tables - Lookup tables are the tables we reference typically with just an ID and a name. This should be a dynamic combining of all of the tables

8. Write a query that returns Guest Classes with Levels and Generate a new column with a label for their level grouping (lvl 1-10, 10-20, etc)

9. Write a series of INSERT commands that will insert the statuses of one table into another of your choosing using SELECT statements (See our lab in class - The INSERT commands should be generated). It’s ok if the data doesn’t match or make sense! :)
* Remember, INSERT Commands look like: INSERT INTO Table1 (column1, column2) VALUES (column1, column2)
 */