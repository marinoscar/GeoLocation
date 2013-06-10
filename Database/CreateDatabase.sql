CREATE SCHEMA IF NOT EXISTS GeoLocation DEFAULT CHARACTER SET utf8;

USE GeoLocation;

/*

DROP SCHEMA GeoLocation;

DROP TABLE IpBlocks;
DROP TABLE Location;
DROP TABLE IsoCountry;

CHARACTER SET latin1 COLLATE latin1_spanish_ci

*/

CREATE TABLE IF NOT EXISTS Country(
	CountryId int NOT NULL,
	CountryCode nvarchar(10) NOT NULL,
	CountryName nvarchar(200) NOT NULL,
	CONSTRAINT PK_Country PRIMARY KEY(CountryCode)
);


CREATE TABLE IF NOT EXISTS Location(
	LocationId int NOT NULL,
	CountryCode nvarchar(10) NOT NULL,
	Region nvarchar(100) NULL,
	City nvarchar(100) NULL,
	PostalCode nvarchar(100) NULL,
	Latitude double NOT NULL,
	Longitude double NOT NULL,
	MetroCode nvarchar(100) NULL,
	AreaCode nvarchar(100) NULL,
	
	CONSTRAINT PK_Location PRIMARY KEY (LocationId)
	
);

CREATE TABLE IF NOT EXISTS IpBlocks(
	StartIpNumber bigint NOT NULL,
	EndIpNumber bigint NOT NULL,
	LocationId int NOT NULL,
    CONSTRAINT FK_IpBlocks_Location
	FOREIGN KEY (LocationId) REFERENCES Location (LocationId),
	CONSTRAINT PK_IpBlocks PRIMARY KEY(StartIpNumber, EndIpNumber, LocationId),
	INDEX(StartIpNumber),
	INDEX(EndIpNumber)
);
