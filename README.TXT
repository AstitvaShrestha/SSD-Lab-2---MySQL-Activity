==================================================
             SSD Lab MySQL Activity 2
==================================================

DESCRIPTION:
----------------------------------
This project contains MySQL procedures for managing
subscriber watch history, inserting new subscribers,
and generating reports.

Github Private Repo Link: https://github.com/AstitvaShrestha/SSD-Lab-2---MySQL-Activity


DATABASE DETAILS:
----------------------------------
Database Name : <YourDatabaseName>
Tables Used   : Subscribers, Shows, WatchHistory, etc.


REQUIREMENTS:
----------------------------------
- MySQL Server version 8.4.6 or higher
- MySQL Workbench or terminal client
- User with privileges to CREATE PROCEDURE, etc.


SETUP INSTRUCTIONS:
----------------------------------
1. Open MySQL Workbench or terminal.
2. Create the database (if not already created):
     CREATE DATABASE <YourDatabaseName>;
     USE <YourDatabaseName>;
3. Run the schema script to create required tables.
4. Run the stored procedure definitions from the provided .sql file.


HOW TO RUN PROCEDURES:
----------------------------------

Question 1: Listing all subscribers
    CALL ListAllSubscribers();

Question 2: Getting watch history by subscriber ID
    CALL GetWatchHistoryBySubscriber(1);

Question 3: Adding a subscriber
    CALL AddSubscriber('Jon Snow');

Question 4: Getting watch history for subscribers only if they have watched something 
    CALL SendWatchTimeReport();

Question 5: Getting watch history for all subscriber irrespective of if they have watched something or not
    CALL SubWatchHistory();


ERROR HANDLING:
----------------------------------
- If a subscriber already exists, AddSubscriber will print:
      Subscriber already exists!

- Make sure you drop/recreate procedures if editing:
      DROP PROCEDURE IF EXISTS ProcedureName;


NOTES:
----------------------------------
- Temporary tables are created inside some procedures and are auto-dropped after the session ends.
- Use the terminal if Workbench gives delimiter parsing issues.


AUTHOR:
----------------------------------
<Astitva Shrestha>
<2025201001>