CREATE DATABASE Hotel

CREATE TABLE Employees(
Id INT PRIMARY KEY IDENTITY NOT NULL,
FirstName VARCHAR(30) NOT NULL,
LastName VARCHAR(30) NOT NULL,
Title VARCHAR(50) NOT NULL,
Notes VARCHAR(MAX)
)

CREATE TABLE Customers(
Id INT PRIMARY KEY IDENTITY NOT NULL,
AccountNumber BIGINT,
FirstName VARCHAR(30),
LastName VARCHAR(30),
PhoneNumber VARCHAR(20),
EmergencyName VARCHAR(50),
EmergencyNumber VARCHAR(20),
Notes VARCHAR(200)
)

CREATE TABLE RoomStatus(
Id INT PRIMARY KEY IDENTITY NOT NULL,
RoomStatus BIT,
Notes VARCHAR(MAX)
)

CREATE TABLE RoomTypes(
RoomType VARCHAR(50) PRIMARY KEY,
Notes VARCHAR(MAX)
)

CREATE TABLE BedTypes(
BedType VARCHAR(50) PRIMARY KEY,
Notes VARCHAR(MAX)
)

CREATE TABLE Rooms (
RoomNumber INT PRIMARY KEY IDENTITY NOT NULL,
RoomType VARCHAR(50) FOREIGN KEY REFERENCES RoomTypes(RoomType),
BedType VARCHAR(50) FOREIGN KEY REFERENCES BedTypes(BedType),
Rate DECIMAL(6,2),
RoomStatus NVARCHAR(50),
Notes NVARCHAR(MAX)
)

CREATE TABLE Payments(
Id INT PRIMARY KEY IDENTITY NOT NULL,
EmployeeId INT FOREIGN KEY REFERENCES Employees(Id),
PaymentDate DATE,
AccountNumber BIGINT,
FirstDateOccupied DATE,
LastDateOccupied DATE,
TotalDays AS DATEDIFF(DAY, FirstDateOccupied, LastDateOccupied),
AmountCharged DECIMAL(14,2),
TaxRate DECIMAL(8, 2),
TaxAmount DECIMAL(8, 2),
PaymentTotal DECIMAL(15, 2),
Notes VARCHAR(MAX)
)

CREATE TABLE Occupancies(
Id  INT PRIMARY KEY IDENTITY NOT NULL,
EmployeeId INT FOREIGN KEY REFERENCES Employees(Id),
DateOccupied DATE,
AccountNumber BIGINT,
RoomNumber INT FOREIGN KEY REFERENCES Rooms(RoomNumber),
RateApplied DECIMAL(6,2),
PhoneCharge DECIMAL(6,2),
Notes VARCHAR(MAX)
)

INSERT INTO Employees VALUES
	('Valentin', 'Petkov', 'Reception', NULL),
	('Ivan', 'Berov', 'Barman', NULL),
	('Milena', 'Slavova', 'Chef', NULL)
 
INSERT INTO Customers VALUES
	(433456789, 'Minka', 'Svirkata', '0888747884', 'TORPEDO', '5408315342', NULL),
	(223480933, 'Palin', 'Sorgiens', '0888737838', 'MASHINATA', '2308315342', NULL),
	(111454432, 'Madle', 'Peorgise', '0888237838', 'VENGERA', '1208315342', NULL)

INSERT INTO RoomStatus(RoomStatus, Notes) VALUES
(1,'MAKE SOME JOB'),
(2,'DO THE THINGS'),
(3,'JUST DO IT')

INSERT INTO RoomTypes (RoomType, Notes) VALUES
('SINGLE', 'ONE PERSON'),
('SUITE', 'LUXUS FOR YOU'),
('APARTMENT', 'FAMMILY')

INSERT INTO BedTypes
VALUES
('SINGLE', 'ADULT AND CHILD'),
('DOUBLE', 'TWO ADULTS'),
('TRIPLE', 'A LOT OF PEOPLE')

INSERT INTO Rooms (Rate, Notes)
VALUES
(12,'FREE'),
(15, 'FREE'),
(23, 'FULL')

INSERT INTO Payments (EmployeeId, PaymentDate, AmountCharged)
VALUES
(1, '12/12/2010', 1800.40),
(2, '12/12/2013', 1570.40),
(3, '12/12/2017', 1880.40)

INSERT INTO Occupancies (EmployeeId, RateApplied, Notes) VALUES
(1, 65.44, NULL),
(2, 25.35, NULL),
(3, 95.25, NULL)