USE bank_demo;

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


CREATE USER 'customer'@'localhost' IDENTIFIED BY 'customer123';
CREATE USER 'employee'@'localhost' IDENTIFIED BY 'employee123';
CREATE USER 'manager'@'localhost' IDENTIFIED BY 'manager123';

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
  GRANT SELECT ON current_account_view TO 'standard_privileges';
  GRANT SELECT ON savings_account_view TO 'standard_privileges';
  GRANT SELECT ON online_Loan_view TO 'standard_privileges';
  GRANT SELECT ON offline_loan_view TO 'standard_privileges';
  GRANT SELECT ON branch_view TO 'standard_privileges';
  GRANT SELECT ON Organization TO 'standard_privileges';
  GRANT SELECT ON Individual TO 'standard_privileges';
  GRANT SELECT ON transfer_view TO 'standard_privileges';
  GRANT SELECT ON ATM_Withdrawal TO 'standard_privileges';
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


#Manager account and privileges
GRANT 'employee_role' TO 'manager'@'localhost';

GRANT INSERT ON Offline_Loan TO 'manager'@'localhost';
GRANT ALL PRIVILEGES ON Employee TO 'manager'@'localhost';


SET DEFAULT ROLE 'standard_privileges' FOR 'customer'@'localhost';
SET DEFAULT ROLE 'employee_role' FOR 'employee'@'localhost';
SET DEFAULT ROLE 'employee_role' FOR 'employee'@'localhost';