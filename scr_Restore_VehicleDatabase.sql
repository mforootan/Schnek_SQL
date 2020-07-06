
	USE [master];

	-- Edit the paths on the following three lines of code to restore the vehicles sample database

	RESTORE DATABASE Vehicles FROM DISK = 'C:\Vehicles.bak' --Path to Backup File
	WITH MOVE 'Vehicles_Data' TO 'C:\Vehicles_Data.mdf', -- Path to which you want to restore data file
	MOVE 'Vehicles_Log' TO 'C:\Vehicles_Log.ldf', -- Path to which you want to restore log file
	REPLACE; -- Replace Vehicles, if it already exists