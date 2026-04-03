
/*
===========================================================================================================
CREATE DATABASE & SCHEMAS
===========================================================================================================

Script Purpose:
	This script creates a new database 'DataWarehouse' after checking if it already exists. 

	If the database exists, it is dropped and recreated.

	The script sets up 3 schemas within the database: 'bronze', 'silver' and 'gold'. 

------------------------------------------------------------------------------------------------------------

WARNING!
	Running the script will drop the entire 'DataWarehouse' database if it exists.

	All the data in the database will be permanently deleted.

	Proceed with caution and ensure you have proper backups before running the script.
	
------------------------------------------------------------------------------------------------------------

*/
-- Go to the Master Db
USE master;

-- Create a new Db
CREATE DATABASE DataWarehouse;

-- Go to the newly created Db
USE DataWarehouse;
GO

-- Creating Schemas
CREATE SCHEMA bronze;
GO						--- GO acts as a separator, needed when working in batches, 3 CREATE SCHEMA without GO commands wont execute.

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO


