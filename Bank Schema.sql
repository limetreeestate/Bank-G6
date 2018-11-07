# noinspection SqlNoDataSourceInspectionForFile

DROP DATABASE IF EXISTS Bank_demo;
CREATE DATABASE Bank_demo;
USE Bank_demo;

CREATE TABLE Branch (
  branch_ID   VARCHAR(4),
  branch_name VARCHAR(30) NOT NULL,
  city        VARCHAR(30) NOT NULL,

  PRIMARY KEY (branch_ID)
);

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

CREATE TABLE Employee (
  employee_ID VARCHAR(6),
  branch      VARCHAR(4)         NOT NULL,
  NIC         VARCHAR(10) UNIQUE NOT NULL,
  first_name  VARCHAR(20)        NOT NULL,
  last_name   VARCHAR(20)        NOT NULL,
  address     VARCHAR(100)       NOT NULL,
  telephone   INT(10)            NOT NULL,

  PRIMARY KEY (employee_ID),
  FOREIGN KEY (branch) REFERENCES Branch (branch_ID)
);

CREATE TABLE Manager (
  branch      VARCHAR(4),
  employee_ID VARCHAR(6),

  PRIMARY KEY (branch, employee_ID),
  FOREIGN KEY (branch) REFERENCES Branch (branch_ID),
  FOREIGN KEY (employee_ID) REFERENCES Employee (employee_ID)
);

CREATE TABLE Account (
  account_no  INT(10),
  customer_ID VARCHAR(6),
  branch_ID   VARCHAR(4),
  balance     DECIMAL(10, 2), /*Does not check negative balance to handle cases of debt*/

  PRIMARY KEY (account_no),
  FOREIGN KEY (customer_ID) REFERENCES Customer (customer_ID),
  FOREIGN KEY (branch_ID) REFERENCES Branch (branch_ID)
);

CREATE TABLE Savings_Account_Type (
  type_ID       VARCHAR(2),
  type          VARCHAR(10),
  interest_rate DECIMAL(3, 2) CHECK (interest_rate >= 0), /*Negative savings account interest rates invalid*/
  minimum       DECIMAL(10, 2) CHECK (minimum > 0),

  PRIMARY KEY (type_ID)
);

CREATE TABLE Savings_Account (
  account_no   INT(10),
  account_type VARCHAR(2),

  PRIMARY KEY (account_no),
  FOREIGN KEY (account_no) REFERENCES Account (account_no),
  FOREIGN KEY (account_type) REFERENCES Savings_Account_Type (type_ID)
);

CREATE TABLE Current_Account (
  account_no INT(10),
  OD_amount  DECIMAL(10, 2) CHECK (OD_amount >= 0), /*Negative overdraft amounts invalid*/

  PRIMARY KEY (account_no),
  FOREIGN KEY (account_no) REFERENCES Account (account_no)
);

CREATE TABLE FD_Type (
  type_ID       VARCHAR(2),
  type          VARCHAR(10),
  interest_rate DECIMAL(3, 2) CHECK (interest_rate >= 0), /*Negative FD interest rates invalid*/

  PRIMARY KEY (type_ID)
);

CREATE TABLE Fixed_Deposit (
  FD_ID       INT(10),
  savings_acc INT(10),
  FD_type     VARCHAR(2),

  PRIMARY KEY (FD_ID),
  FOREIGN KEY (savings_acc) REFERENCES Savings_Account (account_no),
  FOREIGN KEY (FD_type) REFERENCES FD_Type (type_ID)
);

CREATE TABLE Transaction (
  transaction_ID VARCHAR(10),
  account_no     INT(10),
  amount         DECIMAL(10, 2) CHECK (amount > 0), /*Non zero or negative transaction amounts are invalid*/
  branch         VARCHAR(4),
  time_stamp     DATETIME CHECK (time_stamp <= CURRENT_TIMESTAMP ), /*Timestamp should not be after current timestamp*/

  PRIMARY KEY (transaction_ID),
  FOREIGN KEY (account_no) REFERENCES Account (account_no),
  FOREIGN KEY (branch) REFERENCES Branch (branch_ID)
);

