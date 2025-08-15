USE LAB2;
DROP PROCEDURE IF EXISTS SendWatchTimeReport;

DELIMITER $$
CREATE PROCEDURE SendWatchTimeReport()
BEGIN
	-- DECLARE msg VARCHAR(255);

	DECLARE done INT DEFAULT 0;
    DECLARE sub_id INT;
	
    DECLARE cur CURSOR FOR
        SELECT SubscriberID
        FROM WatchHistory
        GROUP BY SubscriberID
        HAVING COUNT(WatchTime) > 0;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

  --   CREATE TEMPORARY TABLE IF NOT EXISTS temp_report (
--         SubscriberID INT,
--         Title VARCHAR(255),
--         WatchTime INT
--     );

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO sub_id;
        IF done THEN
            LEAVE read_loop;
        END IF;

        CALL GetWatchHistoryBySubscriber(sub_id);
    END LOOP;

    CLOSE cur;

   --  SELECT * FROM temp_report;

--     DROP TEMPORARY TABLE temp_report;

    -- SELECT msg AS message;

    
END $$

DELIMITER ;

CALL SendWatchTimeReport();