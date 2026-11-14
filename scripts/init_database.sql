-- create database 'DataWarehouse'

USE master;
GO

CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- create schemas for bronze, silver and gold layer

CREATE SCHEMA bronze;
GO 
CREATE SCHEMA silver;
GO 
CREATE SCHEMA gold;

-- GO separate batches when working with multiple SQL statements



