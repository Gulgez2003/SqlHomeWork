CREATE DATABASE [Location]
USE  [Location]

CREATE TABLE Country(
Id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
CountryName VARCHAR(50)
)
CREATE TABLE City(
Id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
CityName VARCHAR(50),
CountryId INT NOT NULL,
FOREIGN KEY (CountryId) REFERENCES Country(Id)
)
CREATE TABLE Town(
Id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
TownName VARCHAR(50),
CityId INT NOT NULL,
FOREIGN KEY (CityId) REFERENCES City(Id)
)
CREATE TABLE District(
Id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
DistrictName VARCHAR(50),
TownId INT NOT NULL,
FOREIGN KEY (TownId) REFERENCES Town(Id)
)
		
CREATE PROCEDURE sp_CheckAndAddLocation
    @country VARCHAR(50),
    @city VARCHAR(50),
    @town VARCHAR(50),
    @district VARCHAR(50)
AS
BEGIN
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM Country WHERE CountryName = @country)
        BEGIN
            INSERT INTO Country (CountryName)
            VALUES (@country);
        END
        ELSE
        BEGIN
            PRINT 'This country exists in the database';
        END

        IF NOT EXISTS (SELECT 1 FROM City 
                       WHERE CityName = @city AND CountryId IN (SELECT Id FROM Country WHERE CountryName = @country))
        BEGIN
            INSERT INTO City (CityName, CountryId)
            VALUES (@city, (SELECT Id FROM Country WHERE CountryName = @country));
        END
        ELSE
        BEGIN
            PRINT 'This city exists in the database';
        END

        IF NOT EXISTS (SELECT 1 FROM Town 
                       WHERE TownName = @town AND CityId IN (SELECT Id FROM City WHERE CityName = @city))
        BEGIN
            INSERT INTO Town (TownName, CityId)
            VALUES (@town, (SELECT Id FROM City WHERE CityName = @city));
        END
        ELSE
        BEGIN
            PRINT 'This town exists in the database';
        END

        IF NOT EXISTS (SELECT 1 FROM District 
                       WHERE DistrictName = @district AND TownId IN (SELECT Id FROM Town WHERE TownName = @town))
        BEGIN
            INSERT INTO District (DistrictName, TownId)
            VALUES (@district, (SELECT Id FROM Town WHERE TownName = @town));
        END
        ELSE
        BEGIN
            PRINT 'This district exists in the database';
        END
    END TRY
    BEGIN CATCH
        PRINT 'There was an error: ' + ERROR_MESSAGE();
    END CATCH
END


EXECUTE sp_CheckAndAddLocation @country = 'Japan', @city = 'Tokyo', @town = 'Shibuya', @district = 'Harajuku'