/*
===========================================================================================================
NOTES
===========================================================================================================

Notes & learnings by Abhishek for reference.
	
------------------------------------------------------------------------------------------------------------

*/


USE master;

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'mydb')			-- Checks if the database 'mydb' exists in system catalog
BEGIN
	ALTER DATABASE mydb SET SINGLE_USER WITH ROLLBACK IMMEDIATE;	-- SINGLE_USER → Ensures only one connection is allowed
																	-- ROLLBACK IMMEDIATE → kicks everyone out instantly
	DROP DATABASE mydb;
END

CREATE DATABASE mydb;

-----------------------------------------------------------------------------------------------------------------------------------
/*

How this works?

| Step                             | What it does          |
| -------------------------------- | --------------------- |
| `ALTER DATABASE ... SINGLE_USER` | Restricts access      |
| `ROLLBACK IMMEDIATE`             | Kills active sessions |
| `DROP DATABASE`                  | Now succeeds          |

-----------------------------------------------------------------------------------------------------------------------------------


BEGIN ... END = grouping multiple statements
In T-SQL:

IF can control only ONE statement by default
If you want to run multiple statements, you must group them

Practical Rule (use this in real work):
| Scenario                | BEGIN...END needed?       |
| ----------------------- | ------------------------- |
| One statement only      | ❌ Optional                |
| More than one statement | ✅ Required                |
| Production code         | ✅ Always safer to include |


*/
-----------------------------------------------------------------------------------------------------------------------------------
