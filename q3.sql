-- USE LAB2;
DROP PROCEDURE IF EXISTS AddSubscriberIfNotExists;

DELIMITER $$
CREATE PROCEDURE AddSubscriberIfNotExists(IN subName VARCHAR(100))
BEGIN
	DECLARE msg VARCHAR(255);

	IF EXISTS (SELECT *
				FROM  Subscribers
                WHERE SubscriberName = subName) 
		THEN 
        
        SET msg = CONCAT('Subscriber "', subName, '" already exists!');
            
    -- Adds subscriber name, SubscriberID based on max SubscriberID and today's date as SubscriptionDate        
	ELSE
		INSERT INTO Subscribers(SubscriberID, SubscriberName, SubscriptionDate) 
        SELECT COALESCE(MAX(SubscriberID), 0) + 1 , subName, CURDATE()  
        FROM Subscribers;
        
        SET msg = CONCAT('Subscriber "', subName, '" added successfully!')	;
	
    END IF;
    
    SELECT msg AS message;

END $$

DELIMITER ;

CALL AddSubscriberIfNotExists('Jon Snow');

-- SELECT * FROM Subscribers;
-- SHOW FULL PROCESSLIST;
-- SHOW TRIGGERS WHERE `Table` = 'Subscribers';
