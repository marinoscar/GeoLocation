USE GeoLocation;

LOAD DATA LOCAL INFILE 'C:\\Databases\\GeoLiteCity-Location.csv' INTO TABLE Location
FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 2 LINES;

LOAD DATA LOCAL INFILE 'C:\\Databases\\GeoLiteCity-Blocks.csv' INTO TABLE IpBlocks 
FIELDS TERMINATED BY ','  ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 2 LINES;

UPDATE Location SET 
	CountryCode = REPLACE(CountryCode, '"', ''),
	Region = REPLACE(Region, '"', ''),
	City = REPLACE(City, '"', ''),
	PostalCode = REPLACE(PostalCode, '"', ''),
	AreaCode = REPLACE(AreaCode, '"', ''),
	MetroCode = REPLACE(MetroCode, '"', '');