CREATE TABLE Withdrawal (
  transaction_ID VARCHAR(10) NOT NULL,

  PRIMARY KEY (transaction_ID),
  FOREIGN KEY (transaction_ID) REFERENCES Transaction (transaction_ID)
);

CREATE TABLE Deposit (
  transaction_ID VARCHAR(10) NOT NULL,

  PRIMARY KEY (transaction_ID),
  FOREIGN KEY (transaction_ID) REFERENCES Transaction (transaction_ID)
);

CREATE TABLE Transfer (/*Transfer is identified as a withdrawal from one account and a deposit to another*/
  transfer_ID  VARCHAR(10),
  withdrwal_ID VARCHAR(10),
  deposit_ID   VARCHAR(10),

  PRIMARY KEY (transfer_ID),
  FOREIGN KEY (withdrwal_ID) REFERENCES Withdrawal (transaction_ID),
  FOREIGN KEY (deposit_ID) REFERENCES Deposit (transaction_ID)
);

CREATE TABLE ATM_Withdrawals (
  transaction_ID VARCHAR(10),
  ATM_ID         VARCHAR(10),

  PRIMARY KEY (transaction_ID),
  FOREIGN KEY (transaction_ID) REFERENCES Transaction (transaction_ID)
);

CREATE TABLE Loan (
  loan_ID       VARCHAR(6),
  customer_ID   VARCHAR(6),
  interest_rate DECIMAL(3, 2) CHECK (interest_rate >= 0), /*Negative loan interest rates invalid*/
  installment   DECIMAL(10, 2) CHECK (installment > 0), /*Negative loan installments invalid*/

  PRIMARY KEY (loan_ID),
  FOREIGN KEY (customer_ID) REFERENCES Customer (customer_ID)
);

CREATE TABLE Loan_Request (
  loan_ID              VARCHAR(6),
  amount               DECIMAL(10, 2) CHECK (amount > 0), /*Negative loan amount invalid*/
  settlement_period    INT(3) /*Unsure*/,
  applicant_income     DECIMAL(10, 2) CHECK (applicant_income > 0), /*Negative applicant income is invalid*/
  applicant_profession VARCHAR(20),
  office_address       VARCHAR(100),

  PRIMARY KEY (loan_ID),
  FOREIGN KEY (loan_ID) REFERENCES Loan (loan_ID)
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

DELIMITER $$
CREATE TRIGGER check_customer_details
  BEFORE INSERT
  ON Individual
  FOR EACH ROW
  BEGIN
    IF (NEW.NIC REGEXP '[0-9]{9}[X|V]') = 0
    THEN
      SIGNAL SQLSTATE '12341'
      SET MESSAGE_TEXT = 'Please enter a valid NIC';
    END IF;
    IF (NEW.first_name REGEXP '[0-9]|[" "]' OR NEW.last_name REGEXP '[0-9]|[" "]') = 1
    THEN
      SIGNAL SQLSTATE '12342'
      SET MESSAGE_TEXT = 'Please enter a valid name';
    END IF;
  END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER employee_customer_details
  BEFORE INSERT
  ON Employee
  FOR EACH ROW
  BEGIN
    IF (NEW.NIC REGEXP '[0-9]{9}[X|V]') = 0
    THEN
      SIGNAL SQLSTATE '12343'
      SET MESSAGE_TEXT = 'Please enter a valid NIC';
    END IF;
    IF (NEW.first_name REGEXP '[0-9]|[" "]' OR NEW.last_name REGEXP '[0-9]|[" "]') = 1
    THEN
      SIGNAL SQLSTATE '12345'
      SET MESSAGE_TEXT = 'Please enter a valid name';
    END IF;
  END $$
DELIMITER ;