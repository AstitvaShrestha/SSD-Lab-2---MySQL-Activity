-- USE LAB2;
-- DROP PROCEDURE IF EXISTS GetWatchHistoryBySubscriber;

DELIMITER $$
CREATE PROCEDURE GetWatchHistoryBySubscriber(IN sub_id INT)
BEGIN
	SELECT a.SubscriberName, b.Title, concat(b.WatchTime, ' mins') as `WatchTime`
    FROM Subscribers AS a
    INNER JOIN
	(SELECT w.SubscriberID, s.Title, w.WatchTime 
    FROM WatchHistory AS w
    INNER JOIN Shows AS s
    ON w.ShowID = s.ShowID
    AND w.SubscriberID = sub_id) AS b
    on a.SubscriberID = b.SubscriberID;
    
END $$

DELIMITER ;

CALL GetWatchHistoryBySubscriber(1);