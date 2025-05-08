-- Use the NYC_AirQualityDW database
USE NYC_AirQualityDW;
GO

-- Drop tables if they already exist
IF OBJECT_ID('dbo.Staging_Import', 'U') IS NOT NULL DROP TABLE dbo.Staging_Import;
IF OBJECT_ID('dbo.AirQuality_Fact', 'U') IS NOT NULL DROP TABLE dbo.AirQuality_Fact;
IF OBJECT_ID('dbo.Time_Dimension', 'U') IS NOT NULL DROP TABLE dbo.Time_Dimension;
IF OBJECT_ID('dbo.Location_Dimension', 'U') IS NOT NULL DROP TABLE dbo.Location_Dimension;
IF OBJECT_ID('dbo.Indicator_Dimension', 'U') IS NOT NULL DROP TABLE dbo.Indicator_Dimension;
GO

-- Create staging table
CREATE TABLE dbo.Staging_Import (
    Unique_ID INT,
    Indicator_ID INT,
    Name NVARCHAR(255),
    Measure NVARCHAR(50),
    Measure_Info NVARCHAR(255),
    Geo_Type_Name NVARCHAR(50),
    Geo_Join_ID INT,
    Geo_Place_Name NVARCHAR(255),
    Time_Period NVARCHAR(50),
    Start_Date DATE,
    Data_Value FLOAT,
    Message NVARCHAR(MAX)
);
GO

-- Create dimension tables
CREATE TABLE dbo.Time_Dimension (
    Time_Key INT IDENTITY(1,1) PRIMARY KEY,
    Time_Period NVARCHAR(50) NOT NULL,
    Start_Date DATE NOT NULL
);
GO

CREATE TABLE dbo.Location_Dimension (
    Location_Key INT IDENTITY(1,1) PRIMARY KEY,
    Geo_Type_Name NVARCHAR(50) NOT NULL,
    Geo_Join_ID INT NOT NULL,
    Geo_Place_Name NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE dbo.Indicator_Dimension (
    Indicator_Key INT IDENTITY(1,1) PRIMARY KEY,
    Indicator_ID INT NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    Measure NVARCHAR(50) NOT NULL,
    Measure_Info NVARCHAR(255) NOT NULL
);
GO

-- Create fact table
CREATE TABLE dbo.AirQuality_Fact (
    Time_Key INT NOT NULL,
    Location_Key INT NOT NULL,
    Indicator_Key INT NOT NULL,
    Data_Value FLOAT NOT NULL,

    -- Foreign Key Constraints
    FOREIGN KEY (Time_Key) REFERENCES dbo.Time_Dimension(Time_Key),
    FOREIGN KEY (Location_Key) REFERENCES dbo.Location_Dimension(Location_Key),
    FOREIGN KEY (Indicator_Key) REFERENCES dbo.Indicator_Dimension(Indicator_Key)
);
GO

-- Insert data into Staging_Import from Air_Quality source
INSERT INTO dbo.Staging_Import (Unique_ID, Indicator_ID, Name, Measure, Measure_Info, Geo_Type_Name, Geo_Join_ID, Geo_Place_Name, Time_Period, Start_Date, Data_Value, Message)
SELECT 
    Unique_ID,
    Indicator_ID,
    Name,
    Measure,
    Measure_Info,
    Geo_Type_Name,
    Geo_Join_ID,
    Geo_Place_Name,
    Time_Period,
    Start_Date,
    Data_Value,
    Message
FROM dbo.Air_Quality;  -- Replace 'Air_Quality' with the actual name of your source table
GO

-- Insert data into Time Dimension
INSERT INTO dbo.Time_Dimension (Time_Period, Start_Date)
SELECT DISTINCT 
    Time_Period,
    Start_Date
FROM dbo.Staging_Import
WHERE Start_Date IS NOT NULL;
GO

-- Insert data into Location Dimension
INSERT INTO dbo.Location_Dimension (Geo_Type_Name, Geo_Join_ID, Geo_Place_Name)
SELECT DISTINCT 
    Geo_Type_Name,
    Geo_Join_ID,
    Geo_Place_Name
FROM dbo.Staging_Import;
GO

-- Insert data into Indicator Dimension
INSERT INTO dbo.Indicator_Dimension (Indicator_ID, Name, Measure, Measure_Info)
SELECT DISTINCT 
    Indicator_ID,
    Name,
    Measure,
    Measure_Info
FROM dbo.Staging_Import;
GO

-- Insert data into Fact Table
INSERT INTO dbo.AirQuality_Fact (Time_Key, Location_Key, Indicator_Key, Data_Value)
SELECT 
    t.Time_Key,
    l.Location_Key,
    i.Indicator_Key,
    si.Data_Value
FROM dbo.Staging_Import AS si
JOIN dbo.Time_Dimension AS t 
    ON t.Time_Period = si.Time_Period AND t.Start_Date = si.Start_Date
JOIN dbo.Location_Dimension AS l 
    ON l.Geo_Type_Name = si.Geo_Type_Name 
    AND l.Geo_Join_ID = si.Geo_Join_ID 
    AND l.Geo_Place_Name = si.Geo_Place_Name
JOIN dbo.Indicator_Dimension AS i 
    ON i.Indicator_ID = si.Indicator_ID 
    AND i.Name = si.Name;
GO

-- Optional: Clean up the staging table
TRUNCATE TABLE dbo.Staging_Import;

-- Drop Staging_Import table if it exists
IF OBJECT_ID('dbo.Staging_Import', 'U') IS NOT NULL DROP TABLE dbo.Staging_Import;
GO
