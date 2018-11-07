# noinspection SqlNoDataSourceInspectionForFile

DROP DATABASE IF EXISTS Bank_demo;
CREATE DATABASE Bank_demo;
USE Bank_demo;

CREATE TABLE Branch (
  branch_ID varchar(4),
  branch_name varchar(30),
  city varchar(30),

  PRIMARY KEY (branch_ID)
);

CREATE TABLE Customer (
  customer_ID varchar(6),
  PRIMARY KEY (customer_ID)
);

CREATE TABLE Individual (
  NIC varchar(10),
  customer_ID varchar(6),
  first_name varchar(20),
  last_name varchar(20),
  address varchar(100),
  DOB date CHECK (DOB < CURRENT_DATE),

  PRIMARY KEY (NIC),
  FOREIGN KEY (customer_ID) REFERENCES Customer(customer_ID)
);

CREATE TABLE Organization (
  reg_no varchar(9),
  customer_ID varchar(6),
  reg_name varchar(9),
  address varchar(100),

  PRIMARY KEY (reg_no),
  FOREIGN KEY (customer_ID) REFERENCES Customer(customer_ID)
);

CREATE TABLE Employee (
  employee_ID varchar(6),
  branch varchar(4),
  NIC varchar(10),
  first_name varchar(20),
  last_name varchar(20),
  address varchar(100),
  telephone int(10),

  PRIMARY KEY (employee_ID),
  FOREIGN KEY (branch) REFERENCES Branch(branch_ID)
);

CREATE TABLE Manager (
  branch varchar(4),
  employee_ID varchar(6),

  PRIMARY KEY (branch, employee_ID),
  FOREIGN KEY (branch) REFERENCES Branch(branch_ID),
  FOREIGN KEY (employee_ID) REFERENCES Employee(employee_ID)
);

CREATE TABLE Account (
  account_no int(10),
  customer_ID varchar(6),
  branch_ID varchar(4),
  balance decimal(10,2), /*Does not check negative balance to handle cases of debt*/

  PRIMARY KEY (account_no),
  FOREIGN KEY (customer_ID) REFERENCES Customer(customer_ID),
  FOREIGN KEY (branch_ID) REFERENCES Branch(branch_ID)
);

CREATE TABLE Savings_Account_Type (
  type_ID varchar(2),
  type varchar(10),
  interest_rate decimal(3,2) CHECK (interest_rate >= 0), /*Negative savings account interest rates invalid*/
  minimum decimal(10,2) CHECK (minimum > 0),

  PRIMARY KEY (type_ID)
);

CREATE TABLE Savings_Account (
  account_no int(10),
  account_type varchar(2),

  PRIMARY KEY (account_no),
  FOREIGN KEY (account_no) REFERENCES Account(account_no),
  FOREIGN KEY (account_type) REFERENCES Savings_Account_Type (type_ID)
);

CREATE TABLE Current_Account (
  account_no int(10),
  OD_amount decimal(10,2) CHECK (OD_amount >= 0), /*Negative overdraft amounts invalid*/

  PRIMARY KEY (account_no),
  FOREIGN KEY (account_no) REFERENCES Account(account_no)
);

CREATE TABLE FD_Type (
  type_ID varchar(2),
  type varchar(10),
  interest_rate decimal(3,2) CHECK (interest_rate >= 0), /*Negative FD interest rates invalid*/

  PRIMARY KEY (type_ID)
);

CREATE TABLE Fixed_Deposit (
  FD_ID int(10),
  savings_acc int(10),
  FD_type varchar(2),

  PRIMARY KEY (FD_ID),
  FOREIGN KEY (savings_acc) REFERENCES Savings_Account(account_no),
  FOREIGN KEY (FD_type) REFERENCES FD_Type (type_ID)
);

CREATE TABLE Transaction (
  transaction_ID varchar(10),
  account_no int(10),
  amount decimal(10,2) CHECK (amount > 0), /*Non zero or negative transaction amounts are invalid*/
  branch varchar(4),
  time_stamp datetime CHECK (time_stamp <= CURRENT_TIMESTAMP ), /*Timestamp should not be after current timestamp*/

  PRIMARY KEY (transaction_ID),
  FOREIGN KEY (account_no) REFERENCES Account(account_no),
  FOREIGN KEY (branch) REFERENCES Branch(branch_ID)
);

CREATE TABLE Withdrawal (
  transaction_ID varchar(10) NOT NULL,

  PRIMARY KEY (transaction_ID),
  FOREIGN KEY (transaction_ID) REFERENCES Transaction(transaction_ID)
);

CREATE TABLE Deposit (
  transaction_ID varchar(10) NOT NULL,

  PRIMARY KEY (transaction_ID),
  FOREIGN KEY (transaction_ID) REFERENCES Transaction(transaction_ID)
);

CREATE TABLE Transfer ( /*Transfer is identified as a withdrawal from one account and a deposit to another*/
  transfer_ID varchar(10),
  withdrwal_ID varchar(10),
  deposit_ID varchar(10),

  PRIMARY KEY (transfer_ID),
  FOREIGN KEY (withdrwal_ID) REFERENCES Withdrawal(transaction_ID),
  FOREIGN KEY (deposit_ID) REFERENCES Deposit(transaction_ID)
);

CREATE TABLE ATM_Withdrawals (
  transaction_ID varchar(10),
  ATM_ID varchar(10),

  PRIMARY KEY (transaction_ID),
  FOREIGN KEY (transaction_ID) REFERENCES Transaction(transaction_ID)
);

CREATE TABLE Loan (
  loan_ID varchar(6),
  customer_ID varchar(6),
  interest_rate decimal(3,2) CHECK (interest_rate >= 0), /*Negative loan interest rates invalid*/
  installment decimal(10,2) CHECK (installment > 0), /*Negative loan installments invalid*/

  PRIMARY KEY (loan_ID),
  FOREIGN KEY (customer_ID) REFERENCES Customer(customer_ID)
);

CREATE TABLE Loan_Request (
  loan_ID varchar(6),
  amount decimal(10,2) CHECK (amount > 0), /*Negative loan amount invalid*/
  settlement_period int(3) /*Unsure*/,
  applicant_income decimal(10,2) CHECK (applicant_income > 0), /*Negative applicant income is invalid*/
  applicant_profession varchar(20),
  office_address varchar(100),

  PRIMARY KEY (loan_ID),
  FOREIGN KEY (loan_ID) REFERENCES Loan(loan_ID)
);

CREATE TABLE Online_Loan (
  loan_ID varchar(6),
  FD_ID int(10),

  PRIMARY KEY (loan_ID),
  FOREIGN KEY (loan_ID) REFERENCES Loan(loan_ID),
  FOREIGN KEY (FD_ID) REFERENCES Fixed_Deposit(FD_ID)
);

CREATE TABLE Offline_Loan (
  loan_ID varchar(6),
  approved_by varchar(6),
  loan_type ENUM('Business', 'Personal'),

  PRIMARY KEY (loan_ID),
  FOREIGN KEY (loan_ID) REFERENCES Loan(loan_ID),
  FOREIGN KEY (approved_by) REFERENCES Manager(employee_ID)
);


