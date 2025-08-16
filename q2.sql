-- USE LAB2;
-- DROP PROCEDURE IF EXISTS GetWatchHistoryBySubscriber;

/* changing delimeter to $$, to ensure entire procedure definition is passed as single statement and avoid syntax error */
DELIMITER $$ 

CREATE PROCEDURE GetWatchHistoryBySubscriber(IN sub_id INT)
BEGIN

	/* Getting Watch history of given sub id and joining it with Subscribers and Shows table to get SubscriberName and Show Name */
	SELECT a.SubscriberName, COALESCE(b.Title, 'NA') AS `TITLE`, COALESCE(concat(b.WatchTime, ' mins'), 'NA') AS `WatchTime`
    FROM Subscribers AS a
    LEFT JOIN
	(SELECT w.SubscriberID, s.Title, w.WatchTime 
    FROM WatchHistory AS w
    INNER JOIN Shows AS s
    ON w.ShowID = s.ShowID
    AND w.SubscriberID = sub_id) AS b
    on a.SubscriberID = b.SubscriberID
    WHERE a.SubscriberID = sub_id; /* to get the required subscriber details only and print 'NA' incase a subscriber doesn't have a watch history */
    
END $$

DELIMITER ; /* changing delimeter back to ; */

-- CALL GetWatchHistoryBySubscriber(1); /* calling the procedure */