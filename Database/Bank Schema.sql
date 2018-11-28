# noinspection SqlNoDataSourceInspectionForFile

DROP DATABASE IF EXISTS Bank_demo;
CREATE DATABASE Bank_demo;
USE Bank_demo;
#
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
#Schema creation
#
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#

CREATE TABLE Customer (
  customer_ID   VARCHAR(6),
  customer_type ENUM ('Individual', 'Organization'),
  PRIMARY KEY (customer_ID)
);

CREATE TABLE Individual (
  NIC         VARCHAR(10),
  customer_ID VARCHAR(6)   NOT NULL,
  first_name  VARCHAR(20)  NOT NULL,
  last_name   VARCHAR(20)  NOT NULL,
  address     VARCHAR(100) NOT NULL,
  DOB         DATE CHECK (DOB < CURRENT_DATE),

  PRIMARY KEY (NIC),
  FOREIGN KEY (customer_ID) REFERENCES Customer (customer_ID)
);

CREATE TABLE Organization (
  reg_no      VARCHAR(9),
  customer_ID VARCHAR(6)   NOT NULL,
  reg_name    VARCHAR(9)   NOT NULL,
  address     VARCHAR(100) NOT NULL,

  PRIMARY KEY (reg_no),
  FOREIGN KEY (customer_ID) REFERENCES Customer (customer_ID)
);

CREATE TABLE Branch (
  branch_ID   VARCHAR(4),
  branch_name VARCHAR(30) NOT NULL,
  city        VARCHAR(30) NULL,
  employee_ID VARCHAR(6)  NULL,

  PRIMARY KEY (branch_ID)
);

CREATE TABLE Employee (
  employee_ID VARCHAR(6),
  branch      VARCHAR(4)         NOT NULL,
  NIC         VARCHAR(10) UNIQUE NOT NULL,
  first_name  VARCHAR(20)        NOT NULL,
  last_name   VARCHAR(20)        NOT NULL,
  address     VARCHAR(100)       NOT NULL,
  telephone   INT(10)            NOT NULL,
  salary      INT(10)            NOT NULL,

  PRIMARY KEY (employee_ID),
  FOREIGN KEY (branch) REFERENCES Branch (branch_ID)
);

CREATE TABLE Manager (

  employee_ID VARCHAR(6),

  PRIMARY KEY (employee_ID),
  FOREIGN KEY (employee_ID) REFERENCES Employee (employee_ID)
);

ALTER TABLE Branch
  ADD FOREIGN KEY (employee_ID) REFERENCES Manager(employee_ID);

CREATE TABLE Account (
  account_no  INT(10),
  customer_ID VARCHAR(6),
  branch_ID   VARCHAR(4),
  balance     DECIMAL(11, 2) CHECK (balance > 0),

  PRIMARY KEY (account_no),
  FOREIGN KEY (customer_ID) REFERENCES Customer (customer_ID),
  FOREIGN KEY (branch_ID) REFERENCES Branch (branch_ID)
);

CREATE TABLE Savings_Account_Type (
  account_type       VARCHAR(2),
  type          VARCHAR(10),
  interest_rate DECIMAL(4, 2) CHECK (interest_rate >= 0), /*Negative savings account interest rates invalid*/
  minimum       DECIMAL(11, 2) CHECK (minimum > 0),

  PRIMARY KEY (account_type)
);

CREATE TABLE Savings_Account (
  account_no   INT(10),
  account_type VARCHAR(2),

  PRIMARY KEY (account_no),
  FOREIGN KEY (account_no) REFERENCES Account (account_no),
  FOREIGN KEY (account_type) REFERENCES Savings_Account_Type (account_type)
);

CREATE TABLE Current_Account (
  account_no INT(10),
  OD_amount  DECIMAL(11, 2) CHECK (OD_amount >= 0), /*Negative overdraft amounts invalid*/

  PRIMARY KEY (account_no),
  FOREIGN KEY (account_no) REFERENCES Account (account_no)
);

CREATE TABLE FD_Type (
  FD_type       VARCHAR(2),
  type          VARCHAR(10),
  interest_rate DECIMAL(4, 2) CHECK (interest_rate >= 0), /*Negative FD interest rates invalid*/

  PRIMARY KEY (FD_type)
);

