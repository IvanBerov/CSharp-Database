CREATE DATABASE [Movies]

CREATE TABLE [Directors]
	(
	[Id] INT PRIMARY KEY NOT NULL,
	[DirectorName] NVARCHAR(50) NOT NULL,
	[Notes] NVARCHAR(200)
	)

CREATE TABLE [Genres]
	(
	[Id] INT PRIMARY KEY NOT NULL,
	[GenerName] NVARCHAR(50),
	[Notes] NVARCHAR(200),
	)

CREATE TABLE [Categories]
	(
	[Id] INT PRIMARY KEY NOT NULL,
	[CategoryName] NVARCHAR(50) NOT NULL,
	[Notes] NVARCHAR(200)
	)

CREATE TABLE [Movies]
	(
	[Id] INT PRIMARY KEY NOT NULL,
	[Title] NVARCHAR(50) NOT NULL,
	[DirectorId] INT FOREIGN KEY ([DirectorId]) REFERENCES [Directors](Id),
	[CopyrightYear] DATE NOT NULL,
	[Lenght] INT NOT NULL,
	[GenreId] INT FOREIGN KEY ([GenreId]) REFERENCES [Genres](Id),
	[CategoryId] INT FOREIGN KEY ([CategoryId]) REFERENCES [Categories](Id),
	[Rating] VARCHAR(10),
	[Notes] NVARCHAR(200)
	)
