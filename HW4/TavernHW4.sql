USE TavernDB;
--  1. Write a query to return users who have admin roles
SELECT UserName, RoleName
FROM Users U
         JOIN UserRoles UR on U.UserID = UR.UserID
         JOIN Roles R on R.RolesID = UR.RoleID
WHERE RoleName = 'Owner';

-- 2. Write a query to return users who have admin roles and information about their taverns
SELECT UserName, RoleName, TavernName
FROM Users U
         JOIN UserRoles UR on U.UserID = UR.UserID
         JOIN Roles R on R.RolesID = UR.RoleID
         JOIN Taverns T on U.UserID = T.UserID
WHERE RoleName = 'Owner';

-- 3. Write a query that returns all guests ordered by name (ascending) and their classes and corresponding levels
SELECT GuestName, ClassLevel, ClassName
FROM Guests G
         LEFT JOIN GuestLevelClass GLC on G.GuestID = GLC.GuestID
         LEFT JOIN Class C on C.ClassID = GLC.ClassID
ORDER BY GuestName;

-- 4. Write a query that returns the top 10 sales in terms of sales price and what the services were
SELECT TOP (10) ServiceName, Price
FROM ServiceSales SS
         JOIN Sales S on S.SalesID = SS.SalesID
         JOIN Services S2 on S2.ServiceID = SS.ServiceID;

-- 5. Write a query that returns guests with 2 or more classes
SELECT GuestName, COUNT(ClassName) NumOfClass
FROM Guests G
         JOIN GuestLevelClass GLC on G.GuestID = GLC.GuestID
         JOIN Class C on C.ClassID = GLC.ClassID
GROUP BY GuestName
HAVING COUNT(ClassName) >= 2;

-- 6. Write a query that returns guests with 2 or more classes with levels higher than 5
SELECT GuestName, COUNT(ClassName) NumOfClass
FROM Guests G
         JOIN GuestLevelClass GLC on G.GuestID = GLC.GuestID
         JOIN Class C on C.ClassID = GLC.ClassID
WHERE ClassLevel > 5
GROUP BY GuestName
HAVING COUNT(ClassName) >= 2;

-- 7. Write a query that returns guests with ONLY their highest level class
SELECT GuestName, MAX(ClassLevel) AS HighestLevel
FROM Guests G
         JOIN GuestLevelClass GLC on G.GuestID = GLC.GuestID
         JOIN Class C on C.ClassID = GLC.ClassID
GROUP BY GuestName;
-- How can I return the ClassName too?

-- 8. Write a query that returns guests that stay within a date range.
-- Please remember that guests can stay for more than one night AND not all of the dates they stay have to be in that range (just some of them)
SELECT GuestName, CheckIn, CheckOut
FROM Guests G
         JOIN RoomStays RS on G.GuestID = RS.GuestID
WHERE (CheckIn < '2012-07-21')
  AND (CheckOut > '2012-04-14');

-- 9. Using the additional queries provided, take the lab’s SELECT ‘CREATE query’ and add any IDENTITY and PRIMARY KEY constraints to it.
SELECT CONCAT('CREATE TABLE ', TABLE_NAME, ' (') as queryPiece
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'Taverns'
UNION ALL
SELECT CONCAT(
               cols.COLUMN_NAME,
               ' ',
               cols.DATA_TYPE,
               (CASE
                    WHEN CHARACTER_MAXIMUM_LENGTH IS NOT NULL
                        THEN CONCAT('(', CAST(CHARACTER_MAXIMUM_LENGTH as varchar(100)), ')')
                    ELSE ''
                   END),
               (CASE
                    WHEN refConst.CONSTRAINT_NAME IS NOT NULL
                        THEN (CONCAT(' FOREIGN KEY REFERENCES ', constKeys.TABLE_NAME, '(', constKeys.COLUMN_NAME, ')'))
                    ELSE ''
                   END),
               (CASE
                    WHEN refConst.CONSTRAINT_NAME IS NULL AND keys.COLUMN_NAME IS NOT NULL
                        THEN ' PRIMARY KEY'
                    ELSE ''
                   END),
               ',') as queryPiece
FROM INFORMATION_SCHEMA.COLUMNS cols
         LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE keys
                   ON (keys.TABLE_NAME = cols.TABLE_NAME AND keys.COLUMN_NAME = cols.COLUMN_NAME)
         LEFT JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS refConst
                   ON (refConst.CONSTRAINT_NAME = keys.CONSTRAINT_NAME)
         LEFT JOIN
     (SELECT DISTINCT CONSTRAINT_NAME, TABLE_NAME, COLUMN_NAME
      FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE) as constKeys
     ON (constKeys.CONSTRAINT_NAME = refConst.UNIQUE_CONSTRAINT_NAME)
WHERE cols.TABLE_NAME = 'Taverns'

UNION ALL

SELECT ')';

/*
For Number 9:
---
select sysObj.name, sysCol.name, *
from sys.objects sysObj
    inner join sys.columns sysCol
        on sysObj.object_id = sysCol.object_id
---
 */