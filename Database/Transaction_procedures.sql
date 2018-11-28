USE bank_demo;


/*METHOD OF CREATING NEW BANK TRANSACTION IDS NOT DEFINED*/
DELIMITER $$


/*Procedure to do a standard withdrawal*/
CREATE PROCEDURE standard_withdraw_transaction(
  t_id VARCHAR(10),
  acc_no INT(10),
  withraw_amount DECIMAL(11,2),
  branch_ID VARCHAR(4) ) MODIFIES SQL DATA
  BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
      BEGIN
        ROLLBACK ;
        SIGNAL SQLSTATE '11111'
        SET MESSAGE_TEXT = 'Withdraw error';
      END;

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

    COMMIT ;

    SET AUTOCOMMIT = 1;

  END $$

/*Procedure to do an ATM withdrawal*/
CREATE PROCEDURE ATM_withdraw_transaction(
  t_id VARCHAR(10),
  acc_no INT(10),
  withraw_amount DECIMAL(11,2),
  branch_ID VARCHAR(4) ) MODIFIES SQL DATA
  BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
      ROLLBACK ;
      SIGNAL SQLSTATE '11112'
      SET MESSAGE_TEXT = 'Withdraw error';
      END;

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

    SET AUTOCOMMIT = 1;

  END $$

/*Procedure to do a deposit*/
CREATE PROCEDURE deposit_transaction(
  t_id VARCHAR(10),
  acc_no INT(10),
  deposit_amount DECIMAL(11,2),
  branch_ID VARCHAR(4) ) MODIFIES SQL DATA
  BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
      BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '11113'
        SET MESSAGE_TEXT = 'Deposit error';
      END;

    SET AUTOCOMMIT = 0;
    START TRANSACTION;

    INSERT INTO Transaction
    VALUES (t_id, acc_no, deposit_amount, branch_ID, CURRENT_TIMESTAMP);

    INSERT INTO Deposit
    VALUES (t_id);

    UPDATE Account
    SET balance = balance + deposit_amount
    WHERE account_no = acc_no;

    COMMIT;

    SET AUTOCOMMIT = 1;

  END $$

/*Procedure to do a transfer*/
CREATE PROCEDURE transfer_transaction(
  trans_ID VARCHAR(10),
  from_transaction VARCHAR(10),
  to_transaction VARCHAR(10),
  from_acc INT(10),
  to_acc INT(10),
  transfer_amount DECIMAL(11,2),
  branch_ID VARCHAR(4) ) MODIFIES SQL DATA
  BEGIN
    DECLARE curr_time TIMESTAMP;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
      BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '11114'
        SET MESSAGE_TEXT = 'Transfer error';
      END;

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

    INSERT INTO Transfer
    VALUES (trans_ID, from_transaction, to_transaction);

    UPDATE Account
    SET balance = balance - transfer_amount
    WHERE account_no = from_acc;

    UPDATE Account
    SET balance = balance + transfer_amount
    WHERE account_no = to_acc;

    COMMIT;

    SET AUTOCOMMIT = 1;

  END $$

/*Procedure to do an online loan (Unsure)*/
CREATE PROCEDURE online_loan_transaction(
  request_ID      VARCHAR(6),
  c_ID          VARCHAR(6),
  loan_amount               DECIMAL(11, 2), /*Negative loan amount invalid*/
  period    INT(3) /*Unsure*/,
  income     DECIMAL(11, 2), /*Negative applicant income is invalid*/
  profession VARCHAR(20),
  office_addr       VARCHAR(100),
  l_ID         VARCHAR(6),
  i_rate   DECIMAL(4, 2), /*Negative loan interest rates invalid*/
  install     DECIMAL(11, 2),
  FDID   INT(10)) MODIFIES SQL DATA
  BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
      BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '11115'
        SET MESSAGE_TEXT = 'Loan error';
      END;

    SET AUTOCOMMIT = 0;
    START TRANSACTION;

    INSERT INTO Loan_request
    VALUES (request_ID, c_ID,loan_amount, period, income, profession, office_addr);

    INSERT INTO Loan
    VALUES (l_ID, request_ID, i_rate, install);

    INSERT INTO Online_Loan
    VALUES (l_ID, FDID);

    COMMIT;

    SET AUTOCOMMIT = 1;

  END $$

DELIMITER ;