-- Use the NYC_AirQualityDW database
USE NYC_AirQualityDW;
GO

-- Drop Tables if they already exist
IF OBJECT_ID('dbo.AirQuality_Fact', 'U') IS NOT NULL DROP TABLE dbo.AirQuality_Fact;
IF OBJECT_ID('dbo.Time_Dimension', 'U') IS NOT NULL DROP TABLE dbo.Time_Dimension;
IF OBJECT_ID('dbo.Location_Dimension', 'U') IS NOT NULL DROP TABLE dbo.Location_Dimension;
IF OBJECT_ID('dbo.Indicator_Dimension', 'U') IS NOT NULL DROP TABLE dbo.Indicator_Dimension;
GO

-- Creating Time Dimension Table
CREATE TABLE Time_Dimension (
    Time_Key INT PRIMARY KEY,
    Time_Period NVARCHAR(50) NOT NULL,
    Start_Date DATE NOT NULL
);
GO

-- Creating Location Dimension Table
CREATE TABLE Location_Dimension (
    Location_Key INT PRIMARY KEY,
    Geo_Type_Name NVARCHAR(50) NOT NULL,
    Geo_Join_ID INT NOT NULL,
    Geo_Place_Name NVARCHAR(100) NOT NULL
);
GO

-- Creating Indicator Dimension Table
CREATE TABLE Indicator_Dimension (
    Indicator_Key INT PRIMARY KEY,
    Indicator_ID INT NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    Measure NVARCHAR(50) NOT NULL,
    Measure_Info NVARCHAR(255) NOT NULL
);
GO

-- Creating Air Quality Fact Table
CREATE TABLE AirQuality_Fact (
    Time_Key INT NOT NULL,
    Location_Key INT NOT NULL,
    Indicator_Key INT NOT NULL,
    Data_Value FLOAT NOT NULL,

    -- Foreign Key Constraints
    FOREIGN KEY (Time_Key) REFERENCES Time_Dimension(Time_Key),
    FOREIGN KEY (Location_Key) REFERENCES Location_Dimension(Location_Key),
    FOREIGN KEY (Indicator_Key) REFERENCES Indicator_Dimension(Indicator_Key)
);
GO
