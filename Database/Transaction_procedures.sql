USE bank_demo;

DELIMITER $$


/*Procedure to do a standard withdrawal*/
CREATE PROCEDURE standard_withdraw_transaction(
  acc_no INT(10),
  withraw_amount DECIMAL(11,2),
  branch_ID VARCHAR(4) ) MODIFIES SQL DATA
  BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
      BEGIN
        ROLLBACK;
      END;

    DECLARE t_id VARCHAR(10);
    SET t_id = '';

    SET AUTOCOMMIT = 0;
    START TRANSACTION;

    INSERT INTO Transaction
    VALUES (t_id, acc_no, withraw_amount, branch_ID, CURRENT_TIMESTAMP);

    INSERT INTO Withdrawal
    VALUES (t_id);

    INSERT INTO Standard_Withdrawal
    VALUES (t_id);

    UPDATE Account
    SET balance = balance - withraw_amount
    WHERE account_no = acc_no;

    COMMIT;

  END $$

/*Procedure to do an ATM withdrawal*/
CREATE PROCEDURE ATM_withdraw_transaction(
  acc_no INT(10),
  withraw_amount DECIMAL(11,2),
  branch_ID VARCHAR(4) ) MODIFIES SQL DATA
  BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
      BEGIN
        ROLLBACK;
      END;

    DECLARE t_id VARCHAR(10);
    SET t_id = '';

    SET AUTOCOMMIT = 0;
    START TRANSACTION;

    INSERT INTO Transaction
    VALUES (t_id, acc_no, withraw_amount, branch_ID, CURRENT_TIMESTAMP);

    INSERT INTO Withdrawal
    VALUES (t_id);

    INSERT INTO ATM_Withdrawal
    VALUES (t_id, '');

    UPDATE Account
    SET balance = balance - withraw_amount
    WHERE account_no = acc_no;

    COMMIT;

  END $$

/*Procedure to do a deposit*/
CREATE PROCEDURE deposit_transaction(
  acc_no INT(10),
  withraw_amount DECIMAL(11,2),
  branch_ID VARCHAR(4) ) MODIFIES SQL DATA
  BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
      BEGIN
        ROLLBACK;
      END;

    DECLARE t_id VARCHAR(10);
    SET t_id = '';

    SET AUTOCOMMIT = 0;
    START TRANSACTION;

    INSERT INTO Transaction
    VALUES (t_id, acc_no, withraw_amount, branch_ID, CURRENT_TIMESTAMP);

    INSERT INTO Deposit
    VALUES (t_id);

    UPDATE Account
    SET balance = balance + withraw_amount
    WHERE account_no = acc_no;

    COMMIT;

  END $$

/*Procedure to do a transfer*/
CREATE PROCEDURE transfer_transaction(
  from_acc INT(10),
  to_acc INT(10),
  transfer_amount DECIMAL(11,2),
  branch_ID VARCHAR(4) ) MODIFIES SQL DATA
  BEGIN
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
      BEGIN
        ROLLBACK;
      END;

    DECLARE from_transaction VARCHAR(10);
    DECLARE to_transaction VARCHAR(10);
    DECLARE curr_time TIMESTAMP;

    SET from_transaction = '';
    SET to_transaction = '';
    SET curr_time = CURRENT_TIMESTAMP;

    SET AUTOCOMMIT = 0;
    START TRANSACTION;

    INSERT INTO Transaction
    VALUES (from_transaction, from_acc, transfer_amount, branch_ID, curr_time);

    INSERT INTO Transaction
    VALUES (to_transaction, to_acc, transfer_amount, branch_ID, curr_time);

    INSERT INTO Withdrawal
    VALUES (from_transaction);

    INSERT INTO Standard_Withdrawal
    VALUES (from_transaction);

    INSERT INTO Deposit
    VALUES (to_transaction);

    UPDATE Account
    SET balance = balance - transfer_amount
    WHERE account_no = from_acc;

    UPDATE Account
    SET balance = balance + transfer_amount
    WHERE account_no = to_acc;

    COMMIT;

  END $$

DELIMITER ;