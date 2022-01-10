CREATE DATABASE [CarRental]

CREATE TABLE [Categories](
[Id] INT PRIMARY KEY NOT NULL,
[CategoryName] NVARCHAR(50) NOT NULL,
[DailyRate] DECIMAL(5,2) NOT NULL,
[WeeklyRate] DECIMAL(5,2) NOT NULL,
[MonthlyRate] DECIMAL(5,2) NOT NULL,
[WeekendRate] DECIMAL(5,2) NOT NULL
 )

 CREATE TABLE [Cars](
 [Id] INT PRIMARY KEY NOT NULL,
 [PlateNumber] NVARCHAR(15) NOT NULL,
 [Manufacturer] NVARCHAR(50)NOT NULL,
 [Model] NVARCHAR(20) NOT NULL,
 [CarYear] DATE NOT NULL,
 [CategoryId] INT FOREIGN KEY([CategoryId]) REFERENCES [Categories](Id),
 [Doors] INT NOT NULL,
 [Picture] VARBINARY(MAX),
 [Condition] NVARCHAR(20) NOT NULL,
 [Available] BIT NOT NULL
 )

CREATE TABLE [Employees](
	[Id] INT PRIMARY KEY NOT NULL,
	[FirstName] NVARCHAR(10) NOT NULL,
	[LastName] NVARCHAR(10) NOT NULL,
	[Title] NVARCHAR(20) NOT NULL,
	[Notes] NVARCHAR(200)
)

CREATE TABLE [Customers](
	[Id] INT PRIMARY KEY NOT NULL,
	[DriverLicenceNumber] INT NOT NULL,
	[FullName] NVARCHAR(50) NOT NULL,
	[Address] NVARCHAR(50) NOT NULL,
	[City] NVARCHAR(50) NOT NULL,
	[ZIPCode] INT NOT NULL,
	[Notes] NVARCHAR(200)
)

CREATE TABLE [RentalOrders](
	[Id] INT PRIMARY KEY NOT NULL,
	[EmployeeId] INT FOREIGN KEY([EmployeeId]) REFERENCES [Employees](Id),
	[CustomerId] INT FOREIGN KEY([CustomerId]) REFERENCES [Customers](Id),
	[CarId] INT FOREIGN KEY([CarId]) REFERENCES [Cars](Id),
	[TankLevel] DECIMAL(5,2) NOT NULL,
	[KilometrageStart] INT NOT NULL,
	[KilometrageEnd] INT NOT NULL,
	[TotalKilometrage] INT NOT NULL,
	[StartDate] DATE NOT NULL,
	[EndDate] DATE NOT NULL,
	[TotalDays] INT NOT NULL,
	[RateApplied] DECIMAL(5,2) NOT NULL,
	[TaxRate] DECIMAL(5,2) NOT NULL,
	[OrderStatus] BIT NOT NULL,
	[Notes] NVARCHAR(200)
)

INSERT INTO [Categories]([Id],[CategoryName],[DailyRate],[WeeklyRate],[MonthlyRate],[WeekendRate]) VALUES
	(1,'SMALL',1.23,4.56,5.67,33.50),
	(2,'BIG',2.23,3.56,4.67,22.50),
	(3,'REGULAR',3.23,5.56,8.67,44.50)

INSERT INTO [Cars]([Id],[PlateNumber],[Manufacturer],[Model],[CarYear],[CategoryId],[Doors],[Picture],[Condition],[Available]) VALUES
(1, 'HME863A','HONDA','ACURA','2001-02-04',1,3,NULL,'USED',1),
(2, 'BA678PA','TOYOTA','CELICA','2016-03-01',2,3,NULL,'NEW',1),
(3, 'MT999TA','TESLA','NFS','2020-01-09',3,5,NULL,'NEW',1)

INSERT INTO [Employees]([Id],[FirstName],[LastName],[Title],[Notes]) VALUES
(1,'GENCHO','GENCHEV', 'MladMerinjey', NULL),
(2,'TEMELKO','TEMELKOV', 'StarKosher', NULL),
(3,'IVAN','BEROV', 'BigBossMotherF', NULL)

INSERT INTO [Customers]([Id],[DriverLicenceNumber],[FullName],[Address],[City],[ZIPCode],[Notes]) VALUES
(1, 234323,'BOBI TURBOTO','KATUNA','Pleven', 4800, NULL),
(2, 762334,'MITYO OCHITE','RAPANITE','Varna', 5000, NULL),
(3, 543433,'NATALIA SIMEONOVA','VUHMAIKO','Sofia', 1000, NULL)

INSERT INTO [RentalOrders]([Id],[EmployeeId],[CustomerId],[CarId],[TankLevel],[KilometrageStart],[KilometrageEnd]
,[TotalKilometrage],[StartDate],[EndDate],[TotalDays],[RateApplied],[TaxRate],[OrderStatus],[Notes]) VALUES
(1,1,1,3,40.34,80234,101255,2323,'2007-01-01','2010-01-23',22,6.4,10.1,1,NULL),
(2,2,3,1,35.84,50535,105556,2322,'2008-04-06','2012-02-20',24,6.2,13.1,0,NULL),
(3,1,2,2,60.44,95967,1055669,2345,'2009-01-08','2013-03-15',22,6.4,14.0,1,NULL)