CREATE TABLE Fixed_Deposit (
  FD_ID       INT(10),
  savings_acc INT(10),
  FD_type     VARCHAR(2),

  PRIMARY KEY (FD_ID),
  FOREIGN KEY (savings_acc) REFERENCES Savings_Account (account_no),
  FOREIGN KEY (FD_type) REFERENCES FD_Type (FD_type)
);

CREATE TABLE Transaction (
  transaction_ID   VARCHAR(10),
  account_no       INT(10),
  amount           DECIMAL(11, 2) CHECK (amount > 0), /*Non zero or negative transaction amounts are invalid*/
  branch           VARCHAR(4),
  time_stamp       DATETIME CHECK (time_stamp <=
                                   CURRENT_TIMESTAMP ), /*Timestamp should not be after current timestamp*/

  PRIMARY KEY (transaction_ID),
  FOREIGN KEY (account_no) REFERENCES Account (account_no),
  FOREIGN KEY (branch) REFERENCES Branch (branch_ID)
);

CREATE TABLE Withdrawal (
  transaction_ID VARCHAR(10) NOT NULL,

  PRIMARY KEY (transaction_ID),
  FOREIGN KEY (transaction_ID) REFERENCES Transaction (transaction_ID)
);

CREATE TABLE Standard_Withdrawal (
  transaction_ID VARCHAR(10),

  PRIMARY KEY (transaction_ID),
  FOREIGN KEY (transaction_ID) REFERENCES Withdrawal (transaction_ID)
);

CREATE TABLE ATM_Withdrawal (
  transaction_ID VARCHAR(10),
  ATM_ID         VARCHAR(10),

  PRIMARY KEY (transaction_ID),
  FOREIGN KEY (transaction_ID) REFERENCES Withdrawal (transaction_ID)
);

CREATE TABLE Deposit (
  transaction_ID VARCHAR(10) NOT NULL,

  PRIMARY KEY (transaction_ID),
  FOREIGN KEY (transaction_ID) REFERENCES Transaction (transaction_ID)
);

CREATE TABLE Transfer (/*Transfer is identified as a withdrawal from one account and a deposit to another*/
  transfer_ID  VARCHAR(10),
  withdrawal_ID VARCHAR(10),
  deposit_ID   VARCHAR(10),

  PRIMARY KEY (transfer_ID),
  FOREIGN KEY (withdrawal_ID) REFERENCES Withdrawal (transaction_ID),
  FOREIGN KEY (deposit_ID) REFERENCES Deposit (transaction_ID)
);

CREATE TABLE Loan_Request (
  loan_request_ID      VARCHAR(6),
  customer_ID          VARCHAR(6),
  amount               DECIMAL(11, 2) CHECK (amount > 0), /*Negative loan amount invalid*/
  settlement_period    INT(3) /*Unsure*/,
  applicant_income     DECIMAL(11, 2) CHECK (applicant_income > 0), /*Negative applicant income is invalid*/
  applicant_profession VARCHAR(20),
  office_address       VARCHAR(100),

  PRIMARY KEY (loan_request_ID),
  FOREIGN KEY (customer_ID) REFERENCES Customer (customer_ID)
);

CREATE TABLE Loan (
  loan_ID         VARCHAR(6),
  loan_request_ID VARCHAR(6),
  interest_rate   DECIMAL(4, 2) CHECK (interest_rate >= 0), /*Negative loan interest rates invalid*/
  installment     DECIMAL(11, 2) CHECK (installment > 0), /*Negative loan installments invalid*/

  PRIMARY KEY (loan_ID),
  FOREIGN KEY (loan_request_ID) REFERENCES Loan_Request (loan_request_ID)
);

CREATE TABLE Online_Loan (
  loan_ID VARCHAR(6),
  FD_ID   INT(10),

  PRIMARY KEY (loan_ID),
  FOREIGN KEY (loan_ID) REFERENCES Loan (loan_ID),
  FOREIGN KEY (FD_ID) REFERENCES Fixed_Deposit (FD_ID)
);

CREATE TABLE Offline_Loan (
  loan_ID     VARCHAR(6),
  approved_by VARCHAR(6) NOT NULL,
  loan_type   ENUM ('Business', 'Personal'),

  PRIMARY KEY (loan_ID),
  FOREIGN KEY (loan_ID) REFERENCES Loan (loan_ID),
  FOREIGN KEY (approved_by) REFERENCES Manager (employee_ID)
);

