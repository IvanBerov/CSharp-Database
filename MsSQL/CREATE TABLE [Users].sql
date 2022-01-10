CREATE TABLE [Users](
	[Id] BIGINT PRIMARY KEY IDENTITY,
	[Username] VARCHAR(30) UNIQUE NOT NULL,
	[Password] VARCHAR(26),
	[ProfilePicture] VARBINARY(MAX),
	CHECK (DATALENGTH([ProfilePicture]) <= 900000),
	[LastLoginTime] DATETIME2,
	[IsDeleted] BIT NOT NULL
	)

INSERT INTO [Users]([Username],[Password],[ProfilePicture],[LastLoginTime],[IsDeleted]) VALUES
('micho','hgt65t65hh',NULL,'2016-09-26 12:45:37.333',1),
('matyo','1kk45asd67',NULL,'2020-11-18 12:45:37.333',1),
('pesho','34hg567jh6',NULL,'2014-08-18 12:45:37.333',0),
('todor','12hjg67234',NULL,'2000-01-15 12:45:37.333',0),
('matko','iok345asd6',NULL,'2020-05-22 12:45:37.333',0)
