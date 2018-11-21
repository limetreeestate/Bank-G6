USE bank_demo;
#
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
#Trigger declaration
#
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#

/*Check if customer has valid NIC and valid names*/
DELIMITER $$
CREATE TRIGGER check_customer_details BEFORE INSERT ON Individual
  FOR EACH ROW
  BEGIN
    IF (NEW.NIC REGEXP '[0-9]{9}[X|V]') = 0
    THEN
      SIGNAL SQLSTATE '12341'
      SET MESSAGE_TEXT = 'Please enter a valid NIC';
    END IF;
    IF (NEW.first_name REGEXP '[0-9]|[ ]' OR NEW.last_name REGEXP '[0-9]|[ ]') = 1
    THEN
      SIGNAL SQLSTATE '12342'
      SET MESSAGE_TEXT = 'Please enter a valid name';
    END IF;
  END $$
DELIMITER ;

/*Check if employee has valid NIC and valid names*/
DELIMITER $$
CREATE TRIGGER check_employee_details BEFORE INSERT ON Employee
  FOR EACH ROW
  BEGIN
    SET NEW.password = SHA1(NEW.password); #Encrypt employee password with SHA1 encoding
    IF (NEW.NIC REGEXP '[0-9]{9}[X|V]') = 0
    THEN
      SIGNAL SQLSTATE '12343'
      SET MESSAGE_TEXT = 'Please enter a valid NIC';
    END IF;
    IF (NEW.first_name REGEXP '[0-9]|[ ]' OR NEW.last_name REGEXP '[0-9]|[ ]') = 1
    THEN
      SIGNAL SQLSTATE '12345'
      SET MESSAGE_TEXT = 'Please enter a valid name';
    END IF;
  END $$
DELIMITER ;

/*Check if withrawing account has enough balance*/
DELIMITER $$
CREATE TRIGGER check_account_balance_trigger BEFORE INSERT ON Withdrawal
  FOR EACH ROW
  BEGIN
    DECLARE account_balance DECIMAL(11, 2);
    DECLARE withdrawal_amount DECIMAL(11, 2);

    SELECT balance, amount
    INTO account_balance, withdrawal_amount
    FROM Account NATURAL JOIN transaction
    WHERE Transaction.transaction_ID = NEW.transaction_ID;

    IF (account_balance < withdrawal_amount) THEN
      DELETE FROM Transaction WHERE transaction_ID = NEW.transaction_ID; /*Delete parent table record*/
      SIGNAL SQLSTATE '12346'
      SET MESSAGE_TEXT = 'Insufficient account balance';
    END IF;
  END $$
DELIMITER ;

/*Encrypt customer passwords to SHA1*/
DELIMITER $$
CREATE TRIGGER encrypt_customer_password_trigger BEFORE INSERT ON Customer FOR EACH ROW
  BEGIN
    SET NEW.password = SHA1(NEW.password);
  END $$
DELIMITER ;