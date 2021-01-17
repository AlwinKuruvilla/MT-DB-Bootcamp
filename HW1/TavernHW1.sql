-------------------
--DROPPING TABLES--
-------------------
DROP TABLE IF EXISTS UserRoles;
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
    UserBirthday datetime
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
    ('Alwin', 19830710),
    ('Betsy', 19831229),
    ('Carl', 19840214),
    ('Danielle', 19580819),
    ('Eric', 20030625),
    ('Fran', 19981130),
    ('Giovanna', 20000305),
    ('Henry', 19600417),
    ('Isaac', 20020329),
    ('Jenna', 19860521);

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


