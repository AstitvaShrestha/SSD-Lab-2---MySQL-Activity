-- USE LAB2;
-- DROP PROCEDURE IF EXISTS AddSubscriberIfNotExists;

/* changing delimeter to $$, to ensure entire procedure definition is passed as single statement and avoid syntax error */
DELIMITER $$ 

CREATE PROCEDURE AddSubscriberIfNotExists(IN subName VARCHAR(100))
BEGIN
	
    DECLARE msg VARCHAR(255); /* variable to store and print if subscriber already exists or not */

	/* If subscriber already exist print message 'subscriber already exists' */
	IF EXISTS (SELECT *
				FROM  Subscribers
                WHERE SubscriberName = subName) 
		THEN 
        
        SET msg = CONCAT('Subscriber "', subName, '" already exists!');
            
    /* Adds subscriber name and (default value = SubscriberID based on max SubscriberID and today's date as SubscriptionDate) */     
	ELSE
		INSERT INTO Subscribers(SubscriberID, SubscriberName, SubscriptionDate) 
        SELECT COALESCE(MAX(SubscriberID), 0) + 1 , subName, CURDATE()  
        FROM Subscribers;
        
        SET msg = CONCAT('Subscriber "', subName, '" added successfully!')	;
	
    END IF;
    
    SELECT msg AS message; /* printing the message */

END $$

DELIMITER ; /* changing delimeter back to ; */

-- CALL AddSubscriberIfNotExists('Monkey D. Luffy'); /* calling the procedure */