CREATE TABLE [People]
	(
	[Id] INT IDENTITY PRIMARY KEY NOT NULL,
	[Name] NVARCHAR(200) NOT NULL,
	[Picture] VARBINARY(MAX),
	CHECK (Picture <= 16000000),
	[Height] DECIMAL(5,2),
	[Weight] DECIMAL(5,2),
	[Gender] CHAR(1) NOT NULL,
	CHECK (Gender = 'm' OR Gender = 'f'),
	[Birthdate] DATE NOT NULL,
	[Biography] NVARCHAR(MAX)
	)

INSERT INTO [People]([Name],Picture,Height,[Weight],Gender,Birthdate,Biography) VALUES
					('Pesho',NULL,1.30,33.55,'m','1988-12-22',NULL),
					('Ivan',Null,3.10,85.55,'m','1989-11-02',Null),
                    ('Mamut',Null,2.55,43.00,'m','1910-05-21','Hallo Moto'),
                    ('Musha',Null,4.25,35.35,'f','2000-1-1','AbraKadabra'),
                    ('Mima',Null,1.85,80.00,'f','1983-05-12','Miauuuu')

