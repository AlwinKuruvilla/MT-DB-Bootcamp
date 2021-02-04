-- 1. Write a query to return a “report” of all users and their roles
SELECT UserName, RoleName
FROM Users U
         JOIN UserRoles UR on U.UserID = UR.UserID
         JOIN Roles R2 on R2.RolesID = UR.RoleID;

-- 2. Write a query to return all classes and the count of guests that hold those classes
SELECT ClassName, COUNT(GuestName) AS 'Guest Count'
FROM TavernDB.dbo.Class C
         JOIN GuestLevelClass GLC on C.ClassID = GLC.ClassID
         JOIN Guests G on G.GuestID = GLC.GuestID
GROUP BY ClassName;

-- 3. Write a query that returns all guests ordered by name (ascending) and their classes and corresponding levels. Add a column that labels them beginner (lvl 1-5), intermediate (5-10) and expert (10+) for their classes (Don’t alter the table for this)
SELECT GuestName,
       ClassName,
       ClassLevel,
       CASE
           WHEN ClassLevel >= 1 AND ClassLevel < 5 THEN 'Beginner'
           WHEN ClassLevel >= 6 AND ClassLevel < 10 THEN 'Intermediate'
           ELSE 'Expert'
           END AS LevelGroup
FROM TavernDB.dbo.Guests G
         JOIN GuestLevelClass GLC on G.GuestID = GLC.GuestID
         JOIN Class C on C.ClassID = GLC.ClassID
ORDER BY GuestName;

-- 4. Write a function that takes a level and returns a “grouping” from question 3 (e.g. 1-5, 5-10, 10+, etc)
CREATE FUNCTION dbo.grouping(@ClassLevel int)
    RETURNS varchar(10)
AS
BEGIN
    DECLARE @group varchar(10);
    SELECT @group =
           CASE
               WHEN [GLC.ClassLevel] >= 1 AND [GLC.ClassLevel] <= 10 THEN '1-10'
               WHEN [GLC.ClassLevel] >= 11 AND [GLC.ClassLevel] <= 20 THEN '11-20'
               WHEN [GLC.ClassLevel] >= 21 AND [GLC.ClassLevel] <= 30 THEN '21-30'
               WHEN [GLC.ClassLevel] >= 31 AND [GLC.ClassLevel] <= 40 THEN '31-40'
               WHEN [GLC.ClassLevel] >= 41 AND [GLC.ClassLevel] <= 50 THEN '41-50'
               WHEN [GLC.ClassLevel] >= 51 AND [GLC.ClassLevel] <= 60 THEN '51-60'
               WHEN [GLC.ClassLevel] >= 61 AND [GLC.ClassLevel] <= 70 THEN '61-70'
               ELSE 'MAXED OUT'
               END
    FROM TavernDB.dbo.GuestLevelClass GLC
    WHERE [GLC.ClassLevel] = @ClassLevel;
    IF (@group IS NULL)
        SET @group = 0;
    RETURN @group;
END;

SELECT dbo.grouping([GLC.ClassLevel]) AS 'Level Grouping'
FROM TavernDB.dbo.GuestLevelClass

-- 5. Write a function that returns a report of all open rooms (not used) on a particular day (input) and which tavern they belong to
IF OBJECT_ID (N'dbo.OpenRooms', N'IF') IS NOT NULL
    DROP FUNCTION dbo.OpenRooms;
GO
CREATE FUNCTION dbo.OpenRooms (@dateOfInterest date)
RETURNS TABLE
AS
RETURN
        (
            SELECT RoomNumber, TavernName, CheckIn, CheckOut
            FROM TavernDB.dbo.Rooms R
                    JOIN RoomStays S on R.RoomID = S.RoomID
                    JOIN Taverns T on R.TavernID = T.TavernID
            WHERE NOT (CheckIn < @dateOfInterest AND CheckOut > @dateOfInterest)
        );

SELECT * FROM dbo.OpenRooms ('2012-05-11')
-- 6. Modify the same function from 5 to instead return a report of prices in a range (min and max prices) - Return Rooms and their taverns based on price inputs
IF OBJECT_ID (N'dbo.PriceRange', N'IF') IS NOT NULL
    DROP FUNCTION dbo.PriceRange;
GO
CREATE FUNCTION dbo.PriceRange (@minPrice decimal, @maxPrice decimal)
RETURNS TABLE
AS
RETURN
        (
            SELECT RoomNumber, TavernName, Rate
            FROM TavernDB.dbo.Rooms R
                    JOIN RoomStays S on R.RoomID = S.RoomID
                    JOIN Taverns T on R.TavernID = T.TavernID
            WHERE Rate > @minPrice AND Rate < @maxPrice
        );

SELECT * FROM dbo.PriceRange (44.00, 75.00)
-- 7. Write a command that uses the result from 6 to Create a Room in another tavern that undercuts (is less than) the cheapest room by a penny - thereby making the new room the cheapest one