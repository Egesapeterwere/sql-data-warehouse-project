/*
===========================================
Create database and Schemas
===========================================
Script purpose :
	this script creates a new database named  'Datawarehouse' after checking if it already exists.
	if the database exists, its is dropped and recreated, Additionally the script sets up three schemas	
	within the database: 'bronze', 'silver', and 'gold'.

WARNING:
	Running this script will drop the entire 'Datawarehouse' database if exists.
	All data in the database will be permanently deleted. proceed with caution
	and ensure you have proper backups before running this script.
*/

USE master;

GO

-- Drop and recreate the 'Datawarehouse' database
IF EXISTS (SELECT 1 FROM sys.database WHERE name = 'Datawarehouse')

BEGIN
	ALTER DATABASE Datawarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE Datawarehouse;
END;
GO

---create the 'Datawarehouse' database
CREATE DATABASE Datawarehosue;
GO

USE Datawarehouse;
GO

---Create Schemas
CREATE SCHEMA bronze ;
GO

CREATE SCHEMA silver ;
GO

CREATE SCHEMA gold ;

