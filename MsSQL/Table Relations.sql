--One-To-One Relationship

CREATE TABLE [Passports](
	[PassportId] INT PRIMARY KEY NOT NULL,
	[PassportNumber] CHAR(8) NOT NULL
	)

CREATE TABLE [Persons](
	[PersonalId] INT PRIMARY KEY IDENTITY NOT NULL,
	[FirstName] NVARCHAR(30) NOT NULL,
	[Salary] DECIMAL(10,2) NOT NULL,
	[PassportID] INT FOREIGN KEY REFERENCES [Passports](PassportId) UNIQUE NOT NULL
	)

INSERT INTO [Passports](PassportId, PassportNumber) VALUES
	(101,'N34FG21B'),
	(102,'K65LO4R7'),
	(103,'ZE657QP2')

INSERT INTO [Persons](FirstName, Salary, PassportID) VALUES
	('Roberto', 4330.00, 102),
	('Tom', 56100.00, 103),
	('Yana', 60200.00, 101)

--One-To-Many Relationship

CREATE TABLE [Manufacturers](
	[ManufacturerID] INT IDENTITY PRIMARY KEY NOT NULL,
	[Name] NVARCHAR(50)NOT NULL,
	[EstablishedOn] DATETIME2 NOT NULL
 )

CREATE TABLE [Models](
	[ModelID] INT PRIMARY KEY IDENTITY(101,1) NOT NULL,
	[Name] NVARCHAR(50) NOT NULL,
	[ManufacturerID] INT FOREIGN KEY REFERENCES [Manufacturers](ManufacturerID) NOT NULL
	)

INSERT INTO [Manufacturers]([Name], [EstablishedOn]) VALUES 
	('BMW','1916/03/07'),
	('Tesla','2003/01/01'),
	('Lada','1966/05/01')

INSERT INTO [Models] ([Name], [ManufacturerID]) VALUES
	('X1', 1),
	('i6', 1),
	('Model S', 2),
	('Model X', 2),
	('Model 3', 2),
	('Nova', 3)

SELECT * FROM [Models]

--Many-To-Many Relationship

CREATE TABLE [Students](
	[StudentID] INT PRIMARY KEY IDENTITY NOT NULL,
	[Name] VARCHAR(50) NOT NULL
	)

CREATE TABLE [Exams](
	[ExamID] INT PRIMARY KEY IDENTITY(101,1) NOT NULL,
	[Name] NVARCHAR(50) NOT NULL
	)

CREATE TABLE [StudentsExams](
	[StudentID] INT FOREIGN KEY REFERENCES [Students](StudentID) NOT NULL,
	[ExamID] INT FOREIGN KEY REFERENCES [Exams](ExamId) NOT NULL,
	PRIMARY KEY ([StudentID], [ExamID])
	)

INSERT INTO [Students]
VALUES 
('Mila'),
('Toni'),
('Ron')

INSERT INTO [Exams]
VALUES 
('SpringMVC'),
('Neo4j'),
('Oracle 11g')

INSERT INTO [StudentsExams]
VALUES 
(1,101),
(1,102),
(2,101),
(3,103),
(2,102),
(2,103)

--Self-Referencing

CREATE TABLE [Teachers](
	[TeacherID] INT PRIMARY KEY IDENTITY(101, 1) NOT NULL,
	[Name] VARCHAR(50) NOT NULL,
	[ManagerID] INT FOREIGN KEY REFERENCES [Teachers]([TeacherId])
	)

INSERT INTO Teachers VALUES
	('John',NULL),
	('Maya',106),
	('Silvia',106),
	('Ted',105),
	('Mark',101),
	('Greta',101)

SELECT * FROM Teachers

--Online Store Database

CREATE TABLE Cities(
	[CityID] INT PRIMARY KEY IDENTITY NOT NULL,
	[Name] VARCHAR(50) NOT NULL
)

CREATE TABLE ItemTypes(
	[ItemTypeID] INT PRIMARY KEY IDENTITY NOT NULL,
	[Name] VARCHAR(50) NOT NULL
)

CREATE TABLE Items(
	[ItemID] INT PRIMARY KEY IDENTITY NOT NULL,
	[Name] VARCHAR(50) NOT NULL,
	[ItemTypeID] INT REFERENCES [ItemTypes](ItemTypeID)
)

CREATE TABLE Customers(
	[CustomersID] INT PRIMARY KEY IDENTITY NOT NULL,
	[Name] VARCHAR(50) NOT NULL,
	[Birthday] DATE NOT NULL,
	[CityID] INT REFERENCES [Cities](CityID)
)

CREATE TABLE Orders(
	[OrderID] INT PRIMARY KEY IDENTITY NOT NULL,
	[CustomerID] INT REFERENCES Customers(CustomersID)
)

CREATE TABLE OrderItems(
	[OrderID] INT REFERENCES [Orders](OrderID),
	[ItemID] INT REFERENCES [Items](ItemID),
	PRIMARY KEY (OrderID, ItemID)
)

--University Database

CREATE TABLE Subjects(
	[SubjectID] INT PRIMARY KEY IDENTITY,
	[SubjectName] NVARCHAR(30) NOT NULL
)

CREATE TABLE Majors(
	[MajorID] INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(30) NOT NULL
)

CREATE TABLE Students(
	[StudentID] INT PRIMARY KEY IDENTITY,
	[StudentNumber] VARCHAR(10),
	[StudentName] NVARCHAR(30),
	[MajorID] INT REFERENCES [Majors](MajorID)
)

CREATE TABLE Payments(
	[PaymentID] INT PRIMARY KEY IDENTITY,
	[PaymentDate] DATETIME2,
	[PaymentAmount] DECIMAL(4,2),
	[StudentID] INT REFERENCES Students(StudentID)
)

CREATE TABLE Agenda(
	[StudentID] INT REFERENCES [Students](StudentID) NOT NULL,
	[SubjectID] INT REFERENCES [Subjects](SubjectID) NOT NULL,
	PRIMARY KEY(StudentID,SubjectID)
)