CREATE TABLE Login (
  user_ID VARCHAR(6)    PRIMARY KEY,
  username VARCHAR(25)  UNIQUE NOT NULL CHECK (username NOT LIKE '% %'),
  password VARCHAR(40)  NOT NULL
);

CREATE UNIQUE INDEX Login_index ON Login(username);
CREATE UNIQUE INDEX Customer_NIC_index ON Individual(NIC);
CREATE UNIQUE INDEX Customer_reg_no_index ON Organization(reg_no);

#
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
#Trigger declaration
#
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
USE Bank_demo;
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
CREATE TRIGGER user_password_trigger BEFORE INSERT ON Login FOR EACH ROW
  BEGIN
    SET NEW.password = SHA1(NEW.password);
  END $$
DELIMITER ;


#
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
#Atomic transaction declaration
#
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#

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

#
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
#Test Data insertion
#
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#

SET AUTOCOMMIT = 1;
INSERT INTO branch (branch_ID, branch_name, city)
VALUES ('B001', 'branch1', 'city1'),
  ('B002', 'branch2', 'city2');

INSERT INTO customer (customer_ID, customer_type)
VALUES ('C00001', 'Individual'), ('C00002', 'Organization');

INSERT INTO individual (NIC, customer_ID, first_name, last_name, address, DOB)
VALUES ('123456789V', 'C00001', 'John', 'Doe', 'address1', '1996-11-06');

INSERT INTO employee (employee_ID, branch, NIC, first_name, last_name, address, telephone, salary)
VALUES ('E00001', 'B001', '987654321V', 'Jack', 'Sehp', 'address2', '0718591422', 25000);

INSERT INTO manager (employee_ID)
VALUES ('E00001');

UPDATE Branch SET employee_ID = 'E00001' WHERE branch_ID = 'B001';

INSERT INTO account (account_no, customer_ID, branch_ID, balance)
VALUES ('0000000001', 'C00001', 'B001', '100000');

INSERT INTO savings_account_type (account_type, type, interest_rate, minimum)
VALUES ('01', 'Adult', '3.22', '1000.00');

INSERT INTO savings_account (account_no, account_type)
VALUES ('1', '01');

INSERT INTO account (account_no, customer_ID, branch_ID, balance)
VALUES ('0000000002', 'C00001', 'B001', '25000');

INSERT INTO current_account (account_no, OD_amount) VALUES ('2', '10000.00');

INSERT INTO fd_type (FD_type, type, interest_rate)
VALUES ('01', '6 month', '13.00'),
  ('02', '12 month', '14.00'),
  ('03', '3 month', '15.00');

INSERT INTO fixed_deposit (FD_ID, savings_acc, FD_type)
VALUES ('1', '1', '01');



#
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
#View creation
#
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#

CREATE VIEW current_account_view AS
  SELECT *
  FROM account NATURAL JOIN current_account;

CREATE VIEW savings_account_view AS
  SELECT *
  FROM account NATURAL JOIN (savings_account NATURAL JOIN savings_account_type);

CREATE VIEW online_Loan_view AS
  SELECT *
  FROM Loan_Request NATURAL JOIN (Loan NATURAL JOIN Online_loan);

CREATE VIEW offline_loan_view AS
  SELECT *
  FROM Loan_Request NATURAL JOIN (Loan NATURAL JOIN Offline_Loan);

CREATE VIEW branch_view AS
  SELECT Branch.branch_ID, branch_name, city, first_name, last_name, telephone
  FROM (Employee NATURAL JOIN Manager) NATURAL JOIN Branch;

CREATE VIEW transfer_view AS
  SELECT T.transfer_ID AS transfer_ID,
         W.account_no AS from_acc,
         D.account_no AS to_acc,
         W.amount AS amount,
         W.branch AS branch,
         W.time_stamp as time_stamp
  FROM ((Transaction W JOIN Transfer T ON transaction_ID = withdrawal_ID))
         JOIN
           ((Transaction D JOIN Transfer ON transaction_ID = deposit_ID));

#
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
#User account creation
#
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#

