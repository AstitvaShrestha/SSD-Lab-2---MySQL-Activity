-- USE LAB2;
DROP PROCEDURE IF EXISTS ListAllSubscribers;

/* changing delimeter to $$, to ensure entire procedure definition is passed as single statement and avoid syntax error */
DELIMITER $$ 

CREATE PROCEDURE ListAllSubscribers()
BEGIN
	DECLARE done INT DEFAULT FALSE; /* stores flag to terminate loop when cursor has iterated through the table */
	DECLARE sub_name VARCHAR(100); /* stores sub_name as cursor iterate through the table  */
    
    DECLARE cur CURSOR FOR 
		SELECT SubscriberName FROM Subscribers;
	DECLARE CONTINUE HANDLER FOR NOT FOUND   /* if iteration is finsihed set done flag to true (1) */
		SET done = TRUE;
        
    DROP TEMPORARY TABLE IF EXISTS temp;    
	/* Create temporary table to collect results */
    CREATE TEMPORARY TABLE IF NOT EXISTS temp (
        Subscribers VARCHAR(100)
    );

    /* Clear it in case procedure is called multiple times */
    TRUNCATE temp;
        
	OPEN cur;
		read_loop: LOOP
			FETCH cur INTO sub_name;
			IF done THEN
				LEAVE read_loop;
			END IF;
            
            /* inserting subscriber name in temporary table */
			INSERT INTO temp (Subscribers) VALUES (sub_name); 
		
        END LOOP;
	CLOSE cur;
    
    SELECT * FROM temp; /* printing subscriber name to table */
END $$

DELIMITER ; /* changing delimeter back to ; */

-- CALL ListAllSubscribers(); /* calling the procedure */