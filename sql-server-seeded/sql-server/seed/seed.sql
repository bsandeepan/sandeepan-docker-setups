CREATE DATABASE TestDB
SELECT Name from sys.Databases
GO

USE TestDB
CREATE TABLE Inventory (id INT, name NVARCHAR(50), quantity INT);
INSERT INTO Inventory VALUES (​1, 'banana', 150); INSERT INTO Inventory VALUES (2, 'orange', 154);
GO
