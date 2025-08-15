DROP PROCEDURE IF EXISTS print_subscribers;
DROP PROCEDURE IF EXISTS ListAllSubscribers;


DELIMITER //
CREATE PROCEDURE print_subscribers(IN sub_name VARCHAR(100))
BEGIN
	SELECT CONCAT('Subscribers: ', sub_name) AS message;
END //

DELIMITER $$
CREATE PROCEDURE ListAllSubscribers()
BEGIN
	DECLARE done INT DEFAULT FALSE;
	DECLARE sub_name VARCHAR(100);
    DECLARE ouput TEXT DEFAULT '';

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
       --  SELECT sub_name as Subscriber;
        -- CALL print_subscribers(sub_name);
         SET output = CONCAT(output, 'Subscribers: ', sub_name, '\n');
 
	END LOOP;
    
	CLOSE cur;
    
    
    SELECT output AS All_Subscribers;
END $$

DELIMITER ;

CALL ListAllSubscribers();