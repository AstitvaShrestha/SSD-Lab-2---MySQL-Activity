-- USE LAB2;
-- DROP PROCEDURE IF EXISTS SubWatchHistory;

/* changing delimeter to $$, to ensure entire procedure definition is passed as single statement and avoid syntax error */
DELIMITER $$

CREATE PROCEDURE SubWatchHistory()
BEGIN
	
	DECLARE done INT DEFAULT 0; /* stores flag to terminate loop when cursor has iterated through the table */
    DECLARE sub_id INT; /* stores sub_id as cursor iterate through the table */
	
    DECLARE cur CURSOR FOR
        SELECT DISTINCT SubscriberID
        FROM Subscribers;

    DECLARE CONTINUE HANDLER FOR NOT FOUND /* if iteration is finsihed set done flag to true (1) */
		SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO sub_id;
        IF done THEN
            LEAVE read_loop;
        END IF;
		
        /* Calling the function for each subscriber with or without any watch time */
        CALL GetWatchHistoryBySubscriber(sub_id);
        
    END LOOP;

    CLOSE cur;
    
END $$

DELIMITER ; /* changing delimeter back to ; */

CALL SubWatchHistory(); /* calling the procedure */