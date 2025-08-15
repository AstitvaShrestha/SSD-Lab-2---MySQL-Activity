-- DROP PROCEDURE IF EXISTS ListAllSubscribers;

DELIMITER $$
CREATE PROCEDURE ListAllSubscribers()
BEGIN
	DECLARE done INT DEFAULT FALSE;
	DECLARE sub_name VARCHAR(100);
    DECLARE output TEXT DEFAULT 'Subscribers: \n';

	DECLARE cur CURSOR FOR
	SELECT SubscriberName FROM Subscribers;
	DECLARE CONTINUE HANDLER FOR NOT FOUND 
		SET done = TRUE;
        
	OPEN cur;
		read_loop: LOOP
			FETCH cur INTO sub_name;
			IF done THEN
				LEAVE read_loop;
			END IF;
			SET output = CONCAT(output, '- ', sub_name, '\n');
	 
		END LOOP;
	CLOSE cur;
    
    SELECT output AS All_Subscribers;
END $$

DELIMITER ;

CALL ListAllSubscribers();