use synthea;
show tables; 

delimiter $$

CREATE TRIGGER LowSystolic BEFORE INSERT ON clinical_data
FOR EACH ROW 
BEGIN
IF NEW.systolic <= 90 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'ERROR: Systolic BP MUST BE ABOVE 90 mg!';
END IF;
END; $$

delimiter ;

INSERT INTO clinical_data (patientUID, lastname, systolic,
diastolic) VALUES (12345, 'Alvin', 80, 60);

DELIMITER $$


CREATE FUNCTION MedicationCost(cost decimal (10,2))
RETURNS varchar(20)
deterministic
BEGIN
	DECLARE drugprice VARCHAR(20);
	IF drugprice >= 750 THEN
		SET MedicationCost = "Expensive";
	ELSEIF (drugprice <750 ) THEN
		SET MedicationCost = 'Cheap';
	END IF;
	RETURN (drugprice);
END$$
DELIMITER ;