DROP USER IF EXISTS 'employee'@'localhost';
DROP USER IF EXISTS 'customer'@'localhost';
DROP USER IF EXISTS 'manager'@'localhost';
DROP USER IF EXISTS 'public'@'localhost';


CREATE USER 'customer'@'localhost' IDENTIFIED BY 'customer123';
CREATE USER 'employee'@'localhost' IDENTIFIED BY 'employee123';
CREATE USER 'manager'@'localhost' IDENTIFIED BY 'manager123';
CREATE USER 'public'@'localhost' IDENTIFIED BY 'public123';

#
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
#Creation of roles
#
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#

DROP ROLE IF EXISTS 'standard_privileges';
DROP ROLE IF EXISTS 'employee_role';

CREATE ROLE 'standard_privileges';
  GRANT EXECUTE ON PROCEDURE standard_withdraw_transaction TO 'standard_privileges';
  GRANT EXECUTE ON PROCEDURE ATM_withdraw_transaction TO 'standard_privileges';
  GRANT EXECUTE ON PROCEDURE deposit_transaction TO 'standard_privileges';
  GRANT EXECUTE ON PROCEDURE transfer_transaction TO 'standard_privileges';
  GRANT EXECUTE ON PROCEDURE online_loan_transaction TO 'standard_privileges';
  GRANT SELECT ON current_account_view TO 'standard_privileges';
  GRANT SELECT ON savings_account_view TO 'standard_privileges';
  GRANT SELECT ON online_Loan_view TO 'standard_privileges';
  GRANT SELECT ON offline_loan_view TO 'standard_privileges';
  GRANT SELECT ON branch_view TO 'standard_privileges';
  GRANT SELECT ON Organization TO 'standard_privileges';
  GRANT SELECT ON Individual TO 'standard_privileges';
  GRANT SELECT ON transfer_view TO 'standard_privileges';
  GRANT SELECT ON ATM_Withdrawal TO 'standard_privileges';
  GRANT SELECT ON Login TO 'standard_privileges';
  GRANT SELECT, INSERT ON Transaction TO 'standard_privileges';
  GRANT SELECT, INSERT ON Withdrawal TO 'standard_privileges';
  GRANT SELECT, INSERT ON Standard_Withdrawal TO 'standard_privileges';
  GRANT SELECT, INSERT ON Deposit TO 'standard_privileges';
  GRANT SELECT, INSERT ON Transfer TO 'standard_privileges';
  GRANT SELECT, INSERT ON Loan_Request TO 'standard_privileges';

CREATE ROLE 'employee_role';
  GRANT 'standard_privileges' TO 'employee_role';
  GRANT INSERT ON Customer TO 'employee_role';
  GRANT INSERT ON Individual TO 'employee_role';
  GRANT INSERT ON Organization TO 'employee_role';
  GRANT INSERT ON Fixed_Deposit TO 'employee_role';
  GRANT INSERT, UPDATE ON Account TO 'employee_role';
  GRANT INSERT, UPDATE ON Savings_Account TO 'employee_role';
  GRANT INSERT, UPDATE ON Current_Account TO 'employee_role';

#
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
#Privilege and role assignment to users
#
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#

#Customer account and privileges
GRANT 'standard_privileges' TO 'customer'@'localhost';

GRANT INSERT ON ATM_Withdrawal TO 'customer'@'localhost';
GRANT INSERT ON Loan TO 'customer'@'localhost';
GRANT INSERT ON Online_loan TO 'customer'@'localhost';
GRANT DELETE ON Loan_Request TO 'customer'@'localhost';


#Non managerial employee account and privileges
GRANT 'employee_role' TO 'employee'@'localhost';

#public account and privileges
GRANT SELECT ON Login TO 'public'@'localhost';


#Manager account and privileges
GRANT 'employee_role' TO 'manager'@'localhost';

GRANT INSERT ON Offline_Loan TO 'manager'@'localhost';
GRANT ALL PRIVILEGES ON Employee TO 'manager'@'localhost';


SET DEFAULT ROLE 'standard_privileges' FOR 'customer'@'localhost';
SET DEFAULT ROLE 'employee_role' FOR 'employee'@'localhost';
SET DEFAULT ROLE 'employee_role' FOR 'employee'@'localhost';


