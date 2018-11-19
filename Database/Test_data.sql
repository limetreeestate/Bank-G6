USE bank_demo;
#
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#
#Test Data insertion
#
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#

SET AUTOCOMMIT = 1;
INSERT INTO branch (branch_ID, branch_name, city)
VALUES ('B001', 'branch1', 'city1'), ('B002', 'branch2', 'city2');

INSERT INTO customer (customer_ID, customer_type) VALUES ('C00001', 'Individual'), ('C00002', 'Organization');

INSERT INTO individual (NIC, customer_ID, first_name, last_name, address, DOB)
VALUES ('123456789V', 'C00001', 'John', 'Doe', 'address1', '1996-11-06');

INSERT INTO employee (employee_ID, branch, NIC, first_name, last_name, address, telephone, salary, password)
VALUES ('E00001', 'B001', '987654321V', 'Jack', 'Sehp', 'address2', '0718591422', 25000, 'asd');

INSERT INTO manager (employee_ID) VALUES ('E00001');

UPDATE Branch SET employee_ID = 'E00001' WHERE branch_ID = 'B001';

INSERT INTO account (account_no, customer_ID, branch_ID, balance)
VALUES ('0000000001', 'C00001', 'B001', '100000');

INSERT INTO savings_account_type (account_type, type, interest_rate, minimum)
VALUES ('01', 'Adult', '3.22', '1000.00');

INSERT INTO savings_account (account_no, account_type) VALUES ('1', '01');

INSERT INTO account (account_no, customer_ID, branch_ID, balance)
VALUES ('0000000002', 'C00001', 'B001', '25000');

INSERT INTO current_account (account_no, OD_amount) VALUES ('2', '10000.00');

INSERT INTO fd_type (FD_type, type, interest_rate)
VALUES ('01', '6 month', '13.00'), ('02', '12 month', '14.00'), ('03', '3 month', '15.00');

INSERT INTO fixed_deposit (FD_ID, savings_acc, FD_type) VALUES ('1', '1', '01');

