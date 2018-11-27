USE bank_demo;
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

